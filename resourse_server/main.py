from typing import Optional

import uvicorn
from fastapi import FastAPI, Body, Query
from starlette.responses import FileResponse
from dotenv import load_dotenv
import psycopg2
import os

from materiallistitem import MaterialType, MaterialListItem, Supplier, Material, MaterialFullView, PaginatedResponse

# https://domen.com/hello

load_dotenv()
app = FastAPI()
conn = psycopg2.connect(
    dbname=os.getenv("DBNAME"),
    user=os.getenv("USER"),
    password=os.getenv("PASSWORD"),
    host=os.getenv("HOST"),
    port=os.getenv("PORT")
)
conn.autocommit = True
cursor = conn.cursor()

select_materials = (f"SELECT m.id, m.name as material_name, t.name as type_name, m.width, m.height, m.image_url, s.name as supplier_name "
                    f"FROM materials as m INNER JOIN types as t ON m.type_id = t.id LEFT JOIN suppliers as s ON m.supplier_id = s.id ")

@app.get("/")
def start_page():
    return "HELLO"

@app.get("/favicon.ico")
async def favicon():
    return FileResponse("logo-metar.ico")

@app.get("/materials/types")
def types_list():
    cursor.execute("SELECT * FROM types;")
    rows = cursor.fetchall()
    return MaterialType.from_list(rows)

@app.get("/suppliers")
def types_list():
    cursor.execute("SELECT id, name FROM suppliers;")
    rows = cursor.fetchall()
    return Supplier.from_list(rows)

@app.get("/materials")
def get_materials(
        type_id: Optional[int] = Query(None, description="ID типа материала"),
        supplier_id: Optional[int] = Query(None, description="ID поставщика"),
        name: Optional[str] = Query(None, description="Название материала для поиска"),
        limit: int = Query(20, ge=1, le=100, description="Лимит результатов"),
        offset: int = Query(0, ge=0, description="Смещение для пагинации"),
):
    conditions = []
    params = []

    if type_id is not None:
        conditions.append("m.type_id = %s")
        params.append(type_id)

    if supplier_id is not None:
        conditions.append("s.id = %s")
        params.append(supplier_id)

    if name is not None:
        conditions.append("m.name ILIKE %s")
        params.append(f'%{name}%')

    sql = select_materials
    if conditions:
        sql += " WHERE " + " AND ".join(conditions)

    sql += " ORDER BY m.id LIMIT %s OFFSET %s;"
    params.extend([limit, offset])

    cursor.execute(sql, params)
    rows = cursor.fetchall()
    res = MaterialListItem.from_list(rows)

    total_count = res.__len__()

    return PaginatedResponse(total_count, offset, res)

@app.get("/materials/{material_id}")
def one_material(material_id: int):
    query = """
            SELECT 
                m.id,
                m.name AS material_name,
                m.width,
                m.height,
                m.image_url,
                t.name AS type_name,
                s.name AS supplier_name,
                s.contact_person,
                s.phone AS supplier_phone,
                s.email AS supplier_email,
                s.address AS supplier_address
            FROM materials m
            INNER JOIN types t ON m.type_id = t.id
            LEFT JOIN suppliers s ON m.supplier_id = s.id
            WHERE m.id = %s;
            """
    cursor.execute(query, (material_id, ))
    return MaterialFullView.from_row(cursor.fetchone())

@app.put("/materials/add")
def material_add(material: Material = Body(embed=True)):
    cursor.execute("INSERT INTO materials "
                   "(name, type_id, width, height, image_url, supplier_id) "
                   "VALUES (%s, %s, %s, $s, %s, %s)",
                   (material.name, material.type_id, material.width, material.height, material.image_url, material.supplier_id))
    return { "result": cursor.rowcount > 0 }

@app.delete("/materials/delete")
def delete_material(material_id: int = Body(embed=True)):
    cursor.execute("DELETE FROM materials WHERE id = %s", (material_id, ))
    return { "result":  cursor.rowcount > 0 }

@app.patch("/materials/patch")
def update_material(new_material : Material = Body(embed=True)):
    cursor.execute("UPDATE materials SET name=%s, type_id=%s, width=%s, height=%s, image_url=%s, supplier_id=%s WHERE id = %s",
                   (new_material.name, new_material.type_id, new_material.width, new_material.height, new_material.image_url, new_material.supplier_id, new_material.id))
    return {"result": cursor.rowcount > 0}

if __name__ == '__main__':
    uvicorn.run(app)

from dataclasses import dataclass
from datetime import datetime
from typing import Optional, List, Any
from pydantic import BaseModel

@dataclass
class PaginatedResponse:
    total: int
    offset: int
    data: Any

class Material(BaseModel):
    id: int
    name: str
    type_id: int
    width: float
    height: float
    image_url: str
    supplier_id: int

    @staticmethod
    def from_row(row):
        return Material(
            id=row[0],
            name=row[1],
            type_id=row[2],
            width=row[3],
            height=row[4],
            image_url=row[5],
            supplier_id=row[6],
        )


@dataclass
class MaterialFullView:
    id: int
    name: str
    width: Optional[float]
    height: Optional[float]
    image_url: Optional[str]

    type_name: str

    supplier_name: Optional[str]
    supplier_contact_person: Optional[str]
    supplier_phone: Optional[str]
    supplier_email: Optional[str]
    supplier_address: Optional[str]

    @staticmethod
    def from_row(row):
        return MaterialFullView(
            id=row[0],
            name=row[1],
            width=row[2],
            height=row[3],
            image_url=row[4],
            type_name=row[5],
            supplier_name=row[6],
            supplier_contact_person=row[7],
            supplier_phone=row[8],
            supplier_email=row[9],
            supplier_address=row[10]
        )

@dataclass
class MaterialListItem:
    id: int
    name: str
    type: str
    width: float
    height: float
    image_url: str
    supplier: str

    @staticmethod
    def from_list(rows):
        materials = []
        for row in rows:
            material = MaterialListItem(
                id=row[0],
                name=row[1],
                type=row[2],
                width=row[3],
                height=row[4],
                image_url=row[5],
                supplier=row[6]
            )
            materials.append(material)

        return materials


@dataclass
class MaterialType:
    id: int
    name: str

    @staticmethod
    def from_list(rows):
        types = []
        for row in rows:
            material_type = MaterialType(
                id=row[0],
                name=row[1]
            )
            types.append(material_type)

        return types

    @staticmethod
    def from_row(row):
        return MaterialType(id = row[1], name=row[2])


@dataclass
class Supplier:
    id: int
    name: str
    contact_person: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None
    address: Optional[str] = None
    created_at: Optional[datetime] = None

    @staticmethod
    def from_list(rows: List[tuple]) -> List['Supplier']:
        suppliers = []
        for row in rows:
            if len(row) >= 6:
                supplier = Supplier(
                    id=row[0],
                    name=row[1],
                    contact_person=row[2],
                    phone=row[3],
                    email=row[4],
                    address=row[5]
                )
                if len(row) >= 7 and row[6] is not None:
                    supplier.created_at = row[6]
                suppliers.append(supplier)
            elif len(row) >= 2:
                supplier = Supplier(
                    id=row[0],
                    name=row[1]
                )
                suppliers.append(supplier)

        return suppliers
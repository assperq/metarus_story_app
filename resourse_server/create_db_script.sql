-- Очистка таблиц (опционально, если нужно перезаписать данные)
-- TRUNCATE TABLE materials CASCADE;
-- TRUNCATE TABLE types CASCADE;
-- Вставка типов материалов (10-15 записей)

CREATE TABLE types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Таблица поставщиков (suppliers)
CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(100),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Таблица материалов (materials)
CREATE TABLE materials (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    type_id INTEGER NOT NULL,
    supplier_id INTEGER,
    width DECIMAL(10, 2),
    height DECIMAL(10, 2),
    image_url TEXT,
    -- Внешние ключи (можно добавить отдельными ALTER TABLE)
    FOREIGN KEY (type_id) REFERENCES types(id) ON DELETE RESTRICT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE SET NULL
);

-- Создание индексов для улучшения производительности (опционально)
CREATE INDEX idx_materials_type_id ON materials(type_id);
CREATE INDEX idx_materials_supplier_id ON materials(supplier_id);

-- Вставка поставщиков
INSERT INTO suppliers (id, name, contact_person, phone, email, address) VALUES
(1, 'ЛесПромСнаб', 'Иванов Петр Сергеевич', '+7 (495) 111-22-33', 'les@lesprom.ru', 'г. Москва, ул. Лесная, д. 15'),
(2, 'МеталлТрейд', 'Сидорова Анна Владимировна', '+7 (812) 222-33-44', 'metal@metalltrade.ru', 'г. Санкт-Петербург, пр. Металлистов, д. 42'),
(3, 'ПолимерГрупп', 'Кузнецов Михаил Алексеевич', '+7 (343) 333-44-55', 'info@polymergroup.ru', 'г. Екатеринбург, ул. Пластмассовая, д. 7'),
(4, 'СтеклоПрофи', 'Петрова Ольга Дмитриевна', '+7 (383) 444-55-66', 'order@stekloprofi.ru', 'г. Новосибирск, пр. Стеклянный, д. 23'),
(5, 'КерамикСтрой', 'Васильев Денис Игоревич', '+7 (861) 555-66-77', 'sales@keramikstroy.ru', 'г. Краснодар, ул. Глиняная, д. 18'),
(6, 'КаменьВек', 'Федорова Екатерина Андреевна', '+7 (391) 666-77-88', 'info@kamenvek.ru', 'г. Красноярск, ул. Гранитная, д. 56'),
(7, 'ТекстильХолдинг', 'Морозова Ирина Сергеевна', '+7 (473) 777-88-99', 'textile@holding.ru', 'г. Воронеж, пр. Ткацкий, д. 31'),
(8, 'БумагаСоюз', 'Григорьев Алексей Петрович', '+7 (843) 888-99-00', 'bumaga@soyuz.ru', 'г. Казань, ул. Бумажная, д. 12'),
(9, 'РезинТех', 'Тихонов Сергей Викторович', '+7 (3812) 999-00-11', 'info@rezintech.ru', 'г. Омск, пр. Резиновый, д. 9'),
(10, 'КожаМастер', 'Белова Марина Олеговна', '+7 (846) 123-45-67', 'koja@master.ru', 'г. Самара, ул. Кожевенная, д. 5'),
(11, 'БетонИндустрия', 'Киселев Артем Денисович', '+7 (3852) 234-56-78', 'beton@industry.ru', 'г. Барнаул, пр. Бетонный, д. 77'),
(12, 'КомпозитМодуль', 'Орлов Павел Николаевич', '+7 (351) 345-67-89', 'composite@module.ru', 'г. Челябинск, ул. Композитная, д. 33'),
(13, 'УниверсалСнаб', 'Антонова Юлия Валерьевна', '+7 (4852) 456-78-90', 'universal@snаб.ru', 'г. Ярославль, пр. Центральный, д. 100'),
(14, 'ЕвропаСтройМатериалы', 'Давыдов Константин Ильич', '+7 (343) 567-89-01', 'europa@stroymat.ru', 'г. Екатеринбург, ул. Европейская, д. 25'),
(15, 'БазаСнаб', 'Тарасова Надежда Михайловна', '+7 (495) 678-90-12', 'baza@snаб.ru', 'г. Москва, ул. Складская, д. 3');

-- Вставка типов материалов (12 записей)
INSERT INTO types (id, name) VALUES
(1, 'Дерево'),
(2, 'Металл'),
(3, 'Пластик'),
(4, 'Стекло'),
(5, 'Керамика'),
(6, 'Камень'),
(7, 'Ткань'),
(8, 'Бумага'),
(9, 'Резина'),
(10, 'Кожа'),
(11, 'Бетон'),
(12, 'Композит');

-- Вставка материалов с привязкой к поставщикам (по type_id)
INSERT INTO materials (id, name, type_id, width, height, image_url, supplier_id) VALUES
-- Дерево (type_id = 1, supplier_id = 1)
(1, 'Сосна', 1, 10, 2, 'https://oknabau.ru/wp-content/uploads/2020/02/05-sosna.jpg', 1),
(2, 'Дуб', 1, 15, 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIVLpQWI-xV8_VH_K6fsytih7pAz3T4OYe0Q&s', 1),

-- Металл (type_id = 2, supplier_id = 2)
(6, 'Сталь', 2, 100, 50, 'https://vt-metall.ru/upload/medialibrary/36a/kjgkimb6d7jc8sa5mrnjk3m6fagz71xu.jpeg', 2),
(7, 'Алюминий', 2, 120, 60, 'https://www.metall-ruskon.ru/upload/iblock/9a2/2554cye0v4woymrh7c1f6qnaxn3kyeat.jpg', 2),

-- Пластик (type_id = 3, supplier_id = 3)
(11, 'Полиэтилен', 3, 50, 50, 'https://xn--90adhucsy.xn--p1ai/upload/iblock/5cf/5cfc5e1765fd8059672fd23aa4a90e98.jpg', 3),
(12, 'Полипропилен', 3, 60, 60, 'https://epolymer.ru/files/styles/900/public/image/49.jpg?itok=3Xc4hQ8A', 3),

-- Стекло (type_id = 4, supplier_id = 4)
(16, 'Органическое стекло', 4, 100, 200, 'https://st20.stpulscen.ru/images/product/310/925/210_original.jpg', 4),
(17, 'Закаленное стекло', 4, 120, 240, 'https://static.tildacdn.com/tild6539-6130-4537-b065-306231363934/tempered-glass_.jpg', 4),

-- Керамика (type_id = 5, supplier_id = 5)
(21, 'Керамическая плитка', 5, 30, 30, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQws1Pyg2WHGieHn9DU58AvrVbSWGeT1Q5GLg&s', 5),
(22, 'Фарфор', 5, 25, 25, 'https://svp.one/wp-content/uploads/farforovie_pliti_2.jpg', 5),

-- Камень (type_id = 6, supplier_id = 6)
(26, 'Гранит', 6, 200, 100, 'https://stoneplanet.ru/d/mansurovskij_granit_prodazha.jpg', 6),
(27, 'Мрамор', 6, 180, 90, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIKlYTzOAvlDRn9CP9cZ0jAEdtIbYPjH1S2Q&s', 6),

-- Ткань (type_id = 7, supplier_id = 7)
(31, 'Хлопок', 7, 150, 300, 'https://lavistatextile.ru/upload/medialibrary/a4b/zb22hhczfj8j5ccyfm4pc33oxr6mnqar.jpg', 7),
(32, 'Лен', 7, 140, 280, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNVU0uUACOITAs-2CPVNygp3CWIeYlJ7yKtw&s', 7),

-- Бумага (type_id = 8, supplier_id = 8)
(36, 'Офсетная бумага', 8, 70, 100, 'https://poligraftorg.ru/assets/images/products/1804/product/ofsetnaya-n1-1.jpg', 8),
(37, 'Мелованная бумага', 8, 80, 110, 'https://yarus-market.ru/image/cache/data-bumazhnye-kraft-pakety-00-kraft-bumaga-pergament-podpergament-prodazha-06-bumaga-melovannaya-90-300-gm2-1-600x600.jpg', 8),

-- Резина (type_id = 9, supplier_id = 9)
(41, 'Натуральный каучук', 9, 100, 100, 'https://www.inpolimer.ru/images/933.jpg', 9),
(42, 'Силикон', 9, 110, 110, 'https://www.izolit-spb.ru/upload/iblock/177/17710e387168b71976e6e43f675c28e3.jpg', 9),

-- Кожа (type_id = 10, supplier_id = 10)
(46, 'Натуральная кожа', 10, 150, 150, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGzICQl3kUhulHqIA4lYETcwnY6aXDD9MuGg&s', 10),
(47, 'Замша', 10, 140, 140, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCdzQXKZgaD0zppRDGtMi0GxFuOyHuq9Xjnw&s', 10),

-- Бетон (type_id = 11, supplier_id = 11)
(51, 'Тяжелый бетон', 11, 500, 300, 'https://promtech33.ru/images/tyazshelii_beton/4.png', 11),
(52, 'Легкий бетон', 11, 450, 250, 'https://oz-gbi.ru/upload/resize_cache/webp/medialibrary/448/448b6a1ba6a91003f3c07d3f6d56ef26.webp', 11),

-- Композит (type_id = 12, supplier_id = 12)
(56, 'ДСП', 12, 250, 180, 'https://www.fcase.ru/thumb/2/yZtQIkk1dA-a657l-BprxQ/r/d/dsp-1.jpg', 12),
(57, 'МДФ', 12, 240, 170, 'https://brw-shop.by/upload/iblock/112/82fdp2rdhqxf07dlvlsdjbrvkiyvtlc1.jpg', 12),

-- Дополнительные материалы с разными поставщиками
(61, 'Клен', 1, 14, 2.8, 'https://zawood.ru/upload/resize_cache/iblock/8c6/1024_1024_1bbfd59725d560fabb91c94d3a18e0f82/bstz73rc5xupdo3vqzgc2lo1p4c3rnb8.png', 13),
(62, 'Ольха', 1, 11, 2.2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsM9I08ZxTE0IR6Jo0ZDNzxbluCFBabDHDfQ&s', 13),
(63, 'Титан', 2, 95, 48, 'https://ekoproekt-kr.ru/images/photo_2024-07-02_20-02-23.jpg', 14),
(64, 'Бронза', 2, 85, 42, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8nRUeuMwM39wDqCFObDP4_rHv3gmENz3o8w&s', 14),
(65, 'Нейлон', 3, 65, 65, 'https://cdn.star-tex.ru/unsafe/550x683/center/https://star-tex.ru/media/items/bds-0462_xqpo0L2.webp', 13);




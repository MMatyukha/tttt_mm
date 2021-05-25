ALTER TABLE shop.country ADD CONSTRAINT country_FK FOREIGN KEY (id) REFERENCES shop.manufactured(id) ON DELETE CASCADE;
ALTER TABLE shop.warehouse ADD CONSTRAINT warehouse_FK FOREIGN KEY (id) REFERENCES shop.warehouse_goods(id) ON DELETE CASCADE;
ALTER TABLE shop.goods ADD CONSTRAINT goods_FK FOREIGN KEY (id) REFERENCES shop.warehouse_goods(id) ON DELETE CASCADE;
ALTER TABLE shop.goods ADD CONSTRAINT goods_FK_1 FOREIGN KEY (catalog_id) REFERENCES shop.catalogs(id) ON DELETE CASCADE;
ALTER TABLE shop.goods ADD CONSTRAINT goods_FK_2 FOREIGN KEY (id) REFERENCES shop.discounts(id) ON DELETE CASCADE;
ALTER TABLE shop.goods ADD CONSTRAINT goods_FK_3 FOREIGN KEY (manufactured_id) REFERENCES shop.manufactured(id);
ALTER TABLE shop.orders_products ADD CONSTRAINT orders_products_FK FOREIGN KEY (goods_id) REFERENCES shop.goods(id) ON DELETE CASCADE;
ALTER TABLE shop.orders ADD CONSTRAINT orders_FK FOREIGN KEY (delivery_id) REFERENCES shop.delivery(id) ON DELETE CASCADE;
ALTER TABLE shop.orders ADD CONSTRAINT orders_FK_1 FOREIGN KEY (id) REFERENCES shop.orders_products(id) ON DELETE CASCADE;
ALTER TABLE shop.customers ADD CONSTRAINT customers_FK FOREIGN KEY (id) REFERENCES shop.orders(id) ON DELETE CASCADE;




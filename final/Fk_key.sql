ALTER TABLE shop.manufactured ADD CONSTRAINT manufactured_FK FOREIGN KEY (id_country) REFERENCES shop.country(id) ON DELETE CASCADE;
ALTER TABLE shop.warehouse ADD CONSTRAINT warehouse_FK FOREIGN KEY (id) REFERENCES shop.warehouse_good(id) ON DELETE CASCADE;
ALTER TABLE shop.good ADD CONSTRAINT good_FK FOREIGN KEY (id) REFERENCES shop.warehouse_good(id) ON DELETE CASCADE;
ALTER TABLE shop.good ADD CONSTRAINT good_FK_1 FOREIGN KEY (catalog_id) REFERENCES shop.catalog(id) ON DELETE CASCADE;
ALTER TABLE shop.good ADD CONSTRAINT good_FK_2 FOREIGN KEY (id) REFERENCES shop.discount(id) ON DELETE CASCADE;
ALTER TABLE shop.good ADD CONSTRAINT good_FK_3 FOREIGN KEY (manufactured_id) REFERENCES shop.manufactured(id);
ALTER TABLE shop.order_product ADD CONSTRAINT order_product_FK FOREIGN KEY (good_id) REFERENCES shop.good(id) ON DELETE CASCADE;
ALTER TABLE shop.order ADD CONSTRAINT order_FK FOREIGN KEY (delivery_id) REFERENCES shop.delivery(id) ON DELETE CASCADE;
ALTER TABLE shop.order ADD CONSTRAINT order_FK_1 FOREIGN KEY (id) REFERENCES shop.order_product(id) ON DELETE CASCADE;
ALTER TABLE shop.order ADD CONSTRAINT order_customer_FK FOREIGN KEY (customer_id) REFERENCES shop.customer(id) ON DELETE CASCADE;
ALTER TABLE shop.discount ADD CONSTRAINT discount_FK_2 FOREIGN KEY (customer_id) REFERENCES shop.customer(id) ON DELETE CASCADE;



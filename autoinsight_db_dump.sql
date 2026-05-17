PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE users (
	id UUID NOT NULL, 
	email VARCHAR(255) NOT NULL, 
	hashed_password VARCHAR(255) NOT NULL, 
	full_name VARCHAR(200), 
	avatar_url VARCHAR(500), 
	is_active BOOLEAN NOT NULL, 
	created_at DATETIME NOT NULL, 
	updated_at DATETIME NOT NULL, 
	PRIMARY KEY (id)
);
INSERT INTO users VALUES('dc3397ecdb2d4185ade0f660313cc189','superadmin@example.com','$2b$12$9lfb35AQ7MqAXoY72PC7U./mIhtT2oAEJ7LvVY8jlYsIDPFYA2xZS','System Super Admin',NULL,1,'2026-05-17 17:09:40.392190','2026-05-17 17:09:40.392195');
INSERT INTO users VALUES('d6f64c9048e24efb818d5787bdd5d704','admin@example.com','$2b$12$7IagII82NPbVVq/hxj3qQOcgTgyyBGJjr64yk031urFpx35AldP2O','System Admin',NULL,1,'2026-05-17 17:09:40.630341','2026-05-17 17:09:40.630348');
INSERT INTO users VALUES('16429673e6e7471ca7ffe3f12e0a45ab','client@example.com','$2b$12$TVumiNrBCuG5Pbe3f3PGduQ4zvtKW41J61aTsIt6LRSr6ZT8c3AOm','Sample Client User',NULL,1,'2026-05-17 17:09:40.884183','2026-05-17 17:09:40.884188');
CREATE TABLE roles (
	id UUID NOT NULL, 
	name VARCHAR(50) NOT NULL, 
	description TEXT, 
	PRIMARY KEY (id)
);
INSERT INTO roles VALUES('062eae53eacf48b2a58496df8e4040c4','super_admin','Super_admin Role');
INSERT INTO roles VALUES('e0b1ed518aa24efb90baa54ec3336ba6','admin','Admin Role');
INSERT INTO roles VALUES('a3f72784e87f4349ad98c76d191d3199','client','Client Role');
CREATE TABLE user_roles (
	id UUID NOT NULL, 
	user_id UUID NOT NULL, 
	role_id UUID NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(user_id) REFERENCES users (id) ON DELETE CASCADE, 
	FOREIGN KEY(role_id) REFERENCES roles (id) ON DELETE CASCADE
);
INSERT INTO user_roles VALUES('54c2ded884484f28bfefaec61bb2e838','dc3397ecdb2d4185ade0f660313cc189','062eae53eacf48b2a58496df8e4040c4');
INSERT INTO user_roles VALUES('91622052235a432eadcc722c11c7ecd3','d6f64c9048e24efb818d5787bdd5d704','e0b1ed518aa24efb90baa54ec3336ba6');
INSERT INTO user_roles VALUES('40c7bffe9bc94542900ba8e087eccb39','16429673e6e7471ca7ffe3f12e0a45ab','a3f72784e87f4349ad98c76d191d3199');
CREATE TABLE user_settings (
	id UUID NOT NULL, 
	user_id UUID NOT NULL, 
	theme VARCHAR(10) NOT NULL, 
	email_marketing BOOLEAN NOT NULL, 
	email_price_alerts BOOLEAN NOT NULL, 
	email_product_updates BOOLEAN NOT NULL, 
	updated_at DATETIME NOT NULL, 
	PRIMARY KEY (id), 
	UNIQUE (user_id), 
	FOREIGN KEY(user_id) REFERENCES users (id) ON DELETE CASCADE
);
INSERT INTO user_settings VALUES('6b4a78a5beef40d680498647b5203607','dc3397ecdb2d4185ade0f660313cc189','dark',1,1,1,'2026-05-17 17:09:40.393531');
INSERT INTO user_settings VALUES('0fa9aee3475f4887bdec589f8011952d','d6f64c9048e24efb818d5787bdd5d704','dark',1,0,1,'2026-05-17 17:15:18.916374');
INSERT INTO user_settings VALUES('4046fd17d09641c78563f8707811961c','16429673e6e7471ca7ffe3f12e0a45ab','light',1,1,1,'2026-05-17 17:09:40.884840');
CREATE UNIQUE INDEX ix_users_email ON users (email);
CREATE UNIQUE INDEX ix_roles_name ON roles (name);
COMMIT;

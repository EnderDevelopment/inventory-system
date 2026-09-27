CREATE TABLE IF NOT EXISTS inventory_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(60) NOT NULL,
    item VARCHAR(50) NOT NULL,
    count INT NOT NULL,
    FOREIGN KEY (identifier) REFERENCES users(identifier)
);

INSERT INTO inventory_items (identifier, item, count) VALUES
    ('char1', 'bread', 5),
    ('char1', 'water', 5);
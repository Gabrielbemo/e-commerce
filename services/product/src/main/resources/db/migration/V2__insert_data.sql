INSERT INTO category (id, description, name)
VALUES
(1, 'Eletrônicos e dispositivos', 'Eletrônicos'),
(2, 'Livros e materiais de leitura', 'Livros'),
(3, 'Acessórios de informática', 'Informática'),
(4, 'Alimentos e bebidas', 'Alimentos'),
(5, 'Ferramentas e equipamentos', 'Ferramentas'),
(6, 'Brinquedos e jogos', 'Brinquedos'),
(7, 'Saúde e beleza', 'Saúde'),
(8, 'Esportes e lazer', 'Esportes'),
(9, 'Casa e decoração', 'Casa'),
(10, 'Automóveis e acessórios', 'Automóveis');

INSERT INTO product (id, description, name, available_quantity, price, category_id)
VALUES
(1, 'Notebook com processador Intel Core i7 e 16GB de RAM', 'Notebook', 20, 4500.00, 3),
(2, 'Mouse gamer RGB com sensor de alta precisão', 'Mouse Gamer', 50, 150.00, 3),
(3, 'Teclado mecânico retroiluminado', 'Teclado Mecânico', 30, 300.00, 3),
(4, 'Monitor LED Full HD de 24 polegadas', 'Monitor Full HD', 15, 800.00, 3),
(5, 'Headset com microfone e som surround 7.1', 'Headset Gamer', 40, 250.00, 3),
(6, 'Placa de vídeo NVIDIA GeForce RTX 3060', 'Placa de Vídeo', 10, 2800.00, 3),
(7, 'SSD de 1TB NVMe de alta velocidade', 'SSD 1TB', 25, 600.00, 3),
(8, 'Gabinete ATX com painel de vidro temperado', 'Gabinete ATX', 18, 350.00, 3),
(9, 'Fonte de alimentação 650W com certificação 80 Plus Gold', 'Fonte 650W', 22, 400.00, 3),
(10, 'Cadeira gamer ergonômica com ajuste de altura', 'Cadeira Gamer', 12, 1200.00, 3);

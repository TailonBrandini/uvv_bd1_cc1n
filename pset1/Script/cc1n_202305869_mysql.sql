
--Excluindo o banco de dados uvv e o usuario tailon, caso existam.

DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS 'tailon'@'localhost';

   /*Criando usuario tailon, com senha 'abrantesdaponto', o banco de
        dados 'uvv', e permitindo todos os privilégios do banco para tailon.*/
        
CREATE USER 'tailon'@'localhost'
IDENTIFIED BY 'abrantesdaponto';
 

CREATE DATABASE uvv;
GRANT ALL PRIVILEGES ON uvv.* TO 'tailon'@'localhost';
FLUSH PRIVILEGES;

--Entrando no banco de dados uvv

USE uvv;

--Criando tabela "produtos"

CREATE TABLE produtos (
           produto_id                    NUMERIC(38)        NOT NULL ,
           nome                          VARCHAR(255)       NOT NULL ,
           preco_unitario                NUMERIC(10,2)               ,
           detalhes LONGBLOB                                         ,    
           imagem LONGBLOB                                           ,
           imagem_mime_type              VARCHAR(512)                ,
           imagem_arquivo                VARCHAR(512)                ,
           imagem_charset                VARCHAR(512)                ,
           imagem_ultima_atualizacao     DATE                        ,
                                              PRIMARY KEY (produto_id)
);

ALTER TABLE produtos COMMENT

              'A tabela "produtos" irá armazenar informações
               sobre os produtos, como identificador exclusivo,
               os preços, detalhes, imagens';

ALTER TABLE produtos MODIFY COLUMN produto_id NUMERIC(38) COMMENT

                   'A coluna "produto_id" tem por função identificar
                    unicamente cada produto, e portanto é uma PK.';

ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(255) COMMENT

              'A coluna "nome" vai guardar o nome de cada produto da loja.';

ALTER TABLE produtos MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT

   'A coluna "preco_unitario" vai informar o preço por unidade de cada produto.';

ALTER TABLE produtos MODIFY COLUMN detalhes BLOB COMMENT

        'A coluna "detalhes" irá guardar alguns detalhes sobre os produtos.';

ALTER TABLE produtos MODIFY COLUMN imagem BLOB COMMENT

                      'A coluna "imagem" irá armazenar as imagens dos
                      produtos das lojas, não sendo obrigatórios';

ALTER TABLE produtos MODIFY COLUMN imagem_mime_type VARCHAR(512) COMMENT

                     'A coluna "imagem_mime_type" vai guardar qual
                        o tipo de arquivo da imagem.';

ALTER TABLE produtos MODIFY COLUMN imagem_arquivo VARCHAR(512) COMMENT

                    'A coluna "imagem_arquivo" vai armazenar os dados em
                    formato de imagem, tendo seus usos específicos e
                    características prṕrias.';

ALTER TABLE produtos MODIFY COLUMN imagem_charset VARCHAR(512) COMMENT

         'A imagem_charset vai armazenar os caracteres para exibir a imagem.';

ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao DATE COMMENT

               'A coluna "imagem_ultima_atualizacao" irá guardar a data da
                ultima atualização nos arquivos da imagem.';


CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo LONGBLOB,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                PRIMARY KEY (loja_id)
);

ALTER TABLE lojas COMMENT

          'A tabela "lojas" vai armazenar as informações da lojas,
           como nome, endereço web, fisico, latitude, longitude, logo,
           etc, a fim de ter as informações que precisem sobre cada loja.';

ALTER TABLE lojas MODIFY COLUMN loja_id NUMERIC(38) COMMENT

                'A coluna "loja_id"  serve para identificar cada uma
                loja exclusivamente, sendo esta uma Primary Key(PK).';

ALTER TABLE lojas MODIFY COLUMN nome VARCHAR(255) COMMENT

                'A coluna "nome" vai guardar o nome de cada loja, e não
                 pode ser nula.';

ALTER TABLE lojas MODIFY COLUMN endereco_web VARCHAR(100) COMMENT

                   'A coluna "endereco_web" será utilizada para armazenar
                    o endereço web do site de cada loja.';

ALTER TABLE lojas MODIFY COLUMN endereco_fisico VARCHAR(512) COMMENT

                     'A coluna "endereco_fisico" irá guardar o
                     endereço físico de cada loja.';

ALTER TABLE lojas MODIFY COLUMN latitude NUMERIC COMMENT

            'Esta coluna indicara em qual latitude a empresa se encontra.';

ALTER TABLE lojas MODIFY COLUMN longitude NUMERIC COMMENT

                 'A coluna "longitude" vai armazenar a longitude de cada
                   loja, em formato numerico.';

ALTER TABLE lojas MODIFY COLUMN logo BLOB COMMENT

                  'A coluna "logo" irá armazenar a logo de cada loja,
                  ajudando a identificar visualmente cada loja.';

ALTER TABLE lojas MODIFY COLUMN logo_mime_type VARCHAR(512) COMMENT

     'Essa coluna vai indicar qual vai ser o tipo de arquivo da logo.';

ALTER TABLE lojas MODIFY COLUMN logo_arquivo VARCHAR(512) COMMENT

             'A coluna "logo_arquivo" irá guardar a imagem da logo.';

ALTER TABLE lojas MODIFY COLUMN logo_charset VARCHAR(512) COMMENT

           'A coluna "logo_charset" vai armazenar os caracteres para
            exibir a imagem da logo.';

ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE COMMENT

                    'A coluna "logo_ultima_atualizacao" vai armazenar a
                    data ultima atualização da logo.';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                PRIMARY KEY (estoque_id)
);

ALTER TABLE estoques COMMENT

          'A tabela "estoques" vai servir para atualizar a quantidade
          de produtos existentes em cada loja.';

ALTER TABLE estoques MODIFY COLUMN estoque_id NUMERIC(38) COMMENT

             'A coluna "estoque_id" vai servir como identificador único
             desta tabela, sendo assim, uma Primary Key(PK),';

ALTER TABLE estoques MODIFY COLUMN loja_id NUMERIC(38) COMMENT

                   'A coluna "loja_id" é uma FK da tabela "lojas", e
                   serve para identificar sobre qual loja está informando.';

ALTER TABLE estoques MODIFY COLUMN produto_id NUMERIC(38) COMMENT

        'A coluna "produto_id" é para identificar cada produto no estoque.';

ALTER TABLE estoques MODIFY COLUMN quantidade NUMERIC(38) COMMENT

             'A coluna "quantidade" irá mostrar a quantidade de cada
             produto que tem no estoque.';


CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                PRIMARY KEY (cliente_id)
);

ALTER TABLE clientes COMMENT

          'A tabela "clientes" guardará informações dos clientes,
          como identificador único de cada cliente, nome, email e telefones.';

ALTER TABLE clientes MODIFY COLUMN cliente_id NUMERIC(38) COMMENT

            'Coluna "cliente_id", que atribuirá um identificador único
            para cada cliente, sendo esta a Primary Key(PK).';

ALTER TABLE clientes MODIFY COLUMN email VARCHAR(255) COMMENT

           'Coluna "email", que irá guardar o email
            dos funcionários cadastrados.';

ALTER TABLE clientes MODIFY COLUMN nome VARCHAR(255) COMMENT

              'A coluna "nome" irá armazenar o nome dos
                funcionários cadastrados.';

ALTER TABLE clientes MODIFY COLUMN telefone1 VARCHAR(20) COMMENT

             'A coluna "telefone1" vai armazenar o numero do telefone
             do cliente, como meio de contato, caso tenha, não sendo
             obrigatório.';

ALTER TABLE clientes MODIFY COLUMN telefone2 VARCHAR(20) COMMENT

         'Se o cliente tiver mais de um número de telefone, o segundo
         será armazenado aqui.';

ALTER TABLE clientes MODIFY COLUMN telefone3 VARCHAR(20) COMMENT

            'Se o cliente tiver mais de dois números de telefone, o
            terceiro será armazenado aqui.';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                PRIMARY KEY (envio_id)
);

ALTER TABLE envios COMMENT

             'A tabela "envios" vai armazenar o id da loja, para saber
             de que loja sai a mercadoria, o id do cliente, para saber
             se o cliente certo vai receber a mercadoria, o endereço de
             entrega, e o status, que vai informar em tempo real aonde
             a mercadoria está.';

ALTER TABLE envios MODIFY COLUMN envio_id NUMERIC(38) COMMENT

            'A coluna "envio_id" vai guardar o dado único que
             identificará um envio.';

ALTER TABLE envios MODIFY COLUMN loja_id NUMERIC(38) COMMENT

               'A coluna "loja_id" é uma FK da tabela lojas, e será
               usada para identificar as lojas.';

ALTER TABLE envios MODIFY COLUMN cliente_id NUMERIC(38) COMMENT

          'A coluna "cliente_id" é uma FK da tabela "clientes" e será
          usada para informar qual o id do cliente que receberá o pedido.';

ALTER TABLE envios MODIFY COLUMN endereco_entrega VARCHAR(512) COMMENT

            'A coluna "endereco_entrega" serve para armazenar o
            endereço de entrega do cliente.';

ALTER TABLE envios MODIFY COLUMN status VARCHAR(15) COMMENT

         'A coluna "status" vai avisar onde a encomenda está.';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora DATETIME NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                PRIMARY KEY (pedido_id)
);

ALTER TABLE pedidos COMMENT

                'A tabela "pedidos" vai guardar informações dos pedidos
                dos clientes, como a data e hora em que foi feito, o status,
                em qual loja foi feito, como também identificar o pedido
                e a loja.';

ALTER TABLE pedidos MODIFY COLUMN pedido_id NUMERIC(38) COMMENT

            'O "pedido_id" vai identificar exclusivamente cada pedido,
              sendo este a Primary Key(PK).';

ALTER TABLE pedidos MODIFY COLUMN data_hora TIMESTAMP COMMENT

              'A coluna "data_hora" servirá para guardar a data e
              hora que foram feitos os pedidos.';

ALTER TABLE pedidos MODIFY COLUMN cliente_id NUMERIC(38) COMMENT

           'A colula "cliente_id", está como uma FK da tabela "clientes",
           e serve para informar qual pessoa que fez o pedido.';

ALTER TABLE pedidos MODIFY COLUMN status VARCHAR(15) COMMENT

            'O "status" armazenará em que ponto da entrega do pedido está.
            Se já saiu da loja, se está a caminho, se já foi entregue ao
            destinatário.';

ALTER TABLE pedidos MODIFY COLUMN loja_id NUMERIC(38) COMMENT

          'A coluna "loja_id" é uma FK da tabela "lojas" e é um identificador
          exclusivo de cada loja, servindo para identificar a loja que teve
          tal pedido.';


CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                PRIMARY KEY (pedido_id, produto_id)
);

ALTER TABLE pedidos_itens COMMENT

                    'A tabela "pedidos_itens" vai mostrar informações
                    sobre os itens que foram pedidos.';

ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id NUMERIC(38) COMMENT

             'A coluna "pedido_id" dá uma identificação única para
             cada pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN produto_id NUMERIC(38) COMMENT

           'A coluna "produto_id" é uma FK da tabela "estoques" e também
           forma a PK da tabela "pedidos_itens". Ela irá mostrar qual é o
            produto que foi pedido, através do id.';

ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha NUMERIC(38) COMMENT

              'A coluna "numero_da_linha" vai guardar um identificdor
              para cada ítem, de forma sequencial.';

ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario NUMERIC(10, 2) COMMENT

             'A coluna "preco_unitario" vai informar o preço de
             1 unidade do produto.';

ALTER TABLE pedidos_itens MODIFY COLUMN quantidade NUMERIC(38) COMMENT

                 'A coluna "quantidade" indica a quantidade de
                 produtos que foram pedidos.';

ALTER TABLE pedidos_itens MODIFY COLUMN envio_id NUMERIC(38) COMMENT

                  'A coluna "envio_id" irá dar uma identificação
                  exclusiva para esse pedido.';


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

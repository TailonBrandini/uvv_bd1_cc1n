--Excluindo banco de dados uvv e Usuario tailon, caso existam
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS tailon;

--criando o usuario:

CREATE USER tailon
WITH
   createdb
   createrole
   encrypted
   password 'abrantesdaponto';

/*criando banco de dados “uvv” com o dono “tailon” e
    características descritas no pset*/

CREATE DATABASE uvv
WITH 
  OWNER = tailon
  TEMPLATE = template0
  ENCODING = 'UTF8'
  LC_COLLATE = 'pt_BR.UTF-8'
  LC_CTYPE = 'pt_BR.UTF-8'
  ALLOW_CONNECTIONS = true;


    /*entrando no banco de dados “uvv” com o usuario "tailon" e com a
              senha "abrantesdaponto", tudo automaticamente*/

\c "dbname=uvv user=tailon password=abrantesdaponto"

--Criando SCHEMA

CREATE schema IF NOT EXISTS lojas AUTHORIZATION tailon;

--ALterando o schema de public para lojas

ALTER USER tailon SET SEARCH_PATH TO lojas, "$user", public;

--Criar tabela "produtos"

CREATE TABLE lojas.produtos (
produto_id                        NUMERIC   (38)   NOT NULL,
nome                              VARCHAR   (255)  NOT NULL,
preco_unitario                    NUMERIC   (10,2)         ,
detalhes                          BYTEA                    ,
imagem                            BYTEA                    ,
imagem_mime_type                  VARCHAR   (512)          ,
imagem_arquivo                    VARCHAR   (512)          ,
imagem_charset                    VARCHAR   (512)          ,
imagem_ultima_atualizacao         DATE                     , 
CONSTRAINT pk_produtos            PRIMARY KEY (produto_id)
);

/*Checando preco_unitario para o preço da unidade do produto não
 ser negativo e nem 0*/
ALTER TABLE lojas.produtos
ADD CONSTRAINT ck_preco_unitario_produtos
CHECK (preco_unitario > 0);


--Aqui é a descrição da função da tabela "produtos".

COMMENT ON TABLE lojas.produtos IS

'A tabela "produtos" irá armazenar informações sobre os produtos,
como identificador exclusivo, os preços, detalhes, imagens';


--Aqui começarão as descrições da função de cada coluna da tabela "produtos".
COMMENT ON COLUMN lojas.produtos.produto_id IS

'A coluna "produto_id" tem por função identificar
unicamente cada produto, e portanto é uma PK.';

COMMENT ON COLUMN lojas.produtos.nome IS

'A coluna "nome" vai guardar o nome de cada produto da loja.';

COMMENT ON COLUMN lojas.produtos.preco_unitario IS

'A coluna "preco_unitario" vai informar o
   preço por unidade de cada produto.';
   
COMMENT ON COLUMN lojas.produtos.detalhes IS

'A coluna "detalhes" irá guardar alguns detalhes
     sobre os produtos.';
     
COMMENT ON COLUMN lojas.produtos.imagem IS

'A coluna "imagem" irá armazenar as imagens dos produtos
    das lojas, não sendo obrigatórios';
    
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS

'A coluna "imagem_mime_type" vai guardar
  qual o tipo de arquivo da imagem.';
  
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS

'A coluna "imagem_arquivo" vai armazenar os dados em
formato de imagem, tendo seus usos específicos e
  características prṕrias.';
  
COMMENT ON COLUMN lojas.produtos.imagem_charset IS

'A imagem_charset vai armazenar os caracteres para exibir a imagem.';

COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS

'A coluna "imagem_ultima_atualizacao" irá guardar a data
   da ultima atualização nos arquivos da imagem.';
   
--Criar tabela "lojas"

CREATE TABLE lojas.lojas (
loja_id                     NUMERIC  (38)   NOT NULL,
nome                        VARCHAR  (255)  NOT NULL,
endereco_web                VARCHAR  (100)          ,
endereco_fisico             VARCHAR  (512)          ,
latitude                    NUMERIC                 ,
longitude                   NUMERIC                 ,
logo                        BYTEA                   ,
logo_mime_type              VARCHAR  (512)          ,
logo_arquivo                VARCHAR  (512)          ,
logo_charset                VARCHAR  (512)          ,
logo_ultima_atualizacao     DATE                    ,
CONSTRAINT pk_lojas             PRIMARY KEY (loja_id)
);

/*Adicionar uma checagem que faz endereco_web ou endereco_fisico ser não nula.*/

ALTER TABLE lojas.lojas
ADD CONSTRAINT ck_endereco_fisico_e_Web_lojas
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

--Comentário sobre a função da tabela "lojas"

COMMENT ON TABLE lojas.lojas IS

  'A tabela "lojas" vai armazenar as informações da lojas, como nome,
  endereço web, fisico, latitude, longitude, logo, etc, a fim de ter as
  informações que precisem sobre cada loja.';

--Aqui começarão as descrições da função de cada coluna da tabela "lojas".

COMMENT ON COLUMN lojas.lojas.loja_id IS

    'A coluna "loja_id"  serve para identificar cada uma loja
       exclusivamente, sendo esta uma Primary Key(PK).';

COMMENT ON COLUMN lojas.lojas.nome IS

      'A coluna "nome" vai guardar o nome de
       cada loja, e não pode ser nula.';
       
COMMENT ON COLUMN lojas.lojas.endereco_web IS

   'A coluna "endereco_web" será utilizada para armazenar
   o endereço web do site de cada loja.';
   
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS

       'A coluna "endereco_fisico" irá guardar o
           endereço físico de cada loja.';
   
COMMENT ON COLUMN lojas.lojas.latitude IS

           'Esta coluna indicara em qual
            latitude a empresa se encontra.';
 
COMMENT ON COLUMN lojas.lojas.longitude IS

       'A coluna "longitude" vai armazenar a longitude
      de cada loja, em formato numerico.';
      
COMMENT ON COLUMN lojas.lojas.logo IS

        'A coluna "logo" irá armazenar a logo de cada loja,
           ajudando a identificar visualmente cada loja.';
           
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS

            'Essa coluna vai indicar qual vai
             ser o tipo de arquivo da logo.';
             
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS

              'A coluna "logo_arquivo" irá guardar
                a imagem da logo.';
                
COMMENT ON COLUMN lojas.lojas.logo_charset IS

             'A coluna "logo_charset" vai armazenar os caracteres
              para exibir a imagem da logo.';
              
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS

         'A coluna "logo_ultima_atualizacao" vai armazenar a
             data ultima atualização da logo.';

--Criar tabela "estoques".

CREATE TABLE lojas.estoques (
estoque_id         NUMERIC     (38)       NOT NULL  ,
loja_id            NUMERIC     (38)       NOT NULL  ,
produto_id         NUMERIC     (38)       NOT NULL  ,
quantidade         NUMERIC     (38)       NOT NULL  ,
CONSTRAINT pk_estoques       PRIMARY KEY (estoque_id)
);
--Checagem em estoque, para a quantidade ser maior que 0

ALTER TABLE lojas.estoques
ADD CONSTRAINT ck_quantidade_lojas_estoques
CHECK (quantidade > 0);

--Comentário sobre a tabela "estoques"
COMMENT ON TABLE lojas.estoques IS

           'A tabela "estoques" vai servir para atualizar
            a quantidade de produtos existentes em cada loja.';

--Aqui começarão as descrições da função de cada coluna da tabela "estoques".
COMMENT ON COLUMN lojas.estoques.estoque_id IS

            'A coluna "estoque_id" vai servir como identificador
             único desta tabela, sendo assim, uma Primary Key(PK),';
             
COMMENT ON COLUMN lojas.estoques.loja_id IS

             'A coluna "loja_id" é uma PK da tabela "lojas", e é
             uma FK na tabela "estoques", e serve para identificar
             sobre qual loja está informando.';
                
COMMENT ON COLUMN lojas.estoques.produto_id IS

               'A coluna "produto_id" é para identificar
                  cada produto no estoque.';
                  
COMMENT ON COLUMN lojas.estoques.quantidade IS

                'A coluna "quantidade" irá mostrar a quantidade de cada
                       produto que tem no estoque.';

--Criar tabela "clientes".

CREATE TABLE lojas.clientes (
cliente_id         NUMERIC    (38)    NOT NULL  ,
email              VARCHAR    (255)   NOT NULL  ,
nome               VARCHAR    (255)   NOT NULL  ,
telefone1          VARCHAR    (20)              ,
telefone2          VARCHAR    (20)              ,
telefone3          VARCHAR    (20)              ,
CONSTRAINT pk_clientes   PRIMARY KEY (cliente_id)
);

--Comentário sobre a tabela "clientes"

COMMENT ON TABLE lojas.clientes IS

       'A tabela "clientes" guardará informações dos clientes, como
        identificador único de cada cliente, nome, email e telefones.';


--Aqui começarão as descrições da função de cada coluna da tabela "clientes".

COMMENT ON COLUMN lojas.clientes.cliente_id IS

      'Coluna "cliente_id", que atribuirá um identificador único para
      cada cliente, sendo esta a Primary Key(PK).';
      
COMMENT ON COLUMN lojas.clientes.email IS

                'Coluna "email", que irá guardar o email dos
                   funcionários cadastrados.';
                   
COMMENT ON COLUMN lojas.clientes.nome IS

               'A coluna "nome" irá armazenar o nome
                 dos funcionários cadastrados.';

COMMENT ON COLUMN lojas.clientes.telefone1 IS

       'A coluna "telefone1" vai armazenar o numero do telefone do
      cliente, como meio de contato, caso tenha, não sendo obrigatório.';

COMMENT ON COLUMN lojas.clientes.telefone2 IS

           'Se o cliente tiver mais de um número de telefone,
              o segundo será armazenado aqui.';
              
COMMENT ON COLUMN lojas.clientes.telefone3 IS

        'Se o cliente tiver mais de dois números de telefone, o
            terceiro será armazenado aqui.';

--Criar tabela "envios".

CREATE TABLE lojas.envios (
envio_id            NUMERIC   (38)   NOT NULL    ,
loja_id             NUMERIC   (38)   NOT NULL    ,
cliente_id          NUMERIC   (38)   NOT NULL    ,
endereco_entrega    VARCHAR   (512)  NOT NULL    ,
status              VARCHAR   (15)   NOT NULL    ,
CONSTRAINT pk_envios        PRIMARY KEY (envio_id)
);
/*Checando a coluna status, para receber somente as
                opções: CRIADO, ENVIADO,TRANSITO ou ENTREGUE.  */

ALTER TABLE lojas.envios
ADD CONSTRAINT ck_envios_envios
CHECK (status in ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));


--Comentário sobre a tabela "envios"

COMMENT ON TABLE lojas.envios IS

     'A tabela "envios" vai armazenar o id da loja, para saber
      de que loja sai a mercadoria, o id do cliente, para saber
      se o cliente certo vai receber a mercadoria, o endereço de
      entrega, e o status, que vai informar em tempo real aonde a
         mercadoria está.';


--Aqui começarão as descrições da função de cada coluna da tabela "envios".

COMMENT ON COLUMN lojas.envios.envio_id IS

         'A coluna "envio_id" vai guardar o dado único
           que identificará um envio.';
           
COMMENT ON COLUMN lojas.envios.loja_id IS

              'A coluna "loja_id" é uma PK da tabela lojas,e FK
                 na tabela envios, e será
               usada para identificar as lojas.';
                
COMMENT ON COLUMN lojas.envios.cliente_id IS

             'A coluna "cliente_id" é uma FK da tabela "clientes" e
              será usada para informar qual o id do cliente que
                receberá o pedido.';
                
COMMENT ON COLUMN lojas.envios.endereco_entrega IS

           'A coluna "endereco_entrega" serve para armazenar o
             endereço de entrega do cliente.';
             
COMMENT ON COLUMN lojas.envios.status IS

           'A coluna "status" vai avisar onde a encomenda está.';

--Criar tabela "pedidos".

CREATE TABLE lojas.pedidos (
pedido_id        NUMERIC     (38)     NOT NULL  ,
data_hora        TIMESTAMP            NOT NULL  ,
cliente_id       NUMERIC     (38)     NOT NULL  ,
status           VARCHAR     (15)     NOT NULL  ,
loja_id          NUMERIC     (38)     NOT NULL  ,
CONSTRAINT pk_pedidos     PRIMARY KEY (pedido_id)
);
/*Checagem da coluna status da tabela pedidos, para que no status
   só apareça: CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO
     ou ENVIADO.*/

ALTER TABLE lojas.pedidos
ADD CONSTRAINT ck_status_pedidos
CHECK (status in ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO',
'REEMBOLSADO', 'ENVIADO'));


--Comentário sobre a tabela "pedidos".

COMMENT ON TABLE lojas.pedidos IS

      'A tabela "pedidos" vai guardar informações dos pedidos dos clientes,
      como a data e hora em que foi feito, o status, em qual loja foi feito,
      como também identificar o pedido e a loja.';

--Aqui começarão as descrições da função de cada coluna da tabela "pedidos".

COMMENT ON COLUMN lojas.pedidos.pedido_id IS

         'O "pedido_id" vai identificar exclusivamente cada pedido,
         sendo este a Primary Key(PK).';
         
COMMENT ON COLUMN lojas.pedidos.data_hora IS

       'A coluna "data_hora" servirá para guardar a data e hora
         que foram feitos os pedidos.';
         
COMMENT ON COLUMN lojas.pedidos.cliente_id IS

       'A colula "cliente_id"é uma PK da tabela "clientes", e uma FK
            na tabela "pedidos", e serve para informar
             qual pessoa que fez o pedido.';
         
COMMENT ON COLUMN lojas.pedidos.status IS

     'O "status" armazenará em que ponto da entrega do pedido está. Se já saiu
         da loja, se está a caminho, se já foi entregue ao destinatário.';
         
COMMENT ON COLUMN lojas.pedidos.loja_id IS

        'A coluna "loja_id" é uma PK da tabela "lojas" e FK
          na tabela "pedidos", e é um identificador exclusivo
          de cada loja, servindo para identificar a loja que teve
          tal pedido.';

--Criar tabela "pedidos_itens".

CREATE TABLE lojas.pedidos_itens (
pedido_id            NUMERIC        (38)     NOT NULL           ,
produto_id           NUMERIC        (38)     NOT NULL           ,
numero_da_linha      NUMERIC        (38)     NOT NULL           ,
preco_unitario       NUMERIC        (10,2)   NOT NULL           ,
quantidade           NUMERIC        (38)     NOT NULL           ,
envio_id             NUMERIC        (38)                        ,
CONSTRAINT pk_pedidos_itens   PRIMARY KEY (pedido_id, produto_id)
);
--Checagem da coluna quantidade, que não pode ser negativa e nem 0
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT ck_preco_unitario_pedidos_itens
CHECK (preco_unitario > 0);

--Checagem da coluna quantidade, que não pode ser negativa e nem 0
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT ck_quantidade_pedidos_itens
CHECK (quantidade > 0);

--Comentário sobre a tabela "pedidos_itens".

COMMENT ON TABLE lojas.pedidos_itens IS

           'A tabela "pedidos_itens" vai mostrar informações sobre
            os itens que foram pedidos.';

--Aqui começarão as descrições da função de cada coluna da tabela "pedidos_itens".

COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS

               'A coluna "pedido_id" dá uma identificação
                única para cada pedido.';
                
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS

      'A coluna "produto_id" é uma PK da tabela "produtos" e também
       forma a PFK na tabela "pedidos_itens". Ela irá mostrar qual é o
            produto que foi pedido, através do id.';
            
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS

            'A coluna "numero_da_linha" vai guardar um identificdor
             para cada ítem, de forma sequencial.';
             
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS

          'A coluna "preco_unitario" vai informar
           o preço de 1 unidade do produto.';
           
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS

          'A coluna "quantidade" indica a quantidade de
           produtos que foram pedidos.';
           
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS

             'A coluna "envio_id" é uma PK da tabela "envios" e uma FK
             na tabela "pedidos_itens", e irá dar uma identificação
             exclusiva para esse pedido.';


--Criando os relacionamentos, utilizando FK.

ALTER TABLE lojas.estoques ADD CONSTRAINT fk_produtos_estoques
FOREIGN KEY                               (produto_id)
REFERENCES                 lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pfk_produtos_pedidos_itens
FOREIGN KEY                          (produto_id)
REFERENCES            lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos ADD CONSTRAINT fk_lojas_pedidos
FOREIGN KEY                    (loja_id)
REFERENCES         lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.envios ADD CONSTRAINT fk_lojas_envios
FOREIGN KEY               (loja_id)
REFERENCES    lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.estoques ADD CONSTRAINT fk_lojas_estoques
FOREIGN KEY                  (loja_id)
REFERENCES       lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos ADD CONSTRAINT fk_clientes_pedidos
FOREIGN KEY                       (cliente_id)
REFERENCES         lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.envios ADD CONSTRAINT fk_clientes_envios
FOREIGN KEY                         (cliente_id)
REFERENCES           lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT fk_envios_pedidos_itens
FOREIGN KEY                    (envio_id)
REFERENCES        lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pfk_pedidos_pedidos_itens
FOREIGN KEY                   (pedido_id)
REFERENCES      lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

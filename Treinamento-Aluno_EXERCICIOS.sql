/*EXERCÍCIOS*/
--Criar um bloco PL/SQL anônimo para tabuada do 8
SET SERVEROUTPUT ON
DECLARE
    tabuada number;
    
    BEGIN
        FOR i IN 1..10 LOOP
            tabuada:= 8*i;
            DBMS_OUTPUT.PUT_LINE('8 X '||i ||' = ' ||tabuada);
          END LOOP;
        END;
        
        
--Criar um bloco PL/SQL anônimo para imprimir as tabuadas do 5 ao 11
SET SERVEROUTPUT ON
DECLARE
    tabuada number;
    
    BEGIN
        FOR j IN 5..11 LOOP
            FOR i IN 1..10 LOOP
                tabuada:= j*i;
                DBMS_OUTPUT.PUT_LINE(j||' X '||i ||' = ' ||tabuada);
            END LOOP;
            DBMS_OUTPUT.put_line(' ');
        END LOOP;
    END;
    
    
    
--Criar um bloco PL/SQL para apresentar os anos bissextos entre 2040 e 2100. 
--Um ano será bissexto quando for possível dividi?lo por 4, mas não por 100 ou 
--quando for possível dividi?lo por 400.
CREATE OR REPLACE FUNCTION BISSEXTO 
    (VANO NUMBER) 
RETURN BOOLEAN
AS
    VRESTO1 NUMBER(5,2);
    VRESTO2 NUMBER(5,2);
    VRESTO3 NUMBER(5,2);
BEGIN
    VRESTO1 := MOD(VANO,4);
    VRESTO2 := MOD(VANO,100);
    VRESTO3 := MOD(VANO,400);
    
    IF (VRESTO1 = 0 AND VRESTO2 <> 0 OR VRESTO3 = 0) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
    
SET SERVEROUTPUT ON
DECLARE
    ANOBI NUMBER;
    TESTE BOOLEAN;
    
    BEGIN
        FOR i IN 2040..2100 LOOP
            ANOBI:=i;
            TESTE:=bissexto(i);
            IF TESTE = TRUE THEN
                DBMS_OUTPUT.PUT_LINE( ANOBI);
            END IF;
        END LOOP;
    END;



--Criar uma procedure que deverá receber o código de um produto e 
--a partir deste dado imprimir o nome do produto, e seu descritivo. 
--Os dados deverão ser obtidos a partir de uma tabela chamada PRODUTO 
--com as seguintes colunas (COD_PRODUTO,NOM_PRODUTO,DES_PRODUTO)
CREATE TABLE TB_PRODUTO1
(   "COD_PRODUTO" NUMBER NOT NULL, 
    "NOM_PRODUTO" VARCHAR2(50), 
    "DES_PRODUTO" VARCHAR2(50));
    
INSERT INTO TB_PRODUTO1 (COD_PRODUTO, NOM_PRODUTO, DES_PRODUTO) VALUES (40 ,'COLCHOES','MARCA DE LUXO PURO MACIO');

CREATE OR REPLACE PROCEDURE PROD_DESCR 
(codigo number)
AS
VNOM_PRODUTO VARCHAR2(50);
VDES_PRODUTO VARCHAR2(50);
    BEGIN
    
    SELECT
        NOM_PRODUTO, DES_PRODUTO
    INTO
        VNOM_PRODUTO, VDES_PRODUTO
    FROM
        TB_PRODUTO1 P
    WHERE
        P.COD_PRODUTO = codigo;
        DBMS_OUTPUT.PUT_line (' Nome e descricao do produto: '||VNOM_PRODUTO||' --- '||VDES_PRODUTO);  
    END;
    
BEGIN
PROD_DESCR(40);
END;    
    


--Criar uma procedure que receberá os dados de alunos com as seguintes informações:
--(COD,NOME,N1,N2,N3,N4). A partir destes valores deverá efetuar o cálculo da média somand
--o o maior valor entre N1 e N2 às notas N3 e N4 e dividindo o valor obtido por três (achando a
--média). Se a média for menor que 6 (seis) o aluno estará REPROVADO e se a média for
--igual ou superior a 6 (seis) o aluno estará APROVADO. A procedure deverá inserir os
--valores acima numa tabela denominada ALUNO com
--as seguintes colunas COD,NOME,N1,N2,N3,N4,MEDIA,RESULTADO.

CREATE TABLE TB_ALUNO_NOTA
(   "Codigo" NUMBER NOT NULL,
    "Nome" VARCHAR2(50),
    "N1" NUMBER,
    "N2" NUMBER,
    "N3" NUMBER,
    "N4" NUMBER,
    "Média" NUMBER,
    "Resultado" VARCHAR2(20) 
);

ALTER TABLE "TB_ALUNO_NOTA" ADD CONSTRAINT "PK_cod_aluno" PRIMARY KEY ("Codigo") ENABLE;

CREATE OR REPLACE PROCEDURE ALUNO_NOTA
(vcodigo number,
vnome VARCHAR2,
vN1 number,
vN2 number,
vN3 number,
vN4 number)
AS
vnota number;
vmedia number;
vresultado VARCHAR2(20);

BEGIN
    
    IF vN1>vN2 THEN
       vnota := vN1;
    ELSE 
        vnota := vN2;
    END IF;    
    vmedia:=(vnota + vN3 + vN4)/3;
    
    IF vmedia < 6 THEN
        vresultado:='REPROVADO';
    ELSE
        vresultado:='APROVADO';
    END IF;
    INSERT INTO TB_ALUNO_NOTA ("Codigo","Nome","N1","N2","N3","N4","Média","Resultado")  VALUES (vcodigo ,vnome,vN1,vN2,vN3,vN4,vmedia,vresultado);
END;

BEGIN
ALUNO_NOTA(456, 'FERNANDO DOS SANTOS', 8, 5.7, 8.3, 6.8);
END; 
    


--Criar uma função que deverá receber o número de matrícula 
--de um funcionário e retornar o seu nome e o nome de seu departamento

CREATE TABLE TB_FUNCIONARIO_EX
(
    "MATRICULA" NUMBER NOT NULL,
    "NOME" VARCHAR2(40),
    "COD_DEPTO" NUMBER
);

ALTER TABLE TB_FUNCIONARIO_EX ADD CONSTRAINT "PK_MATRICULA" PRIMARY KEY ("MATRICULA") ENABLE;

INSERT INTO TB_FUNCIONARIO_EX ("MATRICULA", "NOME", "COD_DEPTO") VALUES (1560, 'CARLOS ALELUIA', 1);    
INSERT INTO TB_FUNCIONARIO_EX ("MATRICULA", "NOME", "COD_DEPTO") VALUES (1580, 'PEDRO SEIXAS' ,2);    
INSERT INTO TB_FUNCIONARIO_EX ("MATRICULA", "NOME", "COD_DEPTO") VALUES (1590, 'SANDRO DIAS' ,1);
    
CREATE TABLE DEPARTAMENTO_EX  
(
    "COD_DEPTO" NUMBER NOT NULL,
    "NOME_DEPTO" VARCHAR2(30)
);
ALTER TABLE DEPARTAMENTO_EX  ADD CONSTRAINT "PK_COD_DP" PRIMARY KEY ("COD_DEPTO") ENABLE;    

INSERT INTO DEPARTAMENTO_EX ("COD_DEPTO", "NOME_DEPTO") VALUES (1, 'COMPUTACAO');    
INSERT INTO DEPARTAMENTO_EX ("COD_DEPTO", "NOME_DEPTO") VALUES (2, 'ESTATÍSTICA');

CREATE OR REPLACE FUNCTION FUNC_NOME_DEPTO (FMATRICULA NUMBER)
    RETURN VARCHAR2
    AS
        vnomes TB_TYPE%ROWTYPE;
      
        CURSOR cnomes IS
    SELECT 
        f.NOME, d.NOME_DEPTO 
    FROM 
        TB_FUNCIONARIO_EX f 
    JOIN 
        DEPARTAMENTO_EX d ON (f.COD_DEPTO = d.COD_DEPTO)
    WHERE 
        f.MATRICULA = FMATRICULA;
        
    BEGIN
        OPEN cnomes;
            LOOP
            FETCH cnomes INTO vnomes;
            EXIT WHEN cnomes%NOTFOUND;
            END LOOP;
        CLOSE cnomes;
        RETURN (vnomes);
    END;
        
SELECT FUNC_NOME_DEPTO(1560) FROM DUAL;     
        
        
        
CREATE TABLE TB_TYPE
(
    "NOME" VARCHAR2(40),
    "NOME_DEPTO" VARCHAR2(30)
);
DECLARE
vnomes TB_TYPE%ROWTYPE;    
CURSOR cnomes IS
    SELECT 
        f.NOME, d.NOME_DEPTO 
    FROM 
        TB_FUNCIONARIO_EX f 
    JOIN 
        DEPARTAMENTO_EX d ON (f.COD_DEPTO = d.COD_DEPTO)
    WHERE 
        d.MATRICULA = FMATRICULA)
        
    BEGIN
        OPEN cnomes;
            LOOP
            FETCH cnomes INTO vnomes;
            EXIT WHEN cnomes%NOTFOUND;
            END LOOP;
        CLOSE cnomes;
        RETURN(vnomes)
    END;  
    
    
    
--USANDO TYPE

CREATE OR REPLACE TYPE t_value AS OBJECT
(
    "NOME" VARCHAR2(40),
    "NOME_DEPTO" VARCHAR2(30)
) 


CREATE OR REPLACE TYPE t_value_table AS TABLE OF t_value

    
CREATE OR REPLACE FUNCTION FUNC_NOME_DEPTO (FMATRICULA NUMBER)
RETURN t_value_table IS

 -- Definir as variáveis

 TYPE tList IS REF CURSOR;
 sList tList;
 vList t_value := t_value(0,0);
 ttList  t_value_table := t_value_table();

BEGIN
 BEGIN
 DBMS_OUTPUT.PUT_LINE('[ INICIO ]');

 OPEN sList FOR 
  SELECT 
        f.NOME, d.NOME_DEPTO 
    FROM 
        TB_FUNCIONARIO_EX f 
    JOIN 
        DEPARTAMENTO_EX d ON (f.COD_DEPTO = d.COD_DEPTO)
    WHERE 
        f.MATRICULA = FMATRICULA; 
 LOOP
 FETCH sList INTO vList.NOME, vList.NOME_DEPTO;

 EXIT WHEN sList%NOTFOUND;
 -- Vamos manipular os dados

 vList.descricao := vList.NOME || ' - ' || vList.NOME_DEPTO;
 ttList.extend;
 ttList(vList.NOME) := vList; 

 END LOOP;

 CLOSE sList;

 DBMS_OUTPUT.PUT_LINE('[ FIM ]');

 END;

RETURN(ttList);

END f_list_value;    
    
    

    
    
    
--Criar uma trigger para implementar uma restrição para que 
--o salário do funcionário (ver tabela a seguir) não possa ser reduzido.    
 
CREATE TABLE TB_FUNCIONARIO_EX13
(
    "MATRICULA" NUMBER NOT NULL,
    "NOME" VARCHAR2(40),
    "SALARIO" NUMBER
);   
    
INSERT INTO TB_FUNCIONARIO_EX13 ("MATRICULA", "NOME", "SALARIO") VALUES (1001, 'HILTON DOUGLAS' ,3500);    
INSERT INTO TB_FUNCIONARIO_EX13 ("MATRICULA", "NOME", "SALARIO") VALUES (1002, 'STEPHANIE SANTOS', 4800);    
INSERT INTO TB_FUNCIONARIO_EX13 ("MATRICULA", "NOME", "SALARIO") VALUES (1003, 'BRUNO UOSHINTON' ,7500);    
    
CREATE OR REPLACE TRIGGER TR_SAL_RED
BEFORE UPDATE
ON TB_FUNCIONARIO_EX13
FOR EACH ROW

    BEGIN
        IF (:NEW.SALARIO < :OLD.SALARIO) THEN
            --OLD COMPARA O PRECO ANTIGO ANTES DO UPDATE
            RAISE_APPLICATION_ERROR (-20334,'Reajuste não permitido!!');
        END IF;
    END;
    
UPDATE TB_FUNCIONARIO_EX13 SET SALARIO=3000 WHERE MATRICULA=1001;

CREATE OR REPLACE TRIGGER TR_SAL_AUM
BEFORE UPDATE
ON TB_FUNCIONARIO_EX13
FOR EACH ROW

    BEGIN
        IF (:NEW.SALARIO > :OLD.SALARIO*1.2) THEN
            --OLD COMPARA O PRECO ANTIGO ANTES DO UPDATE
            RAISE_APPLICATION_ERROR (-20335,'Reajuste não permitido!!');
        END IF;
    END;
    
UPDATE TB_FUNCIONARIO_EX13 SET SALARIO=5000 WHERE MATRICULA=1001;
    
    
    
    

const criarTabelas = [
  '''
    CREATE TABLE professor(
      id INTEGER NOT NULL PRIMARY KEY
      ,nome VARCHAR(200) NOT NULL
      ,email VARCHAR(200) NULL
      ,senha VARCHAR(200) NULL
      ,telefone VARCHAR(300) NULL
    )
  '''
];

const insercoes = [
 '''
    INSERT INTO usuario (nome, email, senha, telefone)
    VALUES ('Joaquim Silva', 'joaquim.silva@gmail.com', 'joaquin123', '99999-9999')
  '''
];

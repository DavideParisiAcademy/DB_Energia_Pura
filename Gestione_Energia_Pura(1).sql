
--DDL

CREATE DATABASE Gestione_Energia_Pura;
USE Gestione_Energia_Pura;

CREATE TABLE attrezzatura(
	attrezzaturaID INT PRIMARY KEY IDENTITY(1,1),
	tipo VARCHAR(250) NOT NULL CHECK (tipo IN ('bicicletta','tapis roulant','pesi')),
	descrizione TEXT NOT NULL,
	stato VARCHAR(250) NOT NULL CHECK (stato IN ('manutenzione','disponibile', 'fuori servizio')),
	attivitaRIF INT NOT NULL,
	istruttoreRIF INT NOT NULL,
	dataAcquisto DATE NOT NULL,
	FOREIGN KEY(attivitaRIF) REFERENCES attivita(attivitaID),
	FOREIGN KEY(istruttoreRIF) REFERENCES  istruttore(istruttoreID),
	UNIQUE(attrezzaturaID, istruttoreRIF)
);

CREATE TABLE istruttore(
	istruttoreID INT PRIMARY KEY IDENTITY(1,1),
	nominativo VARCHAR(250) NOT NULL,
	orario_lavoro VARCHAR(250) NOT NULL
);

CREATE TABLE attivita(
	attivitaID INT PRIMARY KEY IDENTITY(1,1),
	categoria VARCHAR(250) CHECK (categoria IN('pilates','nuoto','yoga','spinning','sala pesi')),
	giorno VARCHAR(250) NOT NULL CHECK(giorno IN ('Lunedi','Martedi','Mercoledi','Giovedi','Venerdi','Sabato')),
	orario TIME NOT NULL,
	capacita INT NOT NULL,
	istruttoreRIF INT NOT NULL,
	FOREIGN KEY(istruttoreRIF) REFERENCES istruttore(istruttoreID)
);

CREATE TABLE membro(
	membroID INT PRIMARY KEY IDENTITY(1,1),
	nominativo VARCHAR(250) NOT NULL,
	sesso CHAR(1) CHECK (sesso IN('M','F')),
	dataNas DATE NOT NULL,
	email VARCHAR(250) NOT NULL,
	tel VARCHAR(250) NOT NULL,
	UNIQUE (email, tel)
);
CREATE TABLE prenotazione(
	prenotazioneID INT PRIMARY KEY IDENTITY(1,1),
	dataPrenotazione DATE NOT NULL,
	dataCancellazione DATE DEFAULT NULL,
	membroRIF INT NOT NULL,
	attivitaRIF INT NOT NULL,
	FOREIGN KEY(membroRIF) REFERENCES membro(membroID) ON DELETE CASCADE,
	FOREIGN KEY(attivitaRIF) REFERENCES attivita(attivitaID) ON DELETE CASCADE,
	UNIQUE (membroRIF , attivitaRIF)
);

CREATE TABLE abbonamento(
	membroID INT PRIMARY KEY IDENTITY(1,1),
	tipo VARCHAR(250) CHECK (tipo IN('settimanale','mensile','annuale')),
	data_inizio DATE NOT NULL,
	data_fine DATE NOT NULL,
	membroRIF INT NOT NULL UNIQUE,
	FOREIGN KEY(membroRIF) REFERENCES membro(membroID) ON DELETE CASCADE
);

--DML

INSERT INTO istruttore (nominativo, orario_lavoro) VALUES 
('Marco Rossi', '08:00-12:00'),
('Luca Bianchi', '10:00-14:00'),
('Giulia Verdi', '14:00-18:00'),
('Marta Neri', '16:00-20:00'),
('Alessandro Gialli', '09:00-13:00'),
('Sara Blu', '12:00-16:00'),
('Andrea Marroni', '17:00-21:00'),
('Elisa Arancioni', '08:00-12:00'),
('Francesco Viola', '15:00-19:00'),
('Simone Rossi', '10:00-14:00');

INSERT INTO attivita (categoria, giorno, orario, capacita, istruttoreRIF) VALUES 

('spinning', 'Lunedi', '08:00', 20, 1),
('pilates', 'Lunedi', '10:00', 15, 2),
('nuoto', 'Martedi', '14:00', 10, 3),
('yoga', 'Mercoledi', '16:00', 25, 4),
('sala pesi', 'Giovedi', '09:00', 30, 5),
('spinning', 'Venerdi', '12:00', 20, 6),
('pilates', 'Sabato', '11:00', 15, 7),
('nuoto', 'Lunedi', '09:00', 10, 8),
('yoga', 'Martedi', '15:00', 25, 9),
('sala pesi', 'Mercoledi', '17:00', 30, 10),

('spinning', 'Giovedi', '08:00', 20, 1),
('pilates', 'Venerdi', '10:00', 15, 2),
('nuoto', 'Sabato', '14:00', 10, 3),
('yoga', 'Lunedi', '16:00', 25, 4),
('sala pesi', 'Martedi', '09:00', 30, 5),
('spinning', 'Mercoledi', '12:00', 20, 6),
('pilates', 'Giovedi', '11:00', 15, 7),
('nuoto', 'Venerdi', '09:00', 10, 8),
('yoga', 'Sabato', '15:00', 25, 9),
('sala pesi', 'Lunedi', '17:00', 30, 10),
('spinning', 'Martedi', '08:00', 20, 1),
('pilates', 'Mercoledi', '10:00', 15, 2),
('nuoto', 'Giovedi', '14:00', 10, 3),
('yoga', 'Venerdi', '16:00', 25, 4),
('sala pesi', 'Sabato', '09:00', 30, 5),
('spinning', 'Lunedi', '12:00', 20, 6),
('pilates', 'Martedi', '11:00', 15, 7),
('nuoto', 'Mercoledi', '09:00', 10, 8),
('yoga', 'Giovedi', '15:00', 25, 9),
('sala pesi', 'Venerdi', '17:00', 30, 10),
('spinning', 'Sabato', '08:00', 20, 1),
('pilates', 'Lunedi', '10:00', 15, 2),
('nuoto', 'Martedi', '14:00', 10, 3),
('yoga', 'Mercoledi', '16:00', 25, 4),
('sala pesi', 'Giovedi', '09:00', 30, 5),
('spinning', 'Venerdi', '12:00', 20, 6),
('pilates', 'Sabato', '11:00', 15, 7),
('nuoto', 'Lunedi', '09:00', 10, 8),
('yoga', 'Martedi', '15:00', 25, 9),
('sala pesi', 'Mercoledi', '17:00', 30, 10);


INSERT INTO attrezzatura (tipo, descrizione, stato, attivitaRIF, istruttoreRIF, dataAcquisto) VALUES
('bicicletta', 'Bicicletta per spinning, ottime condizioni', 'disponibile', 1, 1, '2022-05-12'),
('tapis roulant', 'Tapis roulant per allenamento cardio', 'disponibile', 5, 5, '2021-11-20'),
('pesi', 'Set di pesi da 10 kg', 'manutenzione', 10, 10, '2023-03-15'),
('bicicletta', 'Bicicletta da spinning professionale', 'disponibile', 11, 1, '2021-07-11'),
('tapis roulant', 'Tapis roulant avanzato con schermo LCD', 'fuori servizio', 15, 6, '2020-02-28'),
('pesi', 'Manubri regolabili per sala pesi', 'disponibile', 19, 10, '2023-01-10'),
('bicicletta', 'Bicicletta da spinning modello avanzato', 'manutenzione', 2, 2, '2021-10-01'),
('tapis roulant', 'Tapis roulant di ultima generazione', 'disponibile', 5, 5, '2023-04-12'),
('pesi', 'Manubri regolabili con vari pesi', 'disponibile', 10, 10, '2022-07-16'),
('bicicletta', 'Bicicletta statica professionale', 'disponibile', 12, 1, '2021-11-23'),
('tapis roulant', 'Tapis roulant per allenamento intenso', 'fuori servizio', 20, 7, '2020-12-05'),
('bicicletta', 'Bicicletta standard per spinning', 'disponibile', 3, 1, '2023-05-10'),
('tapis roulant', 'Tapis roulant semplice', 'manutenzione', 7, 3, '2022-01-18'),
('pesi', 'Pesi da palestra professionali', 'disponibile', 9, 5, '2023-03-03'),
('bicicletta', 'Bicicletta per allenamento endurance', 'disponibile', 13, 2, '2021-04-14'),
('tapis roulant', 'Tapis roulant con inclinazione regolabile', 'disponibile', 14, 4, '2022-07-07');

INSERT INTO membro (nominativo, sesso, dataNas, email, tel) VALUES 
('Luca Rossi', 'M', '1985-06-15', 'lrossi@mail.com', '3456789012'),
('Maria Bianchi', 'F', '1990-03-10', 'mbianchi@mail.com', '3456789013'),
('Giovanni Verdi', 'M', '1982-12-05', 'gverdi@mail.com', '3456789014'),
('Francesca Neri', 'F', '1995-01-18', 'fneri@mail.com', '3456789015'),
('Alessandro Gialli', 'M', '1988-07-27', 'agialli@mail.com', '3456789016'),
('Sofia Blu', 'F', '1991-11-08', 'sblu@mail.com', '3456789017'),
('Paolo Marroni', 'M', '1980-02-20', 'pmarroni@mail.com', '3456789018'),
('Sara Rosa', 'F', '1993-04-12', 'srosa@mail.com', '3456789019'),
('Marco Viola', 'M', '1987-09-30', 'mviola@mail.com', '3456789020'),
('Elena Azzurri', 'F', '1992-06-22', 'eazzurri@mail.com', '3456789021'),

('Davide Nero', 'M', '1990-03-14', 'dnero@mail.com', '3456789022'),
('Giulia Verde', 'F', '1989-05-09', 'gverde@mail.com', '3456789023'),
('Simone Bruni', 'M', '1994-07-01', 'sbruni@mail.com', '3456789024'),
('Federica Fede', 'F', '1985-11-11', 'ffede@mail.com', '3456789025'),
('Matteo Grigi', 'M', '1996-08-19', 'mgrigi@mail.com', '3456789026'),
('Anna Viola', 'F', '1983-02-25', 'aviola@mail.com', '3456789027'),
('Carlo Moro', 'M', '1987-10-02', 'cmoro@mail.com', '3456789028'),
('Marta Celesti', 'F', '1992-12-12', 'mcelesti@mail.com', '3456789029'),
('Lorenzo Oro', 'M', '1986-03-23', 'loro@mail.com', '3456789030'),
('Veronica Argenti', 'F', '1995-07-04', 'vargenti@mail.com', '3456789031'),

('Riccardo Zinco', 'M', '1988-09-07', 'rzinco@mail.com', '3456789032'),
('Chiara Lilla', 'F', '1993-05-15', 'clilla@mail.com', '3456789033'),
('Tommaso Rame', 'M', '1991-06-19', 'trame@mail.com', '3456789034'),
('Luisa Fucsia', 'F', '1984-04-14', 'lfucsia@mail.com', '3456789035'),
('Alberto Verde', 'M', '1992-11-05', 'averde@mail.com', '3456789036'),
('Elisa Corallo', 'F', '1989-12-20', 'ecorallo@mail.com', '3456789037'),
('Fabio Lavanda', 'M', '1981-01-09', 'flavanda@mail.com', '3456789038'),
('Valeria Turchese', 'F', '1994-09-03', 'vturchese@mail.com', '3456789039'),
('Giorgio Zaffiro', 'M', '1995-03-30', 'gzaffiro@mail.com', '3456789040'),
('Claudia Giallo', 'F', '1990-07-27', 'cgiallo@mail.com', '3456789041');


INSERT INTO abbonamento (tipo, data_inizio, data_fine, membroRIF) VALUES 
('annuale', '2023-01-01', '2023-12-31', 1),
('mensile', '2023-09-01', '2023-09-30', 2),
('settimanale', '2023-09-20', '2023-09-27', 3),
('annuale', '2023-01-01', '2023-12-31', 4),
('mensile', '2023-09-01', '2023-09-30', 5),
('settimanale', '2023-09-15', '2023-09-22', 6),
('annuale', '2023-01-01', '2023-12-31', 7),
('mensile', '2023-09-01', '2023-09-30', 8),
('settimanale', '2023-09-15', '2023-09-22', 9),
('annuale', '2023-01-01', '2023-12-31', 10),

('mensile', '2023-09-01', '2023-09-30', 11),
('settimanale', '2023-09-20', '2023-09-27', 12),
('annuale', '2023-01-01', '2023-12-31', 13),
('mensile', '2023-09-01', '2023-09-30', 14),
('settimanale', '2023-09-15', '2023-09-22', 15),
('annuale', '2023-01-01', '2023-12-31', 16),
('mensile', '2023-09-01', '2023-09-30', 17),
('settimanale', '2023-09-15', '2023-09-22', 18),
('annuale', '2023-01-01', '2023-12-31', 19),
('mensile', '2023-09-01', '2023-09-30', 20),

('settimanale', '2023-09-20', '2023-09-27', 21),
('annuale', '2023-01-01', '2023-12-31', 22),
('mensile', '2023-09-01', '2023-09-30', 23),
('settimanale', '2023-09-15', '2023-09-22', 24),
('annuale', '2023-01-01', '2023-12-31', 25),
('mensile', '2023-09-01', '2023-09-30', 26),
('settimanale', '2023-09-15', '2023-09-22', 27),
('annuale', '2023-01-01', '2023-12-31', 28),
('mensile', '2023-09-01', '2023-09-30', 29),
('settimanale', '2023-09-15', '2023-09-22', 30);

INSERT INTO prenotazione (dataPrenotazione, dataCancellazione, membroRIF, attivitaRIF) VALUES 
('2023-09-01', '2023-09-05', 1, 1),
('2023-09-10', NULL, 1, 2),
('2023-09-15', NULL, 1, 3),
('2023-09-03', NULL, 2, 4),
('2023-09-12', NULL, 2, 5),
('2023-09-20', '2023-09-23', 2, 6),
('2023-09-05', NULL, 3, 7),
('2023-09-14', '2023-09-17', 3, 8),
('2023-09-18', NULL, 3, 9),
('2023-09-04', '2023-09-08', 4, 10),
('2023-09-11', NULL, 4, 11),
('2023-09-16', NULL, 4, 12),
('2023-09-07', NULL, 5, 13),
('2023-09-12', NULL, 5, 14),
('2023-09-22', NULL, 5, 15),
('2023-09-06', '2023-09-09', 6, 16),
('2023-09-13', NULL, 6, 1),
('2023-09-20', NULL, 6, 2),
('2023-09-08', NULL, 7, 3),
('2023-09-15', NULL, 7, 4),
('2023-09-22', NULL, 7, 5),
('2023-09-09', NULL, 8, 6),
('2023-09-17', NULL, 8, 7),
('2023-09-25', '2023-09-27', 8, 8),
('2023-09-04', NULL, 9, 9),
('2023-09-14', NULL, 9, 10),
('2023-09-22', NULL, 9, 11),
('2023-09-02', '2023-09-06', 10, 12),
('2023-09-10', NULL, 10, 13),
('2023-09-20', NULL, 10, 14),
('2023-09-05', NULL, 11, 15),
('2023-09-11', NULL, 11, 16),
('2023-09-21', '2023-09-23', 11, 1),
('2023-09-08', NULL, 12, 2),
('2023-09-14', NULL, 12, 3),
('2023-09-20', NULL, 12, 4),
('2023-09-06', NULL, 13, 5),
('2023-09-13', NULL, 13, 6),
('2023-09-22', NULL, 13, 7),
('2023-09-04', NULL, 14, 8),
('2023-09-09', '2023-09-12', 14, 9),
('2023-09-15', NULL, 14, 10), 
('2023-09-08', NULL, 15, 11),
('2023-09-16', NULL, 15, 12),
('2023-09-21', NULL, 15, 13),
('2023-09-10', '2023-09-15', 16, 14),
('2023-09-17', NULL, 16, 15),
('2023-09-22', NULL, 16, 16),
('2023-09-07', NULL, 17, 1),
('2023-09-12', NULL, 17, 2),
('2023-09-17', NULL, 17, 3),
('2023-09-05', NULL, 18, 4),
('2023-09-10', '2023-09-13', 18, 5),
('2023-09-18', NULL, 18, 6),
('2023-09-09', NULL, 19, 7),
('2023-09-15', NULL, 19, 8),
('2023-09-19', NULL, 19, 9),
('2023-09-08', NULL, 20, 10),
('2023-09-12', NULL, 20, 11),
('2023-09-17', NULL, 20, 12),
('2023-09-10', NULL, 21, 13),
('2023-09-18', NULL, 21, 14),
('2023-09-23', NULL, 21, 15),
('2023-09-06', NULL, 22, 16),
('2023-09-14', '2023-09-19', 22, 1),
('2023-09-18', NULL, 22, 2),
('2023-09-09', NULL, 23, 3),
('2023-09-15', NULL, 23, 4),
('2023-09-20', NULL, 23, 5),
('2023-09-03', NULL, 24, 6),
('2023-09-11', NULL, 24, 7),
('2023-09-22', NULL, 24, 8),
('2023-09-06', '2023-09-10', 25, 9),
('2023-09-14', NULL, 25, 10),
('2023-09-20', NULL, 25, 11),
('2023-09-02', NULL, 26, 12),
('2023-09-11', NULL, 26, 13),
('2023-09-21', NULL, 26, 14),
('2023-09-08', NULL, 27, 15),
('2023-09-14', NULL, 27, 16),
('2023-09-19', NULL, 27, 1),
('2023-09-05', '2023-09-08', 28, 2),
('2023-09-12', NULL, 28, 3),
('2023-09-18', NULL, 28, 4),
('2023-09-03', NULL, 29, 5),
('2023-09-09', '2023-09-12', 29, 6),
('2023-09-17', NULL, 29, 7),
('2023-09-07', NULL, 30, 8),
('2023-09-14', NULL, 30, 9),
('2023-09-19', NULL, 30, 10);


--QL (QUERY)

--1) Visualizzare tutti i membri registrati.
SELECT * FROM membro;
SELECT * FROM attivita;
SELECT * FROM attrezzatura;
SELECT * FROM prenotazione;
SELECT * FROM abbonamento;
SELECT * FROM istruttore;

--2
SELECT membro.nominativo
	FROM abbonamento
	JOIN membro ON abbonamento.membroRIF = membro.membroID
	WHERE abbonamento.tipo = 'Mensile';
--3
SELECT * FROM attivita
		WHERE categoria = 'Yoga';
--4 
SELECT * FROM istruttore
		JOIN attivita ON istruttore.istruttoreID = attivita.istruttoreRIF
		WHERE attivita.categoria = 'Pilates';
--5	Recupera i dettagli delle classi programmate per il lunedì.

SELECT * FROM attivita
		WHERE attivita.giorno = 'Lunedi';
--6	Recupera l'elenco dei membri che hanno prenotato una classe di spinning.

SELECT * 
	FROM membro
	JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
	JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
	WHERE attivita.categoria = 'Spinning';

--7 Recupera tutte le attrezzature che sono attualmente fuori servizio.

SELECT * FROM attrezzatura
	WHERE attrezzatura.stato = 'Fuori servizio';

--8. Conta il numero di partecipanti per ciascuna classe programmata per il mercoledì.

SELECT COUNT(*) AS count
	FROM membro 
	JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
	JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
	WHERE attivita.giorno = 'Mercoledi';

-- 9 Recupera l'elenco degli istruttori disponibili per tenere una lezione il sabato.

SELECT *
		FROM attivita
		JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
		WHERE attivita.giorno = 'Sabato';

--10.Recupera tutti i membri che hanno un abbonamento attivo dal 2023.

SELECT *
		FROM abbonamento
		JOIN membro ON abbonamento.membroRIF = membro.membroID
		WHERE YEAR(data_inizio) = '2023';

--11.Trova il numero massimo di partecipanti per tutte le classi di sollevamento pesi.

SELECT attivita.capacita AS partecipanti
		FROM membro
		JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
		JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
		WHERE attivita.categoria = 'sala pesi';

--12 Recupera le prenotazioni effettuate da un membro specifico.

SELECT *
		FROM membro
		JOIN prenotazione ON membro.membroID =prenotazione.membroRIF
		JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
		WHERE membro.nominativo = 'Mario Rossi';

--13 Recupera l'elenco degli istruttori che conducono più di 5 classi alla settimana.

SELECT istruttore.nominativo, COUNT(istruttoreRIF) AS lezioni
		FROM attivita
		JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
		GROUP BY istruttore.nominativo
		HAVING COUNT(istruttoreRIF) >= 3;


--14 Recupera le classi che hanno ancora posti disponibili per nuove prenotazioni.

SELECT attivita.categoria, attivita.capacita, COUNT(attivitaRIF) AS prenotazioni, attivita.capacita - COUNT(attivitaRIF) AS posti_Disponibili
		FROM prenotazione
		JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
		GROUP BY categoria, capacita
		HAVING attivita.capacita - COUNT(attivitaRIF) >0;
		 
--15 Recupera l'elenco dei membri che hanno annullato una prenotazione negli ultimi 30 giorni.SELECT * FROM prenotazione 
SELECT *
		FROM prenotazione
		WHERE dataCancellazione IS NOT NULL AND dataCancellazione BETWEEN CAST(DATEADD(DAY, -30 , GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE);

--16 Recupera tutte le attrezzature acquistate prima del 2022.

SELECT *
		FROM attrezzatura
		WHERE YEAR(dataAcquisto) < 2022;

--17 Recupera l'elenco dei membri che hanno prenotato una classe in cui l'istruttore è "Mario Rossi".

SELECT membro.nominativo, sesso, email, tel, categoria, giorno, orario, istruttore.nominativo 
		FROM membro
		JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
		JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
		JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
		WHERE istruttore.nominativo = 'Mario Rossi';

--18 Calcola il numero totale di prenotazioni per ogni classe per un determinato periodo di tempo. (MIGLIORABILE)

SELECT attivita.categoria, COUNT(attivitaRIF) AS prenotazioni_totali
		FROM prenotazione
		JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
		GROUP BY attivita.orario, attivita.categoria
		HAVING attivita.orario BETWEEN '13:00:00' AND '20:00:00'; 
		
--19 Trova tutte le classi associate a un'istruttore specifico e i membri che vi hanno partecipato.

SELECT membro.nominativo AS membro, sesso, email, tel, categoria, giorno, orario, istruttore.nominativo AS istruttore FROM membro
		JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
		JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
		JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
		WHERE istruttore.nominativo = 'Mario Rossi';

--20 Recupera tutte le attrezzature in manutenzione e il nome degli istruttori che le utilizzano nelle loro classi.

SELECT tipo, stato, nominativo AS istruttore FROM attrezzatura
		JOIN istruttore ON attrezzatura.istruttoreRIF = istruttore.istruttoreID
		WHERE attrezzatura.stato = 'Manutenzione';

-- VIEW 



-- VIEWS DEFINITIVE

-- 1 Crea una view che mostra l'elenco completo dei membri con il loro nome, cognome e tipo di abbonamento.

CREATE VIEW membri_abbonamenti AS

	SELECT membro.nominativo, abbonamento.tipo
	FROM abbonamento
	JOIN membro ON abbonamento.membroRIF = membro.membroID;

	--utilizzo della view
	SELECT * FROM membri_abbonamenti;

--2 Crea una view che elenca tutte le classi disponibili con i rispettivi nomi degli istruttori.
-- Per scelte di tipo strutturale alcune categorie di classi sono state associate a più istruttori.

CREATE VIEW view_attivita_istruttori AS
SELECT attivita.categoria, istruttore.nominativo
		FROM attivita
		JOIN istruttore ON  attivita.istruttoreRIF = istruttore.istruttoreID
		GROUP BY categoria, nominativo;

-- utilizzo della view

SELECT * FROM view_attivita_istruttori;

--3 Crea una view che mostra le classi prenotate dai membri insieme al nome della classe e alla data di prenotazione.
CREATE VIEW view_membro_prenotazione_attivita AS
SELECT nominativo, email, tel, dataPrenotazione, categoria, giorno, orario
		FROM membro
		JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
		JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID

--utilizzo della view 

SELECT * FROM view_membro_prenotazione_attivita;

--4 Crea una view che elenca tutte le attrezzature attualmente disponibili, con la descrizione e lo stato.

CREATE VIEW view_attrezzature_disponibili AS

SELECT attrezzatura.tipo, stato, descrizione FROM attrezzatura
		WHERE stato = 'Disponibile';

--utilizzo della view

SELECT * FROM view_attrezzature_disponibili;


--5 Crea una view che mostra i membri che hanno prenotato una classe di spinning negli ultimi 30 giorni.

CREATE VIEW view_Membri_Spinning AS 

SELECT membro.nominativo, attivita.categoria
		FROM membro
		JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
		JOIN attivita ON prenotazione.attivitaRIF = attivita.attivitaID
		WHERE categoria = 'Spinning' AND dataPrenotazione BETWEEN CAST(DATEADD(DAY, -30 , GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE);

		-- Cambiare il parametro temporale di almeno un anno indietro per ottenere dei risultati (GPT ha generato solo risultati per il 2023)

	--utilizzo della view

	SELECT * FROM view_Membri_Spinning;

--6 Crea una view che elenca gli istruttori con il numero totale di classi che conducono.

CREATE VIEW view_istruttori_classi AS 

SELECT istruttore.nominativo, attivita.categoria, COUNT(istruttoreRIF) AS lezioni
		FROM attivita
		JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
		GROUP BY nominativo, categoria;

-- utilizzo della view

SELECT * FROM view_istruttori_classi;

-- 7 Crea una view che mostri il nome delle classi e il numero di partecipanti registrati per ciascuna classe.

CREATE VIEW view_attivita_partecipanti AS

SELECT attivita.categoria, COUNT(prenotazione.membroRIF) AS prenotati
	   FROM membro
	   JOIN prenotazione ON membro.membroID = prenotazione.membroRIF
	   JOIN attivita ON	prenotazione.attivitaRIF = attivita.attivitaID
	   GROUP BY categoria;

--utilizzo della query

SELECT * FROM view_attivita_partecipanti;

--8 Crea una view che elenca i membri che hanno un abbonamento attivo insieme alla data di inizio e la data di scadenza.

CREATE VIEW view_Abbonamenti_Attivi AS

SELECT abbonamento.tipo, abbonamento.data_inizio, abbonamento.data_fine, membro.nominativo
		FROM abbonamento
		JOIN membro ON abbonamento.membroRIF = membro.membroID
		WHERE data_fine BETWEEN CAST(DATEADD(DAY, +365 , GETDATE()) AS DATE) AND CAST(GETDATE() AS DATE);

		--utilizzo della view

SELECT * FROM view_Abbonamenti_Attivi;


--9 Crea una view che mostra l'elenco degli istruttori che conducono classi il lunedì e il venerdì.

CREATE VIEW view_istruttori_lunedi_venerdi AS

SELECT istruttore.nominativo, attivita.giorno, attivita.categoria
		FROM attivita
		JOIN istruttore ON attivita.istruttoreRIF = istruttore.istruttoreID
		GROUP BY istruttore.nominativo, giorno, categoria
		HAVING attivita.giorno IN ('Lunedi','Venerdi');

--utilizzo della view

SELECT * FROM view_istruttori_lunedi_venerdi;

--10 Crea una view che elenca tutte le attrezzature acquistate nel 2023 insieme al loro stato attuale.

CREATE VIEW	view_attrezzature_2023 AS

SELECT tipo, dataAcquisto, stato 
		FROM attrezzatura
		WHERE YEAR(dataAcquisto) = '2023';

--utilizzo della view 

SELECT * FROM view_attrezzature_2023;


--SP

--1 Scrivi una stored procedure che permette di inserire un nuovo membro nel sistema con tutti i suoi dettagli, come nome, cognome, data di nascita,
--  tipo di abbonamento, ecc.

CREATE PROCEDURE sp_Inserimento_Membro	
	
	@nom VARCHAR(250),
	@ses CHAR(1),
	@nas DATE,
	@ema VARCHAR(250),
	@tel VARCHAR(250),
	@tip VARCHAR(250),
	@ini DATE,
	@fin DATE
	
AS 

BEGIN
	BEGIN TRANSACTION
			
		BEGIN TRY

			INSERT INTO Membro(nominativo, sesso, dataNas, email, tel) VALUES
			(@nom, @ses, @nas, @ema,@tel);
			DECLARE @membroID INT;
			SET @membroID = SCOPE_IDENTITY();
			INSERT INTO abbonamento(tipo, data_inizio,data_fine, membroRIF) VALUES
			(@tip,@ini,@fin,@membroID);

			COMMIT TRANSACTION 

		END TRY

	BEGIN CATCH

			ROLLBACK TRANSACTION

	END CATCH

END

EXEC sp_Inserimento_Membro @nom = 'Davide Parisi',@ses = 'M',@nas ='1999-02-01',@ema = 'davidepariiofficial@gmail.com',@tel = '3662629200',
						   @tip = 'Annuale',@ini = '2024-08-01',@fin ='2025-08-01';


SELECT * FROM membro
		JOIN abbonamento ON membro.membroID = abbonamento.membroRIF;


--2 Scrivi una stored procedure per aggiornare lo stato di un'attrezzatura (ad esempio, disponibile, in manutenzione, fuori servizio).

CREATE PROCEDURE sp_Stato_Attrezzatura	
	
	@id	   INT,
	@stato VARCHAR(250)
	
AS 

BEGIN
	BEGIN TRANSACTION
			
		BEGIN TRY

			UPDATE attrezzatura
			SET attrezzatura.stato = @stato
			WHERE attrezzaturaID = @id;

			COMMIT TRANSACTION 

		END TRY

	BEGIN CATCH

			ROLLBACK TRANSACTION

	END CATCH

END;

EXEC sp_Stato_Attrezzatura @id = 1,@stato = 'Manutenzione';

--3 Scrivi una stored procedure che consenta a un membro di prenotare una classe specifica.

CREATE PROCEDURE sp_Prenotazione_Attivita	

	@data DATE,
	@idme INT,
	@idat INT


AS 

BEGIN
	BEGIN TRANSACTION
			
		BEGIN TRY
			
			INSERT INTO prenotazione(dataPrenotazione, membroRIF, attivitaRIF)
			VALUES (@data, @idme, @idat);

			COMMIT TRANSACTION 

		END TRY

	BEGIN CATCH

			ROLLBACK TRANSACTION

	END CATCH

END;

EXEC sp_Prenotazione_Attivita @data = '2024-09-23', @idme = 31, @idat = 33;


--5 Scrivi una stored procedure per permettere ai membri di cancellare una prenotazione esistente.



CREATE PROCEDURE sp_Elimina_Prenotazione	

	@id INT

AS 

BEGIN
	BEGIN TRANSACTION
			
		BEGIN TRY
			
			DELETE FROM prenotazione
			WHERE prenotazioneID = @id;

			COMMIT TRANSACTION 

		END TRY

	BEGIN CATCH

			ROLLBACK TRANSACTION

	END CATCH

END;

EXEC sp_Elimina_Prenotazione @id = 91;


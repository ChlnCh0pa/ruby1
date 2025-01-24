INSERT INTO student (last_name, first_name, middle_name, phone, email, telegram, github, birthdate) 
VALUES
    ('Leaman', 'Russ', 'Slonovich', '+79186654123', 'lemanruss@yandex.ru', '@russkiy_volk', 'https://github.com/prospero', CURRENT_DATE - INTERVAL '25 years'),
    ('Baralgin', 'Dimedrolovich', 'Grebneshchikov', NULL, NULL, '@agropromlox', 'https://github.com/grebenb', CURRENT_DATE - INTERVAL '28 years');
	('Afganiy', 'Sergey', 'Ivanovich', '+79528123535', 'sergey.afganiy@gmail.com', '@Afganiy', 'https://github.com/Afganiy', '1995-03-25'),
    ('Konrad', 'Dmitry', 'Vladimirovich', '+12345678990', 'dmitry.leman@gmail.com', '@DmitryL', 'https://github.com/DmitryL', CURRENT_DATE - INTERVAL '20 years'),
    ('Sangviniy', 'Mikhail', 'Sergeevich', '+98765432112', 'mikhail.sangviniy@gmail.com', '@Sangviniy', 'https://github.com/Sangviniy', '2000-08-15'::DATE - INTERVAL '24 years');
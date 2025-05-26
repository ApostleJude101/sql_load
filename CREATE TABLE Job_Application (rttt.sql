CREATE TABLE Job_Application (
    Customer_id INT,
    Money_Paid_date DATE,
    Customer_resume BOOLEAN,
    Resume_file_names VARCHAR(255),
    Cover_letter_email BOOLEAN,
    Cover_letter_file_names VARCHAR(255),
    Status_Capacity VARCHAR(50)
);

INSERT INTO job_application (
    customer_id,
    money_paid_date,
    customer_resume,
    resume_file_names,
    cover_letter_email,
    cover_letter_file_names,
    status_capacity
)

VALUES 
(1,
    '2024-02-01',
    true,
    'resume_01.pdf',
    true,
    'cover_letter_01.pdf',
    'submitted'
  ),
  (2,
    '2024-02-02',
    false,
    'resume_02.pdf',
    false,
    NULL,
    'interview scheduled'
  ),
  (3,
    '2024-02-03',
    true,
    'resume_03.pdf',
    true,
    'cover_letter_03.pdf',
    'ghosted'
  ),
  (4,
    '2024-02-04',
    true,
    'resume_04.pdf',
    false,
    NULL,
    'submitted'
  ),
  (5,
    '2024-02-05',
    true,
    'resume_05.pdf',
    true,
    'cover_letter_05.pdf',
    'rejected'
  );

SELECT*
FROM job_application;

ALTER TABLE job_application
ADD contact VARCHAR(50);

SELECT*
FROM job_application;

ALTER TABLE job_application
ADD phone_number VARCHAR(20);

ALTER TABLE job_application
RENAME COLUMN contact TO customer_name;


UPDATE job_application
SET    customer_name = 'Erlich Bachman'
WHERE  customer_id = 1;

UPDATE job_application
SET    customer_name = 'Saint Johnpaul II'
WHERE  customer_id = 2;

UPDATE job_application
SET    customer_name = 'Saint Jude De Great'
WHERE  customer_id = 3;

UPDATE job_application
SET    customer_name = 'Pope Francesco'
WHERE  customer_id = 4;

UPDATE job_application
SET    customer_name = 'Pope Benedict XVI'
WHERE  customer_id = 5;


UPDATE job_application
SET    phone_number = '(456-898-7777)'
WHERE  customer_id = 1;

UPDATE job_application
SET    phone_number = '(456-898-7877)'
WHERE  customer_id = 2;

UPDATE job_application
SET    phone_number = '(456-898-7776)'
WHERE  customer_id = 3;

UPDATE job_application
SET    phone_number = '(456-898-7706'
WHERE  customer_id = 4;

UPDATE job_application
SET    phone_number = '(456-898-7345)'
WHERE  customer_id = 5;
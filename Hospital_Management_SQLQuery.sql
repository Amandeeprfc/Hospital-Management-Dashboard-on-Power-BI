
WITH NumberedRows AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM Medical_Tests
)
DELETE FROM NumberedRows
WHERE rn = 22;


Use Hospital_Management;

SELECT * FROM [dbo].[Appointment];         -- role complete FACT TABLE
SELECT * FROM [dbo].[Doctor];              -- role complete
SELECT * FROM [dbo].[Patient]              -- role complete
SELECT * FROM [dbo].[Satisfaction_Score];  -- role complete
SELECT * FROM [dbo].[Medical_Tests];       -- role complete
SELECT * FROM [dbo].[Patient_Tests];       -- role complete



CREATE VIEW hospital_details AS
SELECT 
A.appointment_id, A.patient_id, A.appointment_date, A.appointment_time, A.status AS Appointment_Status,  
A.reason, A.notes AS Appointment_Notes, A.fees, A.payment_method, A.discount, A.diagnosis, Doc.doctor_id, Doc.name as Doctor_Name,
Doc.specialization, Doc.department, Doc.salary, Doc.availability, Doc.qualification, Doc.experience_years, Doc.Img,
Pat.name as Patient_Name, Pat.age, Pat.gender, Pat.weight, Pat.blood_group, Pat.admission_date, Pat.discharge_date,
Pat.status, Pat.Img as Patient_image, SS.rating, 
MT.test_name, MT.category as Test_Category, PT.test_date, PT.result_date, PT.notes, PT.result
FROM [dbo].[Appointment] AS A 
LEFT JOIN [dbo].[Doctor] as Doc ON A.doctor_id = Doc.doctor_id 
LEFT JOIN [dbo].[Patient] as Pat ON A.patient_id = Pat.patient_id
inner JOIN [dbo].[Satisfaction_Score] as SS on Pat.patient_id = SS.patient_id AND Doc.doctor_id = SS.doctor_id
inner JOIN [dbo].[Patient_Tests] AS PT ON Pat.patient_id = PT.patient_id
LEFT join [dbo].[Medical_Tests] as MT ON PT.test_id = MT.test_id;



-- Query Complete
Select MT.test_name, MT.category, PT.test_date, PT.result_date, PT.notes, PT.result
from [dbo].[Patient_Tests] AS PT LEFT join [dbo].[Medical_Tests] as MT
ON PT.test_id = MT.test_id;

----------------------------------------------------------------------------------------------

SELECT * FROM [dbo].[Staff];      -- role complete
SELECT * FROM [dbo].[Department]; -- role complete
 
Create View Staff_Dept_info AS
SELECT s.staff_id, d.department_id, s.name as Staff_Name, s.role, s.salary, d.name as Department_name,
d.head_doctor_id, d.total_staff, d.floor as Floar_name
from [dbo].[Staff] as s 
left join [dbo].[Department] as d 
on s.department_id = d.department_id;


SELECT * FROM [dbo].[Rooms];  -- role complete
SELECT * FROM [dbo].[Beds];   -- role complete

Create View hospital_structure AS
SELECT r.room_id, r.department_id, r.room_type, r.floor, r.daily_charge, 
b.bed_id, b.status, b.patient_id, b.occupied_from, b.occupied_till 
FROM [dbo].[Rooms] as r left join [dbo].[Beds] as b
on r.room_id = b.room_id;



-- USE FOR MEDICINE STOCKS
SELECT * FROM [dbo].[Medicine_Patient];  -- role complete
SELECT * FROM [dbo].[Medical_Stock];     -- role complete
SELECT * FROM [dbo].[Supplier];          -- role complete


CREATE VIEW medicine_supply_info AS
SELECT MP.patient_id, MP.medicine_id, MS.name as Medicine_Name, MS.category, MP.qty as Used_Quantity, 
MS.cost_price, MS.unit_price, MS.stock_qty as Total_Stock, MS.expiry_date as Medicine_Expiry_Date, 
Sup.name as Suplier_Name, Sup.contract_start_date, sup.contract_end_date  
from [dbo].[Medicine_Patient] as MP 
LEFT JOIN [Medical_Stock] as MS on MP.medicine_id = MS.medicine_id
LEFT JOIN [dbo].[Supplier] as Sup on MS.supplier_id = Sup.supplier_id;







-- `patient_info`*/;

alter view patient_info AS
SELECT 
    p.patient_id AS patient_id,
    p.name AS patient_name,
    p.gender AS patient_gender,
    p.weight AS patient_weight,
    p.age AS patient_age,
    p.blood_group AS patient_blood_group,
    p.email AS patient_email,
    p.admission_date AS patient_admission_date,
    p.discharge_date AS patient_discharge_date,
    p.address AS patient_address,
    p.Img AS patient_Img,
    p.status AS patient_status,

        CASE 
        WHEN b.bed_id IS NULL THEN 'Discharge' 
        ELSE 'Admitted' 
    END AS patient_admission_status,

    dr.doctor_id AS doctor_id,
    dr.name AS doctor_name,
    dr.salary AS doctor_salary,
    dr.specialization AS doctor_specialization,
    dr.department AS doctor_department,
    dr.availability AS doctor_availability,
    dr.joining_date AS doctor_joining_date,
    dr.qualification AS doctor_qualification,
    dr.experience_years AS doctor_experience_years,
    dr.email AS doctor_email,
    dr.phone AS doctor_phone,
    dr.Img AS doctor_Img,

    b.bed_id AS bed_id,
    b.occupied_from AS beds_occupied_from,
    b.occupied_till AS beds_occupied_till,
    b.status AS beds_status,

    r.room_id AS room_id,
    r.floor AS room_floor,
    r.room_type AS room_type,
    r.capacity AS room_capacity,
    r.daily_charge AS room_daily_charge,
    r.avgmontlymaintenancecost AS room_avg_montly_maintenance_cost,
    r.status AS room_status,

    dep.department_id AS department_id,
    dep.name AS department_name,
    dep.total_staff AS department_total_staff,

    s.satisfaction_id AS satisfaction_id,
    s.rating AS satisfaction_rating,
    s.feedback AS satisfaction_feedback,

    sur.appointment_id AS surgery_appointment_id,
    sur.appointment_date AS surgery_appointment_date,
    sur.appointment_time AS surgery_appointment_time,
    sur.status AS surgery_status,
    sur.reason AS surgery_reason,
    sur.notes AS surgery_notes,

FROM patient p
LEFT JOIN satisfaction_score s ON p.patient_id = s.patient_id
LEFT JOIN surgery sur ON sur.patient_id = p.patient_id
LEFT JOIN beds b ON b.patient_id = p.patient_id
LEFT JOIN rooms r ON r.room_id = b.room_id
LEFT JOIN department dep ON dep.department_id = r.department_id
LEFT JOIN ( SELECT DISTINCT appointment.patient_id, appointment.doctor_id FROM appointment) a ON a.patient_id = p.patient_id
LEFT JOIN doctor dr ON dr.doctor_id = a.doctor_id;

=========================

    a.appointment_date,
    a.appointment_time,
    a.reason,
    a.notes,
    a.suggest,
    a.diagnosis
    
===============================

-- Medical_stock_info View
Create View medical_stock_info AS
SELECT 
    m.medicine_id AS medicine_id,
    m.name AS name,
    m.category AS category,
    m.supplier_id AS supplier_id,
    m.cost_price AS cost_price,
    m.unit_price AS unit_price,
    m.stock_qty AS stock_qty,
    m.expiry_date AS expiry_date,
    m.manufacture_date AS manufacture_date,
    m.batch_number AS batch_number,
    m.reorder_level AS reorder_level,
    s.name AS supplier_name
FROM medical_stock m
LEFT JOIN supplier s ON m.supplier_id = s.supplier_id;


-- Patient_test View

select * from patient_tests; 
select * from medical_tests;

Create View patient_test AS
Select pt.patient_test_id, pt.patient_id, pt.test_id, pt.doctor_id, pt.test_date, 
pt.result_date, pt.result, pt.notes, pt.amount, pt.payment_method, mt.test_name, 
mt.category, mt.department_id, mt.cost, mt.duration_minutes
from patient_tests pt 
left join medical_tests mt on pt.test_id = mt.test_id;


==========================================================

Select * from medicine_patient; -- aligned 
Select * from hospital_bills;   -- aligned 
Select * from staff;            -- aligned 

==========================================================

use Hospital_Management;
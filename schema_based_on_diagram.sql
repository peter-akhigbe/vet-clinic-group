-- Create the "patients" table
CREATE TABLE patients (
  id INT PRIMARY KEY,
  name VARCHAR, 
  date_of_birth DATE
);

-- Create the "medical_histories" table
CREATE TABLE medical_histories (
  id INT PRIMARY KEY, 
  admitted_at TIMESTAMP, 
  patient_id INT, 
  status VARCHAR, 
  FOREIGN KEY (patient_id) REFERENCES patients(id) 
);

-- Create the "treatments" table
CREATE TABLE treatments (
  id INT PRIMARY KEY, 
  type VARCHAR, 
  name VARCHAR 
);

-- Create the "invoices" table
CREATE TABLE invoices (
  id INT PRIMARY KEY, 
  total_amount DECIMAL, 
  generated_at TIMESTAMP, 
  payed_at TIMESTAMP, 
  medical_history_id INT, 
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

-- Create the "invoice_items" table
CREATE TABLE invoice_items (
  id INT PRIMARY KEY, 
  unit_price DECIMAL, 
  quantity INT, 
  total_price DECIMAL, 
  invoice_id INT, 
  treatment_id INT, 
  FOREIGN KEY (invoice_id) REFERENCES invoices(id), 
  FOREIGN KEY (treatment_id) REFERENCES treatments(id) 
);

-- Create join table
CREATE TABLE medical_history_treatments (
  medical_history_id INT, 
  treatment_id INT, 
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id), 
  FOREIGN KEY (treatment_id) REFERENCES treatments(id) 
);

-- Add FK indexes
CREATE INDEX index_medical_histories_patients ON medical_histories(patient_id);   
CREATE INDEX index_invoices_medical_histories ON invoices(medical_history_id);    
CREATE INDEX index_invoice_items_invoices ON invoice_items(invoice_id);         
CREATE INDEX index_invoice_items_treatments ON invoice_items(treatment_id);

CREATE INDEX index_medical_history_treatments ON medical_history_treatments(medical_history_id);
CREATE INDEX index_medical_history_treatments ON medical_history_treatments(treatment_id);

-- =====================================
-- SETUP DO PROJETO
-- PROJETO: ANÁLISE DE CHURN DE CLIENTES
-- =====================================

-- Criar banco de dados
CREATE DATABASE churn_analysis;

-- Usar banco
USE churn_analysis;

-- Criar tabela
CREATE TABLE customers (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(50),
    InternetService VARCHAR(50),
    OnlineSecurity VARCHAR(50),
    OnlineBackup VARCHAR(50),
    DeviceProtection VARCHAR(50),
    TechSupport VARCHAR(50),
    StreamingTV VARCHAR(50),
    StreamingMovies VARCHAR(50),
    Contract VARCHAR(50),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(100),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(50),
    Churn VARCHAR(10)
);


-- Definir chave primária
ALTER TABLE customers
ADD PRIMARY KEY (customerID);


-- Corrigir valores vazios
UPDATE customers
SET TotalCharges = NULL
WHERE TotalCharges = '';

-- Converter tipo da coluna
ALTER TABLE customers
MODIFY TotalCharges DECIMAL(10,2);
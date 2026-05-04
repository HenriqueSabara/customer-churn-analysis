-- =====================================
-- PROJETO: ANÁLISE DE CHURN DE CLIENTES
-- AUTOR: Henrique Diego Sabará Silva
-- OBJETIVO: Identificar padrões de cancelamento
-- =====================================
USE churn_analysis;
-- =====================================
-- TOTAL DE CLIENTES
-- =====================================

SELECT COUNT(*) FROM customers;

-- =====================================
-- CHURN GERAL
-- =====================================
SELECT Churn, COUNT(*) AS total
FROM customers
GROUP BY Churn;

-- =====================================
-- PORCENTAGEM DE CHURN
-- =====================================
SELECT 
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS churn_rate
FROM customers;

-- =====================================
-- CHURN POR CONTRATO
-- =====================================
SELECT Contract, Churn, COUNT(*)
FROM customers
GROUP BY Contract, Churn;

-- =====================================
-- TAXA DE CHURN POR CONTRATO
-- =====================================
SELECT 
    Contract,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY Contract
ORDER BY churn_rate DESC;

-- Insight:
-- Clientes com contrato mensal apresentam maior taxa de churn,
-- indicando menor retenção comparado a contratos de longo prazo.

-- =====================================
-- CHURN POR TEMPO DE CLIENTE (TENURE)
-- =====================================
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-1 ano'
        WHEN tenure <= 24 THEN '1-2 anos'
        WHEN tenure <= 48 THEN '2-4 anos'
        ELSE '4+ anos'
    END AS faixa_tempo,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY faixa_tempo
ORDER BY churn_rate DESC;

-- Insight:
-- Clientes com até 1 ano de relacionamento apresentam a maior taxa de churn (~47%),
-- indicando que o risco de cancelamento é significativamente maior no início da jornada.
-- A retenção aumenta conforme o tempo de permanência do cliente.

-- =====================================
-- CHURN POR FAIXA DE VALOR MENSAL
-- =====================================
SELECT 
    CASE 
        WHEN MonthlyCharges < 30 THEN 'Baixo'
        WHEN MonthlyCharges < 70 THEN 'Médio'
        ELSE 'Alto'
    END AS faixa_valor,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY faixa_valor
ORDER BY churn_rate DESC;

-- Insight:
-- Clientes com maior valor mensal apresentam maior taxa de churn,
-- sugerindo que custos mais elevados podem impactar negativamente a retenção.

SELECT 
    Contract,
    CASE 
        WHEN MonthlyCharges < 30 THEN 'Baixo'
        WHEN MonthlyCharges < 70 THEN 'Médio'
        ELSE 'Alto'
    END AS faixa_valor,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY Contract, faixa_valor
ORDER BY churn_rate DESC;

-- Insight:
-- Clientes com contratos mensais e valores mais altos apresentam as maiores taxas de churn,
-- indicando um segmento de alto risco para cancelamento.

SELECT 
    Contract,
    CASE 
        WHEN MonthlyCharges < 30 THEN 'Baixo'
        WHEN MonthlyCharges < 70 THEN 'Médio'
        ELSE 'Alto'
    END AS faixa_valor,
    COUNT(*) AS total_churns
FROM customers
WHERE Churn = 'Yes'
GROUP BY Contract, faixa_valor
ORDER BY total_churns DESC;

-- Insight:
-- A grande maioria dos cancelamentos (~88%) ocorre em clientes com contratos mensais,
-- especialmente na faixa de maior valor, indicando que baixo compromisso contratual
-- combinado com alto custo é o principal fator de churn.

-- =====================================
-- CHURN POR MÉTODO DE PAGAMENTO
-- =====================================
SELECT 
    PaymentMethod,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- Insight:
-- Clientes que utilizam pagamento via electronic check apresentam a maior taxa de churn (~45%),
-- significativamente superior aos demais métodos de pagamento.



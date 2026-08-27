# Model Evaluation, Benchmarking & Champion Deployment Report

## 1. Executive Summary & Problem Context
* **Business Problem:** In the Brazilian Olist marketplace, late deliveries cause customer satisfaction (CSAT) to collapse by 1.72 stars (from 4.29 on-time baseline down to 2.57 stars for delayed orders).
* **Objective:** Deploy an early-warning delivery risk classification model that alerts logistics operations at order creation, enabling proactive carrier routing and customer alerts.
* **Evaluation Framework:** 8 candidate runs across 5 model architectures (Logistic Regression, Random Forest, LightGBM, CatBoost, XGBoost, and an Ensemble) were logged to MLflow and benchmarked across statistical discrimination, operational latency, memory footprint, and financial net value.

---

## 2. Model Leaderboard & Multi-Criteria Matrix

| Model Candidate | Val PR-AUC | Top 10% Capture | Overfit Gap | Size (MB) | p95 Latency | Net Value / 10k Orders | Verdict |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **Ensemble (LogReg + XGBoost)** | **0.1972** | **32.29%** | **+0.121** | **3.53 MB** | **8.14 ms** | **+$7,610.00** |  **CHAMPION** |
| **Logistic Regression (Reg)** | 0.1712 | 30.25% | +0.065 | 0.001 MB | 0.10 ms | +$6,890.00 |  **CHALLENGER (Fallback)** |
| **XGBoost (Tuned)** | 0.1811 | 29.71% | +0.353 | 3.53 MB | 13.92 ms | +$6,710.00 |  **CHALLENGER** |
| **CatBoost (Tuned)** | 0.1809 | 27.66% | +0.158 | 0.30 MB | 5.77 ms | +$5,945.00 | Challenger |
| **LightGBM (Tuned)** | 0.1749 | 29.06% | +0.198 | ~1.8 MB | ~4.5 ms | +$6,485.00 | Challenger |
| **Random Forest (Tuned)** | 0.1332 | 24.43% | +0.232 | 29.28 MB | 13.78 ms | +$4,775.00 |  Rejected (Heavy / Overfit) |

---

## 3. Why the Champion Model Won
1. **Highest Precision-Recall AUC (0.1972):** Delivery risk is heavily imbalanced (~8% positive class). The 50/50 probability blend of Logistic Regression (linear calibration) + XGBoost (non-linear interaction splits) yielded a +9% boost in PR-AUC over standalone XGBoost.
2. **Top Operational Capture (32.29%):** If logistics operations only intervenes on the top 10% highest-risk orders daily, the Champion catches nearly 1 out of 3 total late deliveries across the entire marketplace.
3. **Strict SLA Compliance (8.14 ms p95):** Well within the < 15ms real-time API latency budget required for checkout integration.
4. **Generalization Safety:** Standalone XGBoost overfitted heavily (Train F1 0.51 vs Val F1 0.16, gap of +0.35). Blending with regularized Logistic Regression stabilized the generalization gap to just +0.12.

---

## 4. Production Deployment & MLOps Lifecycle
* **Deployment Alias:** `@champion` in MLflow Model Registry / Unity Catalog.
* **Serving Pattern:** Real-Time Serverless Model Endpoint (for checkout SLA prediction) + Scheduled Daily Delta Lake Batch Scoring.
* **Optimal Decision Threshold:** `0.35` (optimized for high recall to prevent late customer churn).
* **Monitoring & Drift Retraining:** Automated weekly drift evaluation against Delta Gold tables; promote Logistic Regression (Regularized) as automatic fallback if latency spikes exceed 20ms.

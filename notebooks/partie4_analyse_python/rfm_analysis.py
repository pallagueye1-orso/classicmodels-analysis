import pandas as pd
from datetime import datetime

sql = """
SELECT 
    c.customerNumber,
    c.customerName,
    o.orderNumber,
    o.orderDate,
    SUM(od.quantityOrdered * od.priceEach) AS order_amount
FROM customers c
JOIN orders o USING (customerNumber)
JOIN orderdetails od USING (orderNumber)
GROUP BY c.customerNumber, o.orderNumber;
"""

df = pd.DataFrame(query(sql))

# Date de référence (par ex. max des commandes)
ref_date = df["orderDate"].max()

rfm = df.groupby(["customerNumber", "customerName"]).agg(
    Recency=("orderDate", lambda d: (ref_date - d.max()).days),
    Frequency=("orderNumber", "nunique"),
    Monetary=("order_amount", "sum")
).reset_index()

# Découpage en quartiles
rfm["R_score"] = pd.qcut(rfm["Recency"], 4, labels=[4,3,2,1])
rfm["F_score"] = pd.qcut(rfm["Frequency"].rank(method="first"), 4, labels=[1,2,3,4])
rfm["M_score"] = pd.qcut(rfm["Monetary"].rank(method="first"), 4, labels=[1,2,3,4])

rfm["RFM_score"] = rfm["R_score"].astype(int) + rfm["F_score"].astype(int) + rfm["M_score"].astype(int)

def segment(rfm_score):
    if rfm_score >= 10:
        return "VIP"
    elif rfm_score >= 7:
        return "Régulier"
    elif rfm_score >= 5:
        return "À risque"
    else:
        return "Perdu"

rfm["Segment"] = rfm["RFM_score"].apply(segment)
rfm.head()
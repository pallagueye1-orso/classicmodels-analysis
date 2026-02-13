# panier moyen par commande
sql = """
SELECT 
    o.orderNumber,
    SUM(od.quantityOrdered * od.priceEach) AS order_total
FROM orders o
JOIN orderdetails od USING (orderNumber)
GROUP BY o.orderNumber;
"""

df = pd.DataFrame(query(sql))
panier_moyen = df["order_total"].mean()
panier_moyen

# Produits souvent achetés ensemble
sql = """
SELECT 
    orderNumber,
    productCode
FROM orderdetails;
"""

df = pd.DataFrame(query(sql))

from itertools import combinations
from collections import Counter

pairs = []

for order, group in df.groupby("orderNumber"):
    products = list(group["productCode"].unique())
    if len(products) > 1:
        pairs.extend(combinations(sorted(products), 2))

counter = Counter(pairs)
top_pairs = counter.most_common(10)
top_pairs

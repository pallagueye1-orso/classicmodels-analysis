import seaborn as sns
import matplotlib.pyplot as plt

sql = """
SELECT 
    p.productCode,
    p.productName,
    p.buyPrice,
    p.MSRP,
    SUM(od.quantityOrdered) AS total_qty,
    AVG(od.priceEach) AS avg_selling_price
FROM products p
JOIN orderdetails od USING (productCode)
GROUP BY p.productCode;
"""

df = pd.DataFrame(query(sql))

corr = df[["buyPrice", "MSRP", "total_qty", "avg_selling_price"]].corr()

plt.figure(figsize=(8,6))
sns.heatmap(corr, annot=True, cmap="coolwarm", fmt=".2f")
plt.title("Matrice de corrélation produits")
plt.show()

sql = """
SELECT 
    orderDate,
    SUM(quantityOrdered * priceEach) AS total_ventes
FROM orders
JOIN orderdetails USING (orderNumber)
GROUP BY orderDate
ORDER BY orderDate;
"""

df = pd.DataFrame(query(sql))
df["orderDate"] = pd.to_datetime(df["orderDate"])
df["year_month"] = df["orderDate"].dt.to_period("M").astype(str)
df["quarter"] = df["orderDate"].dt.to_period("Q").astype(str)

# Ventes mensuelles
monthly = df.groupby("year_month")["total_ventes"].sum().reset_index()

plt.figure(figsize=(12,5))
sns.lineplot(data=monthly, x="year_month", y="total_ventes", marker="o")
plt.xticks(rotation=45)
plt.title("Ventes mensuelles")
plt.tight_layout()
plt.show()

# Ventes par trimestre
quarterly = df.groupby("quarter")["total_ventes"].sum().reset_index()

plt.figure(figsize=(8,4))
sns.barplot(data=quarterly, x="quarter", y="total_ventes")
plt.title("Ventes par trimestre")
plt.tight_layout()
plt.show()

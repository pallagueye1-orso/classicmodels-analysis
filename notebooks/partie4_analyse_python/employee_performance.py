sql = """
SELECT 
    e.employeeNumber,
    CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
    COUNT(DISTINCT c.customerNumber) AS nb_clients,
    COUNT(DISTINCT o.orderNumber) AS nb_commandes,
    SUM(od.quantityOrdered * od.priceEach) AS chiffre_affaires
FROM employees e
JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders o ON o.customerNumber = c.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
GROUP BY e.employeeNumber;
"""

df = pd.DataFrame(query(sql))

df["panier_moyen"] = df["chiffre_affaires"] / df["nb_commandes"]

df.sort_values("chiffre_affaires", ascending=False).head()

# graphique 
plt.figure(figsize=(10,6))
sns.barplot(data=df.sort_values("chiffre_affaires", ascending=False),
            x="chiffre_affaires", 
            y="employeeName")
plt.title("Chiffre d'affaires par employé")
plt.tight_layout()
plt.show()

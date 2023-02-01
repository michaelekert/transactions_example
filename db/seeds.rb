jan = User.create(name: "Jan")
wojtek = User.create(name: "Wojtek")

jan.transactions.create(description: "Initial Balance", amount: 1500)

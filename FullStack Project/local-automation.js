// local-automation.js
const express = require('express');
const mysql = require('mysql2/promise');

const app = express();
app.use(express.json());

const PORT = 3000;

// 🛠️ Using your verified local database credentials
const dbConfig = {
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'Taza061094@#\$', 
    database: 'ufa_crm_analytics'
};

let pool;
let latestDealFlag = false; // This flag changes to true when a new deal hits!

// Connect to your local MySQL Workbench database
async function initDatabase() {
    pool = await mysql.createPool(dbConfig);
    await pool.query(`
        CREATE TABLE IF NOT EXISTS local_pipeline (
            id INT AUTO_INCREMENT PRIMARY KEY,
            deal_name VARCHAR(255) NOT NULL,
            amount DECIMAL(15,2) NOT NULL,
            stage VARCHAR(100) DEFAULT 'New Transaction',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    `);
    console.log('💾 Local MySQL Database initialized successfully.');
}

// 🌐 ROUTE 1: Webhook to simulate adding a deal (No VPN required!)
app.post('/api/new-deal', async (req, res) => {
    const { name, val } = req.body;
    try {
        await pool.query(
            'INSERT INTO local_pipeline (deal_name, amount) VALUES (?, ?)',
            [name || 'Ufa Local Contract', val || 5000.00]
        );
        console.log(`\n🆕 Deal Recorded locally: "${name}" worth $${val}`);
        
        latestDealFlag = true; // Set flag to true so the ESP32 knows a deal happened!
        res.json({ success: true, message: "Deal stored in local database." });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// 🌐 ROUTE 2: Hardware Endpoint for your ESP32 Microcontroller
app.get('/api/hardware-status', (req, res) => {
    // When the ESP32 pings this route over Wi-Fi, return the flag state
    res.json({ new_deal_detected: latestDealFlag });
    
    if (latestDealFlag) {
        latestDealFlag = false; // Reset the flag once the hardware reads it
    }
});

initDatabase().then(() => {
    app.listen(PORT, () => console.log(`🚀 Automation engine active on http://localhost:${PORT}`));
});

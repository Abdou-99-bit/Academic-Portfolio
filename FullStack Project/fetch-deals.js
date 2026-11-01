const axios = require('axios');
const mysql = require('mysql2/promise');
require('dotenv').config();

const SERVICE_KEY = process.env.HUBSPOT_SERVICE_KEY;

const dbConfig = {
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'Taza061094@#\$', // Your verified Workbench password
    database: 'ufa_crm_analytics'
};

async function runDataPipeline() {
    if (!SERVICE_KEY) {
        console.error('❌ Error: HUBSPOT_SERVICE_KEY parameter missing inside your .env file!');
        return;
    }

    let pool;
    try {
        console.log('🔄 Initializing local MySQL database connection pool...');
        pool = await mysql.createPool(dbConfig);

        // 1. Setup Table Schema
        await pool.query(`
            CREATE TABLE IF NOT EXISTS hubspot_analytics (
                deal_id VARCHAR(100) PRIMARY KEY,
                deal_name VARCHAR(255),
                amount DECIMAL(15, 2),
                stage VARCHAR(100),
                last_synchronized TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            )
        `);

        console.log('📡 Fetching transaction rows from HubSpot Europe API...');
        
        // 2. TARGET EXPLICIT DATA PROPERTIES ON THE REGIONAL ROUTE
        const targetUrl = 'https://hubapi.com';
        
        const response = await axios.get(targetUrl, {
            headers: {
                'Authorization': `Bearer ${SERVICE_KEY}`,
                'Content-Type': 'application/json'
            }
        });

        // 3. Fallback extraction guard check
        const deals = response.data?.results || []; 
        
        console.log(`\n======================================================`);
        console.log(`📈 Data pipeline extracted ${deals.length} records from CRM workspace.`);
        console.log(`======================================================`);

        if (deals.length === 0) {
            console.log('💡 Notice: Zero records found. Double-check your data sync filters.');
        } else {
            // 4. Map records straight into MySQL Workbench rows
            for (const deal of deals) {
                const dealId = deal.id;
                
                // Extract parameters safely matching HubSpot's property schema object layout
                const dealName = deal.properties?.dealname || 'Ufa Deal Contract';
                const amount = parseFloat(deal.properties?.amount) || 5000.00;
                const stage = deal.properties?.dealstage || 'Appointment Scheduled';

                const sql = `
                    INSERT INTO hubspot_analytics (deal_id, deal_name, amount, stage)
                    VALUES (?, ?, ?, ?)
                    ON DUPLICATE KEY UPDATE deal_name=?, amount=?, stage=?
                `;
                
                await pool.query(sql, [dealId, dealName, amount, stage, dealName, amount, stage]);
                console.log(`✅ Pipeline Array Sync: Mapped "${dealName}" | Value: ${amount} USD/EUR`);
            }
        }

        console.log('\n✨ Data synchronization execution completed successfully.');

    } catch (error) {
        console.error('\n❌ Pipeline execution faulted:');
        if (error.response) {
            console.error(`API Error Status: ${error.response.status}`);
            console.error(error.response.data);
        } else {
            console.error(error.message);
        }
    } finally {
        if (pool) {
            await pool.end();
            console.log('🔌 Database pool connections closed securely.');
        }
    }
}

runDataPipeline();


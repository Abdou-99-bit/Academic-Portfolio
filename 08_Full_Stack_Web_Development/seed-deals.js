const axios = require('axios');
require('dotenv').config();

const SERVICE_KEY = process.env.HUBSPOT_SERVICE_KEY;

async function seedDataIntoHubSpot() {
    if (!SERVICE_KEY) {
        console.error('❌ Error: Missing your access key token!');
        return;
    }

    // Defining 2 realistic deal payloads using HubSpot's strict CRM object structure
    const testDeals = [
        {
            properties: {
                dealname: 'Ufa Web Integration Contract',
                amount: '5000.00',
                dealstage: 'appointmentscheduled' // This is the exact internal API key for "Appointment Scheduled"
            }
        },
        {
            properties: {
                dealname: 'Ufa Web Integration Contract 2',
                amount: '12500.00',
                dealstage: 'appointmentscheduled'
            }
        }
    ];

    console.log('📡 Connecting to HubSpot Europe to force-seed database rows...');

    for (const dealPayload of testDeals) {
        try {
            const response = await axios.post(
                'https://hubapi.com', 
                dealPayload, 
                {
                    headers: {
                        'Authorization': `Bearer ${SERVICE_KEY}`,
                        'Content-Type': 'application/json'
                    }
                }
            );
            console.log(`✅ Successfully seeded row: "${response.data.properties.dealname}" | Cloud ID: ${response.data.id}`);
        } catch (error) {
            console.error('❌ Failed pushing record:', error.response ? error.response.data : error.message);
        }
    }
    console.log('\n✨ Seeding process finished. Your cloud instance is no longer empty!');
}

seedDataIntoHubSpot();

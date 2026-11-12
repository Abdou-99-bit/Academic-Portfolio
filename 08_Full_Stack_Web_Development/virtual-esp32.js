// virtual-esp32.js - Your Simulated IoT Hardware Device
const axios = require('axios');

// Using your local server path
const SERVER_URL = 'http://localhost:3000/api/hardware-status';
const POLL_INTERVAL = 3000; // Poll the server every 3 seconds

console.log('🤖 [Virtual ESP32]: Hardware emulator initialized.');
console.log('📡 [Virtual ESP32]: Scanning local Wi-Fi frequencies...');
console.log(`⏱️ [Virtual ESP32]: Starting database listener loop (Polling every ${POLL_INTERVAL/1000}s)...`);

// The continuous polling engine mimicking an Arduino's void loop() structure
setInterval(async () => {
    try {
        // Ping the Express route to check the state of the MySQL pipeline
        const response = await axios.get(SERVER_URL);
        const { new_deal_detected } = response.data;

        if (new_deal_detected) {
            console.log('\n🚨🚨🚨 [VIRTUAL ESP32 ALERT] 🚨🚨🚨');
            console.log('⚡ HIGH-VALUE CRM TRANSACTION DETECTED IN LOCAL MYSQL DATABASE!');
            console.log('💡 [PIN 2]: TOGGLING INDICATOR LED -> [STATUS: HIGH / ON]');
            
            // Auto-reset the alert indicator after a 2-second timeout delay loop
            setTimeout(() => {
                console.log('💡 [PIN 2]: RESET SEQUENCE COMPLETE -> LED [STATUS: LOW / OFF]\n');
            }, 2000);
        } else {
            // Print a running line tracking the background heartbeat checks
            process.stdout.write('🟢 [Heartbeat]: Polling... No new updates. System stable...\r');

        }

    } catch (error) {
        console.error('\n❌ [Virtual ESP32 Error]: Connection to data server lost:', error.message);
    }
}, POLL_INTERVAL);

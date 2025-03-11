const assert = require('assert');

// Test 1: Node environment
assert.strictEqual(process.version.startsWith('v'), true, 'Node.js environment check failed');
console.log('✅ Node.js environment check passed');

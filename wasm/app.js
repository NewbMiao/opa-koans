const fs = require('fs');
const Rego = require("@open-policy-agent/opa-wasm");

// Read the policy wasm file
const policy_wasm = fs.readFileSync('policy.wasm');
// Read the data file
const policy_data = fs.readFileSync('../quick-start/data.json');

// Initialize the Rego object and load the wasm program
const rego = new Rego();

// Load the policy module asynchronously
rego.load_policy(policy_wasm).then(policy => {

    // Use console parameters for the input, do quick
    // validation by json parsing. Not efficient.. but
    // will raise an error
    const input = JSON.parse(process.argv[2]);
    // Provide a data document with a string value
    policy.set_data(JSON.parse(policy_data))

    // Evaluate the policy and log the result
    const result = policy.evaluate(input);
    console.log(JSON.stringify(result))

}).catch(err => {
    console.log("ERROR: " + err)
});
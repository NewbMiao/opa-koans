const fs = require('fs');
const {loadPolicy} = require("@open-policy-agent/opa-wasm");

// Read the policy wasm file
const policyWasm = fs.readFileSync('policy.wasm');
// Read the data file
const policyData = fs.readFileSync('data.json');

// Load the policy module asynchronously
loadPolicy(policyWasm).then(policy => {

    // Use console parameters for the input, do quick
    // validation by json parsing. Not efficient.. but
    // will raise an error
    const input = JSON.parse(process.argv[2]);
    // Provide a data document with a string value
    policy.setData(JSON.parse(policyData))

    // Evaluate the policy and log the result
    const result = policy.evaluate(input);
    console.log(JSON.stringify(result))

}).catch(err => {
    console.log("ERROR: " + err)
});
// usage:
// node app.js "$(cat ../entitlements/input.json)"

const fs = require("fs");
const { loadPolicy } = require("@open-policy-agent/opa-wasm");
const yaml = require('js-yaml');

// Read the policy wasm file
const policyWasm = fs.readFileSync("policy.wasm");

// Load the policy module asynchronously
loadPolicy(policyWasm).then((policy) => {
  // Use console parameters for the input, do quick
  // validation by json parsing. Not efficient.. but
  // will raise an error
  const input = JSON.parse(fs.readFileSync(process.argv[2]));
  const data = JSON.parse(fs.readFileSync(process.argv[3]));
  

  
  // Provide a data document with a string value
  policy.setData(data);

  // Evaluate the policy and log the result
  const result = policy.evaluate(input, 'entitlements/main');
  console.log(JSON.stringify(result, null, 2));
}).catch((err) => {
  console.log("ERROR: ", err);
  process.exit(1);
});
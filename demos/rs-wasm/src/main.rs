use anyhow::{Context, Result};
use clap::{command, Parser};
use opa_wasm::{
    wasmtime::{Config, Engine, Module, Store},
    Runtime,
};
use serde_json::Value;
use tokio::fs;

#[derive(Parser, Debug)]
#[command(
    about = "Evaluate OPA policy with input and data JSON files",
    version = "0.1.0",
    author = "newbmiao"
)]
struct Args {
    #[clap(short, long, default_value = "../entitlements/data.json")]
    data_file: String,

    #[clap(short, long, default_value = "../entitlements/input.json")]
    input_file: String,
}

#[tokio::main]
async fn main() -> Result<()> {
    let args = Args::parse();

    // Configure the WASM runtime
    let mut config = Config::new();
    config.async_support(true);

    let engine = Engine::new(&config)?;

    // Load the policy WASM module
    let module_data = fs::read("./policy.wasm")
        .await
        .context("Failed to read policy.wasm file")?;
    let module = Module::new(&engine, module_data)?;

    // Create a store which will hold the module instance
    let mut store = Store::new(&engine, ());

    // Load and parse data and input JSON files
    let data = load_json(&args.data_file).await?;
    let input = load_json(&args.input_file).await?;

    // Instantiate the module
    let runtime = Runtime::new(&mut store, &module)
        .await
        .context("Failed to create OPA runtime")?;

    let policy = runtime
        .with_data(&mut store, &data)
        .await
        .context("Failed to set data in OPA runtime")?;

    // Evaluate the policy
    let res: Value = policy
        .evaluate(&mut store, "entitlements/main", &input)
        .await
        .context("Failed to evaluate policy")?;

    println!("{}", res);

    Ok(())
}

async fn load_json(path: &str) -> Result<Value> {
    let content = fs::read_to_string(path)
        .await
        .context(format!("Failed to read JSON file: {}", path))?;
    let json: Value =
        serde_json::from_str(&content).context(format!("Failed to parse JSON file: {}", path))?;
    Ok(json)
}

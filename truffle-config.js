module.exports = {
    /* ... rest of truffle-config */
    compilers: {
        solc: [
            {
                version: "0.8.7",
            },
        ],
    },
    plugins: ["truffle-contract-size"],
}

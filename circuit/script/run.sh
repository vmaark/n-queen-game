#!/bin/sh
set -e

# if zkey does not exist, make folder
[ -d zk/zkey ] || mkdir zk/zkey

# if ptau does not exist, make folder
[ -d zk/ptau ] || mkdir zk/ptau

CIRCUIT=game

# Compile circuits
circom ${CIRCUIT}.circom -o ./zk/ --r1cs --wasm --sym

#Computing the witness
node zk/${CIRCUIT}_js/generate_witness.js zk/${CIRCUIT}_js/${CIRCUIT}.wasm inputs/game.json zk/${CIRCUIT}_js/witness.wtns

# #Powers of tau ceremony
yarn snarkjs powersoftau new bn128 12 zk/ptau/pot12_0000.ptau -v
yarn snarkjs powersoftau contribute zk/ptau/pot12_0000.ptau zk/ptau/pot12_0001.ptau --name="First contribution" -v

#Prepare phase and generate reference zkey
yarn snarkjs powersoftau prepare phase2 zk/ptau/pot12_0001.ptau zk/ptau/pot12_final.ptau -v
yarn snarkjs groth16 setup zk/${CIRCUIT}.r1cs zk/ptau/pot12_final.ptau zk/zkey/${CIRCUIT}_0000.zkey
yarn snarkjs zkey contribute zk/zkey/${CIRCUIT}_0000.zkey zk/zkey/${CIRCUIT}_0001.zkey --name="1st Contributor Name" -v

#Export verification key
yarn snarkjs zkey export verificationkey zk/zkey/${CIRCUIT}_0001.zkey zk/verification_key.json

#Generating a Proof
yarn snarkjs groth16 prove zk/zkey/${CIRCUIT}_0001.zkey zk/${CIRCUIT}_js/witness.wtns zk/proof.json zk/public.json

#Verifying a Proof
yarn snarkjs groth16 verify zk/verification_key.json zk/public.json zk/proof.json


# #Verifying from a Smart Contract
# yarn snarkjs zkey export solidityverifier zk/zkey/decryption/${CIRCUIT}_0001.zkey ./contracts/DecryptionVerifier.sol

# Copy zkkey and wasm to test folder
cp zk/zkey/${CIRCUIT}_0001.zkey zk/${CIRCUIT}_js/${CIRCUIT}.wasm zk/verification_key.json ts/__tests__/zk
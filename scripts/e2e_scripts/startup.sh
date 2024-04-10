#!/usr/bin/bash
set -e

source /app/scripts/e2e_scripts/variables.sh

echo "Model Information" 
echo "MODEL_PATH: $MODEL_PATH" 
echo "WORLD_SIZE: $WORLD_SIZE" 
echo "ACTIVATION_DTYPE: $ACTIVATION_DTYPE" 
echo "MAX_BATCH_SIZE: $MAX_BATCH_SIZE" 
echo "MAX_INPUT_LEN: $MAX_INPUT_LEN" 
echo "MAX_OUTPUT_LEN: $MAX_OUTPUT_LEN" 
echo "MODEL_NAME: $MODEL_NAME" 
echo "VARIATION_NAME: $VARIATION_NAME" 
echo "FRAMEWORK: $FRAMEWORK" 
echo "CHECKPOINT_DIR: $CHECKPOINT_DIR" 
echo "UNIFIED_CHECKPOINT_DIR: $UNIFIED_CHECKPOINT_DIR" 
echo "ENGINE_DIR: $ENGINE_DIR" 
echo "TOKENIZER_DIR: $TOKENIZER_DIR" 
echo "MODEL_SCRIPTS_DIR: $MODEL_SCRIPTS_DIR" 
echo "INFLIGHT_BATCHER_MODELS_DIR: $INFLIGHT_BATCHER_MODELS_DIR"
echo "VOCAB_FILE_PATH: $VOCAB_FILE_PATH"

echo -e "\nCreating Directories"
mkdir -p ${CHECKPOINT_DIR}
mkdir -p ${TOKENIZER_DIR}
mkdir -p ${UNIFIED_CHECKPOINT_DIR}
mkdir -p ${ENGINE_DIR}
echo "Directory Creation Completed"

echo -e "\nModel Checkpoint Download Started"
/app/scripts/e2e_scripts/download_checkpoint.sh
echo -e "Model Checkpoint Download Completed"

echo -e "\nEngine Creation Process Started" 
/app/scripts/e2e_scripts/create_engine.sh
echo -e "\nEngine Creation Process Completed \n" 

echo -e "\nRunning Test Inference on Build Engine"
/app/scripts/e2e_scripts/test_inference.sh

/app/scripts/e2e_scripts/build_run_server.sh


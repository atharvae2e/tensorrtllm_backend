#!/usr/bin/bash 
set -e
source /app/scripts/e2e_scripts/variables.sh

echo "Installing Engine Creation Dependencies" 
pip3 install -r ${MODEL_SCRIPTS_DIR}/requirements.txt 
echo -e "\nConverting Checkpoint to unified TensorRT-LLM checkpoint" 
python3 ${MODEL_SCRIPTS_DIR}/convert_checkpoint.py \
    --ckpt-type ${FRAMEWORK} \
    --model-dir ${CHECKPOINT_DIR} \
    --dtype ${ACTIVATION_DTYPE} \
    --world-size ${WORLD_SIZE} \
    --output-model-dir ${UNIFIED_CHECKPOINT_DIR} 

echo "Unified TensorRT-LLM Checkpoint Created" 

echo -e "\nCopy Tokenizer.model to TOKENIZER_DIR" 
cp ${CHECKPOINT_DIR}/tokenizer.model ${TOKENIZER_DIR} 
echo "Copied! Tokenizer.model to TOKENIZER_DIR" 

echo -e "\nModel Checkpoint Deletion Started" 
rm -rf ${CHECKPOINT_DIR} 
echo "Model Checkpoint Deletion Completed" 

echo -e "\nEngine Creation started using unified TensorRT-LLM checkpoint" 

trtllm-build --checkpoint_dir ${UNIFIED_CHECKPOINT_DIR} \
             --gemm_plugin ${ACTIVATION_DTYPE} \
             --gpt_attention_plugin ${ACTIVATION_DTYPE} \
             --max_batch_size ${MAX_BATCH_SIZE} \
             --max_input_len ${MAX_INPUT_LEN} \
             --max_output_len ${MAX_OUTPUT_LEN} \
             --output_dir ${ENGINE_DIR} 

echo "Engine Created" 

echo -e "\nUnified Checkpoint Deletion Started" 
rm -rf ${UNIFIED_CHECKPOINT_DIR} 
echo "Unified Checkpoint Deletion Completed"



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



python3 ${MODEL_SCRIPTS_DIR}/../run.py --engine_dir ${ENGINE_DIR} \
                  --max_output_len 200 \
                  --vocab_file ${VOCAB_FILE_PATH} \
                  --input_text "Explain in Detail, What is GPU ?"

python3 ${MODEL_SCRIPTS_DIR}/../summarize.py --test_trt_llm \
                        --engine_dir ${ENGINE_DIR} \
                        --batch_size ${MAX_BATCH_SIZE} \
                        --max_ite 5 \
                        --vocab_file ${VOCAB_FILE_PATH}

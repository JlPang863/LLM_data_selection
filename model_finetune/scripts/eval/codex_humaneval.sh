# Here we use 1 GPU for demonstration, but you can use multiple GPUs and larger eval_batch_size to speed up the evaluation.
############################################################################################################
eval_dataset_name='codex_humaneval'

train_dataset_name=$1
labeling_model=$2
base_model=$3
# models=$4
# save_dirs=$5
# cuda_devices=$6

# 恢复传递的数组
eval "$4"
eval "$5"
eval "$6"

for key in "${!models[@]}"; do
    CUDA_VISIBLE_DEVICES=${cuda_devices[$key]} nohup python -m eval.codex_humaneval.run_eval \
    --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz \
    --eval_pass_at_ks 1 5 10 20 \
    --unbiased_sampling_size_n 20 \
    --temperature 0.1 \
    --save_dir ${save_dirs[$key]} \
    --model ${models[$key]} \
    --tokenizer ${models[$key]} > ./logs/llama_${eval_dataset_name}_${key}.log &
done


############################################################################################################
# llama_7B_model='meta-llama/Llama-2-7b-hf'
# # # Evaluating llama 7B model using temperature 0.1 to get the pass@1 score
# CUDA_VISIBLE_DEVICES=3 nohup python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.1 \
#     --save_dir results/codex/llama_7B_base \
#     --model $llama_7B_model \
#     --tokenizer $llama_7B_model >  zzz_llama_codex_base.log &


# # Evaluating llama 7B model using temperature 0.8 to get the pass@10 score
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz \
#     --eval_pass_at_ks 10 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.8 \
#     --save_dir results/codex_humaneval/llama_7B_temp_0_8 \
#     --model ../hf_llama_models/7B/ \
#     --tokenizer ../hf_llama_models/7B/ \
#     --use_vllm


# # Evaluating tulu 7B model using temperature 0.1 to get the pass@1 score with chat format via HumanEvalPack
# # This leads to ~same scores as without chat format, see https://github.com/allenai/open-instruct/pull/99#issuecomment-1953200975
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz  \
#     --data_file_hep raw_data/eval/codex_humaneval/humanevalpack.jsonl  \
#     --use_chat_format \
#     --chat_formatting_function eval.templates.create_prompt_with_tulu_chat_format \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.1 \
#     --save_dir results/codex_humaneval/tulu_7B_temp_0_1 \
#     --model ../checkpoints/tulu_7B/ \
#     --tokenizer ../checkpoints/tulu_7B/ \
#     --use_vllm

# # Evaluating tulu 7B model using temperature 0.1 to get the pass@1 score with chat format via HumanEvalPack
# # And use the HumanEval+ data for more rigorous evaluation.
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEvalPlus-OriginFmt.jsonl.gz  \
#     --data_file_hep raw_data/eval/codex_humaneval/humanevalpack.jsonl  \
#     --use_chat_format \
#     --chat_formatting_function eval.templates.create_prompt_with_tulu_chat_format \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.1 \
#     --save_dir results/codex_humaneval/tulu_7B_temp_0_1 \
#     --model ../checkpoints/tulu_7B/ \
#     --tokenizer ../checkpoints/tulu_7B/ \
#     --use_vllm

# # you can also use humaneval+ without the HumanEvalPack data
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEvalPlus-OriginFmt.jsonl.gz  \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.1 \
#     --save_dir results/codex_humaneval/tulu_7B_temp_0_1 \
#     --model ../checkpoints/tulu_7B/ \
#     --tokenizer ../checkpoints/tulu_7B/ \
#     --use_vllm

# # Evaluating tulu 7B model using temperature 0.1 to get the pass@1 score without chat format
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz  \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.1 \
#     --save_dir results/codex_humaneval/tulu_7B_temp_0_1_nochat \
#     --model ../checkpoints/tulu_7B/ \
#     --tokenizer ../checkpoints/tulu_7B/ \
#     --use_vllm


# # Evaluating tulu 7B model using temperature 0.8 to get the pass@10 score without chat format
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz  \
#     --eval_pass_at_ks 10 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.8 \
#     --save_dir results/codex_humaneval/tulu_7B_temp_0_8_nochat \
#     --model ../checkpoints/tulu_7B/ \
#     --tokenizer ../checkpoints/tulu_7B/ \
#     --use_vllm

# # Evaluating chatgpt using temperature 0.1 to get the pass@1 score
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.1 \
#     --openai_engine "gpt-3.5-turbo-0301" \
#     --save_dir results/codex_humaneval/chatgpt_temp_0.1/ \
#     --eval_batch_size 10


# # Evaluating chatgpt using temperature 0.8 to get the pass@10 score
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.8 \
#     --openai_engine "gpt-3.5-turbo-0301" \
#     --save_dir results/codex_humaneval/chatgpt_temp_0.8/ \
#     --eval_batch_size 10


# # Evaluating gpt4 using temperature 0.1 to get the pass@1 score
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.1 \
#     --openai_engine "gpt-4-0314" \
#     --save_dir results/codex_humaneval/gpt4_temp_0.1 \
#     --eval_batch_size 1


# # Evaluating gpt4 using temperature 0.8 to get the pass@10 score
# python -m eval.codex_humaneval.run_eval \
#     --data_file raw_data/eval/codex_humaneval/HumanEval.jsonl.gz \
#     --eval_pass_at_ks 1 5 10 20 \
#     --unbiased_sampling_size_n 20 \
#     --temperature 0.8 \
#     --openai_engine "gpt-4-0314" \
#     --save_dir results/codex_humaneval/gpt4_temp_0.8 \
#     --eval_batch_size 1

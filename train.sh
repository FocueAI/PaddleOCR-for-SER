# recommended paddle.__version__ == 2.0.0
python3 -m paddle.distributed.launch --log_dir=./debug/ --gpus '0,1,2,3,4,5,6,7'  tools/train.py -c configs/rec/rec_mv3_none_bilstm_ctc.yml




####  ser_vi_layoutxlm_xfund_zh.yml 只想训练 SER模型
#  现在 SER模型的训练部分已经跑通!!!!

[参考链接](https://paddlepaddle.github.io/PaddleOCR/main/ppocr/model_train/kie.html#13)

python tools/train.py -c configs/kie/vi_layoutxlm/ser_vi_layoutxlm_xfund_zh.yml


# 测试
python3 tools/infer_kie_token_ser.py -c configs/kie/vi_layoutxlm/ser_vi_layoutxlm_xfund_zh.yml -o Architecture.Backbone.checkpoints=./output/ser_vi_layoutxlm_xfund_zh/best_accuracy Global.infer_img=./train_data_new1/det_bookspine_text/test_imgs/n0801005-02-01_4.jpg



# 模型转换

# step1: 训练模型 ---> 推理模型
python tools/export_model.py -c configs/kie/vi_layoutxlm/ser_vi_layoutxlm_xfund_zh.yml -o Architecture.Backbone.checkpoints=./output/ser_vi_layoutxlm_xfund_zh/best_accuracy  Global.save_inference_dir=./inference/ch_PP-OCRv4-spine/

# step2: 推理模型 ---> onnx
paddle2onnx --model_dir inference/ch_PP-OCRv4-spine \
            --model_filename inference.pdmodel \
            --params_filename inference.pdiparams \
            --save_file inference-bookspine_info_cls.onnx \
            --enable_onnx_checker True
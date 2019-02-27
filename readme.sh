1. Xml to csv, generate a seed_labels.csv file 
python 01_xml_to_csv.py

2. Generate the tfrecord file 
python 02_generate_tfrecord.py --csv_input=annotation/seeds_labels.csv --output_path=train.record

3. Run tensorflow pre-trained faster-rcnn model 
python3 03_train.py --logtostderr --pipeline_config_path=pipeline.config --train_dir=train_dir --num_clones=3

4. Evaluate model 
python3 04_eval.py --logtostderr --checkpoint_dir=train_dir --eval_dir=path/to/eval_dir --pipeline_config_path=pipeline_config.pbtxt

5. Generate frozen checkpoint 
python3 05_export_inference_graph.py --input_type image_tensor --pipeline_config_path pipeline.config --trained_checkpoint_prefix train_dir/model.ckpt- --output_directory graph_train

6. Detect seeds using trained model 
python 06_detect.py
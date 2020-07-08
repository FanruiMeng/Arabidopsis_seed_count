<h2>Arabidopsis seeds count using Tensorflow Faster-RCNN model</h2>
<h3>1 Tensorflow object detection API installation</h3>
  tensorflow version lower than 2.0.
  please see: 
  https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md

<h3>2 Seed annotation</h3>
  we use LabelImg annotate our seeds, LabelImg generate a xml annotation file.<br>
  LabelImag please see:<br>
  https://github.com/tzutalin/labelImg<br>
  For our project, we split one whole plate image into 4 quater images and annotate quater images mannually.<br>
  <b>1. split image:</b><br>
  python 00_split_scan_images.py<br>
  <b>2. seed annotation</b>
  <img src=""  alt="Seed annotation" />
<h3>3. Xml file transform to csv file</h3>
  pyhton 02_xml_to_csv.py<br>
  Results is a csv file,like this:<br><br>
  <table>
  <tr><td><b>filename</b></td> <td><b>width</b></td> <td><b>height</b></td> <td><b>class</b></td> <td><b>xmin</b></td><td><b>ymin</b></td><td><b>xmax</b></td><td><b>ymax</b></td></tr>
  <tr><td>scan21_111918022.jpg</td> <td>2900</td> <td>2900</td> <td>seed</td> <td>1325</td><td>813</td><td>1352</td><td>837</td></tr>
  <tr><td>scan21_111918022.jpg</td> <td>2900</td> <td>2900</td> <td>seed</td> <td>664</td><td>1094</td><td>691</td><td>1116</td></tr>
  <tr><td>..</td> <td>..</td> <td>..</td> <td>..</td> <td>..</td><td>..</td><td>..</td><td>..</td></tr>
  </table>
<h3>4. seed_labels.csv transform to tensorflow tfrecord file </h3>
  python 02_generate_tfrecord.py --csv_input=annotation/seeds_labels.csv --output_path=train.record

5. Download the tensorflow object detection api pre-trained faster rcnn model into your work directory.
  wget http://download.tensorflow.org/models/object_detection/faster_rcnn_inception_v2_coco_2018_01_28.tar.gz
  unzip faster_rcnn_inception_v2_coco_2018_01_28.tar.gz

6. Run tensorflow pre-trained faster-rcnn model using your own dataset
  a. Change the input path into your train.record absolute path at train_input_reader in pipeline configure file
  b. Change the label_map_path into your label_map.pbtxt path. The label_map.pbtxt file like below:
  item {
    id: 1
    name: "seed"
  }
  c. Another configurations please see: 
  https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/configuring_jobs.md
  d. Model training
  python3 03_train.py --logtostderr --pipeline_config_path=pipeline.config --train_dir=train_dir --num_clones=3

7. Evaluate model 
  #Evalutaing and training must run at same time
  python3 04_eval.py --logtostderr --checkpoint_dir=train_dir --eval_dir=path/to/eval_dir --pipeline_config_path=pipeline_config

8. Generate frozen model 
  python3 05_export_inference_graph.py --input_type image_tensor --pipeline_config_path pipeline.config --trained_checkpoint_prefix train_dir/model.ckpt- --output_directory graph_train

9. Detect seeds using trained model 
  python 06_detect.py

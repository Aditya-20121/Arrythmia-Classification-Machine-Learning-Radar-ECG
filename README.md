
# Classification of Atrial Rhythm and Ventricular Rhythm using Wearable Electrocardiogram database



## Dataset used

Used the dataset from research paper **An Open-Access Arrhythmia Database of Wearable Electrocardiograme** dataset  which is available below:


In total, the database contains 2000 30-s recordings of sinus, atrial and ventricular arrhythmias collected from more than 200 voluntary patients who had been diagnosed with heart diseases, ranging in age from 18 to 82. For more detail about the dataset, you can check this link: [Research paper](https://link.springer.com/article/10.1007/s40846-020-00554-3 )

An Open-access Database for the Evaluation of Cardio-mechanical Signals from Patients with Valvular Heart Diseases" could be downloaded from the following link: [link](https://shelab.oss-cn-beijing.aliyuncs.com/Data/SCG_GCG_VHD_Public_version_1_0.zip)

 
 
## Dataset Preparation

1. **Run `mat_to_csv_A.m` and `mat_to_csv_A.m`** 
This will created`1_ECG_only_A.csv` and `1_ECG_only_V.csv` which are to be used later on.

2. The dataset contains three folder named A, N, V. We are using the dataset available in A and V folders of the provided dataset
#### Run: **data_augmentation_AV_data.m**

The file `data_augmentation_AV_data.m` not only concatenates but also augmentes the data present in `1_ECG_only_A.csv` and `1_ECG_only_V.csv`. Successful execution of `data_augmentation_AV_data.m` leads to the creation of our another dataset `3_AV_ECG_augmented_data.mat`, On which we will apply various different Machine Learning algorithms.

3. Run **Features_Extraction.m** file to extract features from the .csv files created earlier.

## Code Execution
4. *Once your **4_AV_features.csv** and **5_AV_features_augmented_data.csv** file is created, Run **features_without_augmentation.ipynb** and **features_with_augmentation.ipynb** files respectively to reproduce the results*


## Programming languages used
* Python
* MATLAB


## Packages used
* numpy
* pandas
* matplotlib
* sklearn
* tensorflow
* keras

## References
Shen, Q., Gao, H., Li, Y., Sun, Q., Chen, M., Li, J., & Liu, C. (Year). An Open-Access Arrhythmia Database of Wearable Electrocardiogram. *Journal of Medical and Biological Engineering (2020)*, 40:564–574.


For any query feel free to mail at : `adityakakade2021@gmail.com`

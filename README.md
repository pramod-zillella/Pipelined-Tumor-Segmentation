# Pipelined-Tumor-Segmentation


## Introduction

The proposed algorithm uses Berkeley wavelet transform, Channel information, Simple thresholding, and Morphological operations for both automated skull stripping and tumor segmentation from brain MRI. It is not an iterative algorithm, It doesn’t require a user to initialize any values.It is Computationally efficient with a minimized processing time of about less than one second to run the algorithm and perform skull stripping and tumor segmentation. It is a Fully automated method for skull stripping and tumor segmentation. Below is the flow of the algorithm.

<p align="center">
<img src="https://user-images.githubusercontent.com/63542593/119772110-4e429100-bedc-11eb-8f0f-c9499d2a3a8f.png" width="700">             
</p>

## Methodology

1) Berkeley Wavelet transform is applied on the brain MRI to generate a BWT Feature map. The unique advantage of using BWT is that it clearly delineates the different brain MRI regions and highlights the transitions. This can be evidenced by the color channel decomposition of the generated feature map into R G B Channels. R channel contains the skull region, G channel containing the enhanced MRI image used for skull stripping, and B channel is not used in this study.

2) The obtained R channel is binarized using a simple thresholding operation (threshold= 60). It Is enhanced using Morphological imerode, bwpack, and imdilate functions and Mapped onto the G channel to obtain the Skull stripped image. (Reason for the threshold at 60 is it included all the skull region).

3) Enhanced Brain region is obtained after the skull stripping operation and thresholding operation with a threshold at 180 ( worked well with all the samples) generated segmented region and Morphological operations of bwareafilt, imdilate, are used for tumor segmentation from the brain region. The boundary of the tumor can be obtained using Morphological bwboundaries operation. The proposed algorithm is unique as it uses decomposed BWT feature Map Channel information along with simple thresholding for automated skull stripping and tumor segmentation and boundary detection to achieve legitimate results.

## Segmentation Results

| Test Images  | Jaccard Similarity Index | Sensitivity | Specificity | Dice Coefficient | Accuracy | Processing Time(Sec) | 
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | 
| Image-1  | 0.89490741  | 0.92977393  | 0.999548208  | 0.944539458  | 0.9987484 | 0.773  |
| Image-2  | 0.84296808  | 0.92039567  | 0.998912085  | 0.914794007  | 0.997993  | 0.777  | 
| Image-3  | 0.90644244  | 0.92305837  | 0.999788055  | 0.950925581  | 0.998911  | 0.819  | 
| Image-4  | 0.89650422  | 0.93869455  | 0.999279109  | 0.94542813   | 0.9983651 | 0.674  | 
| Image-5  |  0.90875772 | 0.92754479  | 0.999706418  | 0.95219808   | 0.998696  | 0.992  | 
| Image-6  | 0.83814405  | 0.92635659  | 0.999017742  | 0.911945994  | 0.9983459 | 1.117  | 
| Image-7  | 0.80613597  | 0.86873902  | 0.998000713  | 0.892663657  | 0.9947564 | 1.199  | 
| Image-8  | 0.93059791 | 0.98109899  | 0.998419706  | 0.964051505  | 0.9979296 | 0.758  | 
| Image-9  | 0.8800759   | 0.92078618  | 0.999348603  | 0.936213161  | 0.9982577  | 0.756  | 
| Average  |0.87828152  | 0.92627201  | 0.999113404  | 0.934751064  | 0.9980003  | 0.873sec  | 

### Skull Stripping:
![2'-12_BWT](https://user-images.githubusercontent.com/63542593/119775862-d24b4780-bee1-11eb-89bd-900bb75ef07b.png)
### Tumor Segmentation:
![2'-12_Tumor_Segmentation](https://user-images.githubusercontent.com/63542593/119775854-d0818400-bee1-11eb-9662-033d3159c597.png)

## Conclusion:
The proposed method is the good interms of processing complexity, with less than 1 second for skull stripping and tumor segmentation. Deep learning based models are the state-of-the-art methods with high computational complexity and take several minutes for tumor segmentation alone.







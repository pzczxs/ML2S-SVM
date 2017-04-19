# ML2S-SVM
Multi-label Least-Squares Support Vector Machines

## 1. Introduction

### 1.1. Description
In multi-label classification, each example is associated with a set of labels. Though multi-label classification was mainly motivated by the tasks of text categorization and medical diagnosis in the past, it is increasing important in modern applications, ranging from protein function classification, music categorization, and semantic scene classification, etc.  

Many multi-label classification problems share two main characteristics: (a) there exists some underling (potentially nonlinear) cross relatedness among different labels; (b) the number of examples for different labels is not nearly even. Most of current methods are devoted to either model label relationship, or to only deal with unbalanced phenomenon with traditional single-label methods. 

In this toolbox, multi-label classification problem is regarded as an unbalanced multi-task learning problem. Multi-task least-squares support vector machine (MTLS-SVM) [1] is directly generalized for multi-label classification problem, named as ML2S-SVM, which is able to consider two above characteristics simultaneously. ML2S-SVM is a MATLAB implementation of ML2S-SVM with the more efficient training algorithm in [2]. Please refer [2] for more details. 

### 1.2. News, Comments, and Bug Reports.
We highly appreciate any suggestion, comment, and bug report.

### 1.3. License
ML2S-SVM is a free MATLAB toolbox; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

MLSSVR is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with MLSSVR; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.

## 2. How to Use ML2S-SVM

### 2.1. Command Line & Input Parameters

```
matlab> [alpha, b] = ML2SVMTrain(train_inst, train_lbl, gamma, mu, p);
  -train_inst:
    An n by d matrix of d training instances with d features.
    It should be dense (type must be double).
  -train_lbl:
    An n by 1 vector of training labels (type must be cell of double).
  -gamma: 
    A positive real regularized parameter (type must be double). 
  -mu: 
    Another positive real regularized parameter (type must be double). 
  -p: 
    The positive hyperparameter of radial basis function (RBF) kernel function (type must be double). 
```

```
matlab> [predict_lbl]= ML2SSVMPredict(test_inst, train_inst, train_lbl, alpha, b, mu, p);
  -test_inst: 
    An n by d matrix of n testing instances with d features. It should be dense (type must be double). 
  -train_inst:
    The instance matrix used for training.  
  -train_lbl:
    The label vector used for training. 
  -alpha:
    The output of ML2SVMTrain.
  -b: 
    The output of ML2SVMTrain. 
  -mu:
    A positive real regularized parameter.
    It should be same as counterpart in ML2SVMTrain. 
  -p: 
    The positive hyperparameter of RBF kernel function. 
    It should be same as counterpart in ML2SVMTrain.  
```

### 2.2. Examples

Train and test on the provided data scene:

```
matlab> load scene
matlab> [alpha, b] = ML2SVMTrain(train_inst, train_lbl, 2^3, 2^2, 2^-3);
matlab> [predict_lbl]= ML2SSVMPredict(test_inst, train_inst, train_lbl, alpha, b, 2^2, 2^-3); 
```

In order to select proper parameters with 10-fold cross validation, you can use the following utility: 

```
matlab> load scene
matlab> [gamma_best, lambda_best, p_best, loss_best] = GridML2SSVM(train_inst, train_lbl, 10, 0, 0, 0, inf); 
```

### 2.3. Additional Information

This toolbox is written by [XU, Shuo](http://xushuo.space/wiki/) from [Beijing University of Technology](http://www.bjut.edu.cn). If you find this toolbox useful, please cite MLS-SVR as follows:

Shuo Xu, 2016. Multi-Label Least-Squares Support Vector Machines for Multi-Label Classification. (under review)

For any question, please contact XU, Shuo <xushuo@bjut.edu.cn> OR <pzczxs@gmail.com>.

## 3. References
[1] Shuo Xu, Xin An, Xiaodong Qiao, and Lijun Zhu, 2014. [Multi-Task Least-Squares Support Vector Machines](http://doi.org/10.1007/s11042-013-1526-5). *Multimedia Tools and Applications*, Vol. 71, No. 2, pp. 699-715.   

[2] Shuo Xu, 2016. Multi-Label Least-Squares Support Vector Machines for Multi-Label Classification. 

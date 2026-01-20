# GDIIST DPABISurfSlurm使用手册

官方教程链接：[https://rfmri.org/DPABISurfSlurm](https://rfmri.org/DPABISurfSlurm)

DPABISurfSlurm是DPABISurf的高性能计算版本，能运行在高性能计算中心（或者称为超算）。唯一需要的工具包是Singularity。

本使用手册使用的DPABISurfSlurm_GDIIST已经经过适配，能正确运行在广东省智能院（GDIIST）的创新平台上。

DPABISurfSlurm的运行依赖于6个路径，需要一一确定并填写：
| 变量名 | 路径 |
| --- | --- |
| `DPABISurfSlurmDIR` | DAPBISurfDlurm工具所有脚本所在的路径 |
| `SetEnvScriptDir` | `SetEnv.sh`所在路径 |
| `DATADIR` | BIDS文件夹所在的父级路径 |
| `SingularityDIR` | 两个`.sif`镜像文件所在路径，即`DPABISurfSlurm_SingularityFiles`文件夹 |
| `FreeSurferLicenseDIR` | FreeSurfer的License文件所在路径 |

## 使用步骤：

### 1.准备
克隆本仓库到“创新平台”本地用户下
```
git clone https://github.com/ZhaoyuDeng/DPABISurfSlum_GDIIST.git
```
在此，变量`DPABISurfSlurmDIR`应为`.../DPABISurfSlum_GDIIST/DPABISurfSlurm`

申请[FreeSurfer License](https://surfer.nmr.mgh.harvard.edu/fswiki/License)。变量`FreeSurferLicenseDIR`即为存放`license.txt`文件的路径。

### 2.下载Singularity镜像
方法1：在终端输入以下命令下载
```
singularity pull dpabisurfslurm.sif docker://cgyan/dpabisurfslurm:latest
singularity pull freesurfer.sif docker://cgyan/freesurfer:latest
```
方法2：如果因为网络问题无法pull镜像，可以从备用的[百度网盘共享](https://pan.baidu.com/s/1Glt3gshd8cZNqCAYhts2KQ?pwd=7pwr)下载两个Singularity镜像并存放。
变量`SingularityDIR`即为`DPABISurfSlurm_SingularityFiles`的路径。

### 3.整理数据成BIDS结构
变量`DATADIR`即为整理后BIDS文件夹所在的父级路径。推荐参照仓库中`/demo`的BIDS结构。
#### 方法1：dcm2niix + 自写脚本 （推荐）
建议有编程基础的人使用[dcm2niix](https://github.com/rordenlab/dcm2niix)把经过DICOM Sorter整理后的数据转成NIfTI格式，再自行写脚本把需要的模态图像、头文件和附加信息文件按照[BIDS](https://bids-specification.readthedocs.io/en/stable/modality-specific-files/magnetic-resonance-imaging-data.html)结构的要求进行整理。
（可参考仓库中`/code/S3_nii2bids.m`，推荐参照仓库`/demo`中的BIDS结构和文件内容）

#### 方法2：dcm2bids
使用[dcm2bids](https://github.com/UNFmontreal/Dcm2Bids)工具按照[手册](https://unfmontreal.github.io/Dcm2Bids/3.2.0/tutorial/first-steps/)进行整理。

### 4.编辑被试名称列表
建议使用脚本编辑BIDS结构数据中被试名称的列表`subjects.txt`，放在`DATADIR`下。
（可参考仓库中`/code/S3_nii2bids.m`，推荐参照仓库中Demo的`subjects.txt`）

### 5.编辑运行脚本
从`DPABISurfSlurmDIR`复制`DPABISurf_runSlurm.sh`和`SetEnv.sh`两个文件模板到某个路径，变量`SetEnvScriptDir`即为该路径。

在DPABISurf_runSlurm.sh，填入`DPABISurfSlurmDIR`、 `SetEnvScriptDir` 、`DATADIR` 3个路径。

在`SetEnv.sh`，填入`DATADIR`、`SingularityDIR`、`FreeSurferLicenseDIR`3个路径。并根据具体数据情况修改RemoveFirstTimePoints、FunctionalSessionNumber等参数。

### 6.新建日志文件夹
在`DATADIR`下新建一个`log`文件夹，并用cd命令进入。
```
mkdir ./log
cd ./log
```

### 7.开始任务
使用`source ../DPABISurf_runSlurm.sh`命令提交任务。在运行过程中能使用[squeue](https://www.bkunyun.com/help/docs/cloudE17/)命令检查运行状态。

运行的结果会存储在`${DATADIR}/ResultsOrganized`文件夹下。其压缩包存放在`${DATADIR}/ResultsOrganized.tar.gz`。

------

在运行程序前，`DATADIR`下的文件结构应如下：

```
.
├── BIDS
│   ├── dataset_description.json
│   ├── participants.json
│   ├── participants.tsv
│   ├── README
│   └── sub-001
│       ├── anat
│       │   ├── sub-001_T1w.json
│       │   └── sub-001_T1w.nii
│       └── func
│           ├── sub-001_task-rest_bold.json
│           └── sub-001_task-rest_bold.nii
├── DPABISurf_runSlurm.sh
├── log
├── SetEnv.sh
├── subjects.txt
└── TRInfo.tsv
```

PS1：如果在处理过程中出现被试处理失败的情况，参考文档[RefCommandsForFailedSubjects](https://github.com/Chaogan-Yan/DPABI/blob/master/DPABISurf/DPABISurfSlurm/RefCommandsForFailedSubjects.txt)尝试解决问题。

PS2：根据服务器情况和需求可以修改${DPABISurfSlurmDIR}下文件的参数，以控制资源使用程度。

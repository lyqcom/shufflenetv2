#ifndef MXBASE_SHUFFLENETV2CLASSIFYOPENCV_H
#define MXBASE_SHUFFLENETV2CLASSIFYOPENCV_H
#include <string>
#include <vector>
#include <memory>
#include <opencv2/opencv.hpp>
#include "MxBase/DvppWrapper/DvppWrapper.h"
#include "MxBase/ModelInfer/ModelInferenceProcessor.h"
#include "MxBase/Tensor/TensorContext/TensorContext.h"
#include "ClassPostProcessors/Resnet50PostProcess.h"

struct InitParam {
    uint32_t deviceId;
    std::string labelPath;
    uint32_t classNum;
    uint32_t topk;
    bool softmax;
    bool checkTensor;
    std::string modelPath;
};

class ShuffleNetV2ClassifyOpencv {
 public:
     APP_ERROR Init(const InitParam &initParam);
     APP_ERROR DeInit();
     APP_ERROR ReadImage(const std::string &imgPath, cv::Mat &imageMat);
     APP_ERROR ResizeImage(const cv::Mat &srcImageMat, cv::Mat &dstImageMat);
     APP_ERROR CVMatToTensorBase(const cv::Mat &imageMat, MxBase::TensorBase &tensorBase);
     APP_ERROR Crop(const cv::Mat &srcImageMat, cv::Mat &dstImageMat);
     APP_ERROR Inference(const std::vector<MxBase::TensorBase> &inputs, std::vector<MxBase::TensorBase> &outputs);
     APP_ERROR PostProcess(const std::vector<MxBase::TensorBase> &inputs,
                           std::vector<std::vector<MxBase::ClassInfo>> &clsInfos);
     APP_ERROR Process(const std::string &imgPath);
     // get infer time
     double GetInferCostMilliSec() const {return inferCostTimeMilliSec;}

 private:
     APP_ERROR SaveResult(const std::string &imgPath,
                          const std::vector<std::vector<MxBase::ClassInfo>> &batchClsInfos);

 private:
     std::shared_ptr<MxBase::ModelInferenceProcessor> model_;
     std::shared_ptr<MxBase::Resnet50PostProcess> post_;
     MxBase::ModelDesc modelDesc_;
     uint32_t deviceId_ = 0;
     // infer time
     double inferCostTimeMilliSec = 0.0;
};

#endif

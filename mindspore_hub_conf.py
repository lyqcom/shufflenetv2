"""hub config"""
from src.shufflenetv2 import ShuffleNetV2

def shufflenetv2(*args, **kwargs):
    return ShuffleNetV2(*args, **kwargs)


def create_network(name, *args, **kwargs):
    if name == "shufflenetv2":
        return ShuffleNetV2(*args, **kwargs)
    raise NotImplementedError(f"{name} is not implemented in the repo")

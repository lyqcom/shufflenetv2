"""learning rate exponential decay generator"""
import math
import numpy as np

def get_lr(lr_init, lr_decay_rate, num_epoch_per_decay, total_epochs, steps_per_epoch, is_stair=False):
    """
    generate learning rate array

    Args:
       lr_init(float): init learning rate
       lr_decay_rate (float):
       total_epochs(int): total epoch of training
       steps_per_epoch(int): steps of one epoch
       is_stair(bool): If `True` decay the learning rate at discrete intervals (default=False)

    Returns:
       learning_rate, learning rate numpy array
    """
    lr_each_step = []
    total_steps = steps_per_epoch * total_epochs
    decay_steps = steps_per_epoch * num_epoch_per_decay
    for i in range(total_steps):
        p = i/decay_steps
        if is_stair:
            p = math.floor(p)
        lr_each_step.append(lr_init * math.pow(lr_decay_rate, p))
    learning_rate = np.array(lr_each_step).astype(np.float32)
    return learning_rate

def get_lr_basic(lr_init, total_epochs, steps_per_epoch, is_stair=False):
    """
    generate basic learning rate array

    Args:
       lr_init(float): init learning rate
       total_epochs(int): total epochs of training
       steps_per_epoch(int): steps of one epoch
       is_stair(bool): If `True` decay the learning rate at discrete intervals (default=False)

    Returns:
       learning_rate, learning rate numpy array
    """
    lr_each_step = []
    total_steps = steps_per_epoch * total_epochs
    for i in range(total_steps):
        lr = lr_init - lr_init * (i) / (total_steps)
        lr_each_step.append(lr)
    learning_rate = np.array(lr_each_step).astype(np.float32)
    return learning_rate

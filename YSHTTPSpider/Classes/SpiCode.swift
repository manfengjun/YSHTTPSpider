//
//  NetWorkStatus.swift
//  WTDistributorVersion
//
//  Created by ios on 2018/7/4.
//  Copyright © 2018年 ios. All rights reserved.
//

import UIKit


// Code
let REQUEST_SUCCESS = 0;//请求成功数据正常
let REQUEST_SUCCESS_1002 = 1002;//请求成功数据正常

let REQUEST_SUCCESS_NULL = 100//请求成功数据为空
let REQUEST_SUCCESS_NODATA = 101//请求成功无data字段
let REQUEST_SUCCESS_FORMATERROR = -102//请求成功返回格式错误

let REQUEST_JUST = 0;//请求正常不通过
let REQUEST_ERROR = -1;//请求失败
let VER_TOKEN_ERROR = 4001;//token验证错误
let VER_SIGN_ERROR = 4002;//sign验证错误
let FILE_SIZE_ILLEGAL = 4003;//不合法的文件大小
let REQUESTBODY_JSON_JSON = 4004;//json错误
let CHICK_REQUEST_GET = 4005;//需要get请求
let CHICK_REQUEST_POST = 4006;//需要post请求
let REQUEST_PARAM_LACK = 4007;//缺少参数
let REQUEST_PARAM_TYPE = 4008;//传入的参数类型不正确
let REQUEST_SIZE_ERROR = 4009;//请求参数长度超过限制
let REQUEST_IS_FREQUENTLY = 4010;//频繁请求接口
let USER_ROLE_NOT = 4011;//用户未经授权
let DISTANCE_LOGIN = 4012;//异地登录
let PERFECT_REGIST_INFO = 4013;//完善信息错误

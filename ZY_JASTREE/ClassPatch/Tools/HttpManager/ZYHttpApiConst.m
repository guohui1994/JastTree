//
//  ZYHttpApiConst.m
//  FD_Rider
//
//  Created by 郭军 on 2019/3/19.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import "ZYHttpApiConst.h"


//  注册登录
NSString * const JTUserLogin = @"/user/login";
//  获取手机验证码
NSString * const JTUserGetCode = @"/user/getCode";
//  忘记密码
NSString * const JTUserForgetPassword = @"/user/forgetPassword";
//  修改密码
NSString * const JTUserChangePassword = @"/user/changePassword";
//  QQ微信第一次登录绑定手机号
NSString * const JTUserFirstLogin = @"/user/firstLogin";
//  修改手机号
NSString * const JTUserChangeIphone = @"/user/changePhone";

//订单列表
NSString * const JTOrderSelectUserOrderList = @"/order/selectUserOrderList";
//撤单
NSString * const JTOrderRevokeOrder = @"/order/revokeOrder";
//删除订单
NSString * const JTOrderDeleteUserOrder = @"/order/deleteUserOrder";
//获取阿里云OSS上传凭证
NSString * const JTSTSOSS = @"/sts/oss";

//订单相亲
NSString * const JTOrderDetails = @"/order/orderDetails";
//查询展览列表
NSString * const JTExhibitionSelectList = @"/exhibition/selectList";

//返回省的json
NSString * const JTProvinceData = @"/exhibition/getJson";
//上传物料图
NSString * const JTOrderUploadMateriel = @"/order/uploadMateriel";
//上传搭建图
NSString * const JTOrderConstructUploadDrawing = @"/orderConstruct/uploadDrawing";
//删除物料图
NSString * const JTOrederDeleteMateriel = @"/order/deleteMateriel";
//删除搭建图
NSString * const JTOrderConstructDeleteDrawing = @"/orderConstruct/deleteDrawing";
//申请施工图
NSString * const JTOrderDrawingApply = @"/order/drawingApply";
//提交评价
NSString * const JTOrderSubEvaluate = @"/order/subEvaluate";
//首页详情
NSString * const JTExhibitionSelectExhibitionDetails = @"/exhibition/selectExhibitionDetails";
//提交报价
NSString * const JTOrderQuotedPrice = @"/order/quotedPrice";
//查询消息列表
NSString * const JTMessageSelectList = @"/message/selectList";
//查询消息未读数
NSString * const JTMessageSelectUnread = @"/message/selectUnread";
//消息已读
NSString * const JTMessageRead = @"/message/read";
//系统设置通过名称查询值
NSString * const JTSystemSelectValue = @"/system/selectValue";
//新增轮播图接口
NSString * const JTHomeSlidehowSelectBanner = @"/slidehow/selectBanner";
//首页公告
 NSString * const JTHomeSystemSelectNotice = @"/system/selectNotice";

//退出登录
NSString * const OutLogin = @"/user/loginOut";


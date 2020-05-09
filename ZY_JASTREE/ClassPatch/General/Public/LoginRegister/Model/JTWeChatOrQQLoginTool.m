//
//  JTWeChatOrQQLoginTool.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/11.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTWeChatOrQQLoginTool.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>

//<TencentSessionDelegate>
@interface JTWeChatOrQQLoginTool() <WXApiDelegate,TencentSessionDelegate,QQApiInterfaceDelegate>

@property (nonatomic, strong)TencentOAuth * tencentOAuth;

@property (nonatomic, copy) LoginSuccess IndexSuccess;
@property (nonatomic, copy) LoginFailure IndexFailure;

@end


@implementation JTWeChatOrQQLoginTool

static id _instance;

- (TencentOAuth *)tencentOAuth {
    if (!_tencentOAuth) {
        _tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"101718172" andDelegate:self];
    }
    return _tencentOAuth;
}


+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JTWeChatOrQQLoginTool alloc] init];
    });
    
    return _instance;
}



/**
 QQ登录
 
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
- (void)QQ_LoginSuccess:(LoginSuccess)successBlock
                Failure:(LoginFailure)failBlock {
    
    self.IndexSuccess = successBlock;
    self.IndexFailure = failBlock;
    
    //授权列表数组 根据实际需要添加
    [self.tencentOAuth authorize:@[@"get_user_info",@"get_simple_userinfo"] inSafari:NO];
}

#pragma mark --- QQ  回调
- (void)isOnlineResponse:(NSDictionary *)response {
    
}


- (void)onReq:(QQBaseReq *)req {
    
}


- (void)tencentDidLogin{
    JGLog(@"%@ -- %@",self.tencentOAuth.accessToken, self.tencentOAuth.openId);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"accessToken"] = self.tencentOAuth.accessToken;
    parameters[@"type"] = @(1);
    [self LoginWithParameters:parameters AndType:@"qq"];
}


- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}

- (void)tencentDidNotNetWork {
    
}


/**
 微信登录
 
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
- (void)WX_LoginSuccess:(LoginSuccess)successBlock
               Failure:(LoginFailure)failBlock {
    
    self.IndexSuccess = successBlock;
    self.IndexFailure = failBlock;
    
    
    SendAuthReq *sendAuth = [[SendAuthReq alloc]init];
    if ([WXApi isWXAppInstalled]) {
        sendAuth.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        sendAuth.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        [WXApi sendReq:sendAuth];
    }else{ //未安装微信调起web登录
        
        UIViewController *VC = [JGCommonTools getCurrentActivityViewController];
        [WXApi sendAuthReq:sendAuth viewController:VC delegate:self];
    }
}


#pragma mark --- 微信  回调
-(void) onResp:(BaseResp*)resp{
    /*
     enum  WXErrCode {
     WXSuccess           = 0,    成功
     WXErrCodeCommon     = -1,  普通错误类型
     WXErrCodeUserCancel = -2,    用户点击取消并返回
     WXErrCodeSentFail   = -3,   发送失败
     WXErrCodeAuthDeny   = -4,    授权失败
     WXErrCodeUnsupport  = -5,   微信不支持
     };
     */
    /*f微信分享的授权类*/
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
        NSString * string = [NSString stringWithFormat:@"%d", sendResp.errCode];
        JGLog(@"微信分享的授权类 = %@", string);
    }
    /*微信登录的授权类*/
    if ([resp isKindOfClass:[SendAuthResp class]]) {   //授权登录的类。
        
        if (resp.errCode == 0) {  //成功。
            SendAuthResp *resp2 = (SendAuthResp *)resp;
            JGLog(@"%@", resp2.code);
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"code"] = resp2.code;
            parameters[@"type"] = @(0);
            [self LoginWithParameters:parameters AndType:@"wx"];
            
//            self.IndexSuccess(resp2.code);
            
        }else{ //失败
            JGLog(@"授权失败");
        }
    }
}


- (void)LoginWithParameters:(NSDictionary *)parameters AndType:(NSString *)type{
    
    WEAKSELF;
    [ZYHttpManager LoadingHttpRequestDataWithApi:JTUserLogin Aarameters:parameters httpMthod:POST Success:^(id  _Nonnull data, NSString * _Nonnull message) {
        
        JGLog(@"%@", data);
        //数据模型化
        JTLoginModel *model = [JTLoginModel mj_objectWithKeyValues:data];
        model.type = type;

        weakSelf.IndexSuccess(model);
        
        //切换window跟控制器
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[JTBaseTabBarController alloc] init];
    } failure:^(NSString * _Nonnull message) {
        [JGToast showWithText:message];
    }];
}







/************* 回调入口 *****************/
#pragma mark - 回调入口 -
- (BOOL) handleOpenURL:(NSURL *) url {
    if ([url.scheme isEqualToString:@"tencent101718172"]) {
        return  [TencentOAuth HandleOpenURL:url] || [QQApiInterface handleOpenURL:url delegate:self];
        
    }
    else{
        
        return  [WXApi handleOpenURL:url delegate:self];
    }
}


- (BOOL) sourceApplicationOpenURL:(NSURL *) url {
    if ([url.scheme isEqualToString:@"tencent101718172"]) {
        return  [TencentOAuth HandleOpenURL:url]|| [QQApiInterface handleOpenURL:url delegate:self];
    }
    else{
        return  [WXApi handleOpenURL:url delegate:self] ;
    }
}


- (BOOL) OpenURL:(NSURL *) url {
    if ([url.scheme isEqualToString:@"tencent101718172"]) {
        
        return  [TencentOAuth HandleOpenURL:url]|| [QQApiInterface handleOpenURL:url delegate:self];
    }
    else{
        return  [WXApi handleOpenURL:url delegate:self] ;
    }
    
}





@end

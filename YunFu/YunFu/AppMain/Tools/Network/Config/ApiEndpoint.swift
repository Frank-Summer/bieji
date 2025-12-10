enum ApiEndpoint {
    
    //************************************************** 登陆 ******************************************************/
    //登陆接口
    static let login = "/v1/auth/login-or-register"
    //短信验证码
    static let code = "/v1/auth/send-verification-code"
    //刷新令牌
    static let refreshtoken = "/v1/auth/refresh-token"
    
    
    
    //************************************************** 首页 ******************************************************/
    //获取音频信息
    static let getmusicinfo = "/v1/catalog/getmusicinfo"
    //收藏
    static let favorites = "/v1/me/favorites"
    //取消收藏
    static let qfavorites = "/v1/me/favorites/"
    
    
    
    //************************************************** 反馈接口 ******************************************************/
      //提交反馈
      static let feedback = "/v1/support/submit-feedback"
      //提交反馈图片资源
      static let upload_url = "/v1/support/request-upload-url"

    
    
    //************************************************** 个人信息 ******************************************************/
      //个人信息
      static let profile = "/v1/user/profile"
      //设置密码
      static let set_password = "/v1/user/set-password"
      //注销账号
      static let delete_account = "/v1/user/delete-account"
    
}

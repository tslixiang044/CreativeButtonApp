





//-------------------------
#define BASEURL @"http://223.6.252.147/web"

#define kgetLoginUrl [BASEURL stringByAppendingString:@"/web/mobile/api/login"]//登录
#define kgetWaterFlowUrl @"http://api.izhuzhou.com.cn/GetPicNews.ashx?m=img&page=1&num=10"//瀑布流 测试url





//-------------------------




#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define IS_iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define kMainScreenBoundheight [UIScreen mainScreen].bounds.size.height
#define kMainScreenBoundwidth [UIScreen mainScreen].bounds.size.width
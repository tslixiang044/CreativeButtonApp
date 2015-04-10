





//-------------------------
#define BASEURL @"http://121.41.123.182:8091/web"

#define kgetLoginUrl [BASEURL stringByAppendingString:@"/web/mobile/api/login"]//登录
#define kgetWaterFlowUrl [BASEURL stringByAppendingString:@"/mobile/api/idea/friendsIdeas?range="]//瀑布流 测试url
#define kgetWaterFlowUrl_suggesion [BASEURL stringByAppendingString:@"/mobile/api/suggestion/list?suggestionId=&pageSize=10&pageNo="]//瀑布流 测试url






//-------------------------

#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kGetNavbarColor [UIColor colorWithRed:47/255.0 green:44/255.0 blue:43/255.0 alpha:1]

#define kgettitle @"BUTTON 4 CREATIVE"

#define IS_iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define kMainScreenBoundheight [UIScreen mainScreen].bounds.size.height
#define kMainScreenBoundwidth [UIScreen mainScreen].bounds.size.width
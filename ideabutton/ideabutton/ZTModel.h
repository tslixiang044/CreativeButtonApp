//
//  model.h
//  zt906
//
//  Created by Jian Hu on 13-10-21.
//  Copyright (c) 2013年 zt906. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ModelType {UserType, MemberType, NoticeType, OrderType, CartItemType, VendorType, ResourceType, FetcherType, ReceiverType,MessageType,InfoType};
enum VendorAffinity {VendorNormal, VendorRecommend, VendorTraded};

@protocol ZTModel <NSObject>

@optional

- (NSString*)dbKey;
- (id<ZTModel>)initWithDict:(NSDictionary*)dict;
- (NSDictionary*)asDictionary;

@end

//@interface Resource : NSObject <ZTModel>
//
//@property (nonatomic, strong) NSString *ID;
//@property(nonatomic,strong) NSString* resCode;
//@property (nonatomic, strong) NSString *vID;
//@property (nonatomic, strong) NSString *kind;
//@property (nonatomic, strong) NSString *material;
//@property (nonatomic, strong) NSString *spec;
//@property (nonatomic, assign) float specVal;
//@property (nonatomic, assign) NSInteger resClass;
//@property (nonatomic, strong) NSString *factory;
//@property (nonatomic, strong) NSString *wareHouse;
//@property (nonatomic, strong) NSString *warehouseDisplayName;
//@property (nonatomic, strong) NSString *wareHouseID;
//@property (nonatomic, strong) NSString *remark;
//@property (nonatomic, assign) double price;
//@property (nonatomic, assign) double perWeight;
//@property (nonatomic, assign) NSInteger pubType;
//@property (nonatomic, strong) NSString *measureType;
//@property (nonatomic, assign) NSInteger totalCount;
//@property (nonatomic, assign) float totalWeight;
//@property (nonatomic, assign) NSInteger resType;
//@property (nonatomic, strong) NSString *deliverDate;
//@property (nonatomic, assign) BOOL hidePrice;
//@property (nonatomic, assign) NSInteger tradeOpen;
//@property (nonatomic, assign) BOOL marketOpen;
//@property (nonatomic, strong) NSString *textPrice;
//@property (nonatomic, assign) NSInteger status;
//@property (nonatomic, strong) NSString *city;
//@property (nonatomic, strong) NSString *areaSetId;
//@property (nonatomic, strong) NSString *areaId;
//@property (nonatomic, strong) NSString *priceType;
//@property (nonatomic, assign) NSInteger priceViewFlag;
//@property (nonatomic, strong) NSString *resTypeClass;
//@property (nonatomic, strong) NSString *areaPriceID;
//@property (nonatomic, assign) NSInteger intPrice;
//@property (nonatomic, assign) NSInteger intPerWeight;
//@property (nonatomic, assign) BOOL  isNew;
//@property (nonatomic, assign) BOOL  isPresell;
//@property (nonatomic, assign) BOOL  isPromotion;
//@property (nonatomic, strong) NSString * ownerName;
//@end

@interface User : NSObject <ZTModel>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) NSInteger userStatus;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, assign) BOOL isVip;
@property (nonatomic, assign) BOOL rememberPSW;

@end

//@interface MessageConfig : NSObject <ZTModel>
//
//@property (nonatomic, assign) BOOL IsReceive;
//@property (nonatomic, strong) NSString * messageID;
//@property (nonatomic, strong) NSArray * mobileLinkList;
//@property (nonatomic, assign) BOOL IsEnabled;
//@property (nonatomic, strong) NSString * linkName;
//@property (nonatomic, strong) NSString * messageLinkID;
//@property (nonatomic, strong) NSString * noteID;
//
//@end
//
//@interface Member : NSObject <ZTModel>
//
///*@property(nonatomic,strong)NSString *ID;
//@property(nonatomic,strong)NSString *name;
//@property(nonatomic,strong)NSString *addr;*/
//@property(nonatomic,strong)NSArray *receivers;
//@property(nonatomic,strong)NSArray *fetchers;
//
//@end
//
//@interface Notice : NSObject <ZTModel>
//
//@property(nonatomic,strong)NSString *ID;
//@property(nonatomic,strong)NSString *title;
//@property(nonatomic,strong)NSString *cTime;
//@property(nonatomic,strong)NSString *content;
//@property(nonatomic,assign)BOOL read;
//
//@end
//
//@interface Order : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSString* ID;
//@property(nonatomic,strong) NSString* orderNum;
//@property(nonatomic,strong) NSString* status;
//@property(nonatomic,strong) NSString* statusID;
//@property(nonatomic,strong) NSString* cTime;
//@property(nonatomic,strong) NSString* tPrice;
//@property(nonatomic,strong) NSString* tWeight;
//@property(nonatomic,strong) NSString* type;
//@property(nonatomic,strong) NSString* paymentType;
//@property(nonatomic,strong) NSString* source;
//@property(nonatomic,strong) NSString* vendor;
//@property(nonatomic,strong) NSDictionary *salesman;
//@property(nonatomic,strong) NSArray* resList;
//@property(nonatomic,strong) NSString* bMemo;
//@property(nonatomic,strong) NSString* vMemo;
//@property(nonatomic,strong) NSString* client;
//@property(nonatomic,strong) NSDictionary* creator;
//@property(nonatomic,strong) NSString* deleveryType;
//@property(nonatomic,strong) NSDictionary* fetcher;
//@property(nonatomic,strong) NSDictionary* receiver;
//@property(nonatomic,strong) NSString* promiseDate;
//@property(nonatomic,strong) NSString* fetchEndDate;
//@property(nonatomic,strong) NSString *deliverDate;
//@property(nonatomic,strong) NSString *balanceType;
//@property(nonatomic,strong) NSString *balanceTypeDesc;
//@property(nonatomic,strong) NSString *balanceTypeText;
//@property(nonatomic,strong) NSString *confirmFlag;
//
//@end
//
//@interface CartItem : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSString* ID;
//@property(nonatomic,strong) Resource* res;
//@property(nonatomic,strong) NSString* price;
//@property(nonatomic,strong) NSString* count;
//@property(nonatomic,strong) NSString* weight;
//@property(nonatomic,strong) NSString* vID;
//@property(nonatomic,strong) NSString* vendorName;
//@property(nonatomic,assign) NSInteger intWeight;
//
//- (CartItem*)initWithItemDict:(NSDictionary*)itemDict headerDict:(NSDictionary*)headerDict;
//
//@end
//
//@interface Vendor : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSString* ID;
//@property(nonatomic,strong) NSString* name;
//@property(nonatomic,strong) NSString* fullName;
//@property(nonatomic,strong) NSString* province;
//@property(nonatomic,strong) NSString* city;
//@property(nonatomic,strong) NSString* addr;
//@property(nonatomic,strong) NSString* compTel;
//@property(nonatomic,strong) NSString* bank;
//@property(nonatomic,strong) NSString* bankOpenningName;
//@property(nonatomic,strong) NSString* openingBank;
//@property(nonatomic,strong) NSString* bankAccount;
//@property(nonatomic,strong) NSArray* sales;
//@property(nonatomic,strong) NSArray* materials;
//@property(nonatomic,strong) NSArray* kindsArr;
//@property(nonatomic,strong) NSArray* factory;
//@property(nonatomic,strong) NSArray* wareHouse;
//@property(nonatomic,strong) NSArray* areas;
//@property(nonatomic,strong) NSArray* priceTypes;
//@property(nonatomic,assign) BOOL isAgencyShow;
//
//@property(nonatomic,assign) enum VendorAffinity affinity;
//
//@end
//
//@interface Fetcher : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSString* ID;
//@property(nonatomic,strong) NSString* carNum;
//@property(nonatomic,strong) NSString* name;
//@property(nonatomic,strong) NSString* tel;
//@property(nonatomic,strong) NSString* idCard;
//
//@end
//
//@interface Receiver : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSString* ID;
//@property(nonatomic,strong) NSString* areaID;
//@property(nonatomic,strong) NSString* province;
//@property(nonatomic,strong) NSString* city;
//@property(nonatomic,strong) NSString* recOrg;
//@property(nonatomic,strong) NSString* addr;
//@property(nonatomic,strong) NSString* name1;
//@property(nonatomic,strong) NSString* name2;
//@property(nonatomic,strong) NSString* idCard1;
//@property(nonatomic,strong) NSString* idCard2;
//@property(nonatomic,strong) NSString* tel1;
//@property(nonatomic,strong) NSString* tel2;
//
//@end
//
//@interface Factory : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSString* ID;
//@property(nonatomic,strong) NSString* subVendorID;
//@property(nonatomic,strong) NSString* name;
//@property(nonatomic,strong) NSString* fullName;
//@property(nonatomic,strong) NSString* province;
//@property(nonatomic,strong) NSString* city;
//@property(nonatomic,strong) NSString* tel;
//@property(nonatomic,strong) NSString* logoUrl;
//
//@end
//
//@interface Contract : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSString* ID;
//@property(nonatomic,strong) NSString* number;
//@property(nonatomic,strong) NSString* status;
//@property(nonatomic,assign) NSInteger statusID;
//@property(nonatomic,strong) NSString* client;
//@property(nonatomic,strong) NSString* vendorName;
//@property(nonatomic,strong) NSString* price;
//@property(nonatomic,strong) NSString* count;
//@property(nonatomic,strong) NSString* weight;
//@property(nonatomic,strong) NSString* cTime;
//@property(nonatomic,strong) NSString* orderID;
//@property(nonatomic,strong) NSString* salesName;
//@property(nonatomic,strong) NSString* salesPhone;
//
//@end
//
//@interface Message : NSObject<ZTModel>
//
//@property(nonatomic,assign) NSInteger busiType;
//@property(nonatomic,strong) NSString *content;
//@property(nonatomic,strong) NSString *ID;
//@property(nonatomic,assign)BOOL isRead;
//@property(nonatomic,strong) NSString *pushDate;
//@property(nonatomic,strong) NSString *pushDateTime;
//@property(nonatomic,strong) NSString *pushTime;
//@property(nonatomic,strong) NSString *remark;
//@property(nonatomic,strong) NSString *title;
//
//@end
//
//@interface LadingBill : NSObject<ZTModel>
//
//@property(nonatomic, strong) NSString*  buyerName;
//@property(nonatomic, strong) NSString*   createdDateTime;
//@property(nonatomic, strong) NSString*  delPhone;
//@property(nonatomic, assign) BOOL   electronicFlag;
//@property(nonatomic, assign) BOOL   freeze;
//@property(nonatomic, strong) NSString*  ladingCode;
//@property(nonatomic, strong) NSString*  ladingComment;
//@property(nonatomic, strong) NSArray*   ladingDetailList;
//@property(nonatomic, strong) NSString*  ladingStatusName;
//@property(nonatomic, strong) NSString*  ladingStatus;
//@property(nonatomic, strong) NSString*  ladingEffectiveDate;
//@property(nonatomic, strong) NSString*  ladingId;
//@property(nonatomic, strong) NSString*  mondey;
//@property(nonatomic, strong) NSString*  orderBusiId;
//@property(nonatomic, assign) BOOL   orderFlag;
//@property(nonatomic, strong) NSString*  orderId;
//@property(nonatomic, assign) BOOL   outWareHouseFlag;
//@property(nonatomic, strong) NSString*   pickEndTime;
//@property(nonatomic, strong) NSString*  picker;
//@property(nonatomic, strong) NSString*  pickerIdcard;
//@property(nonatomic, strong) NSString*  quantity;
//@property(nonatomic, strong) NSString*  sellerName;
//@property(nonatomic, assign) BOOL   trafficFlag;
//@property(nonatomic, strong) NSString*  truckCode;
//@property(nonatomic, strong) NSString*  verifyType;
//@property(nonatomic, strong) NSString*  warehouse;
//@property(nonatomic, assign) float  weight;
//@property(nonatomic, strong) NSString*  sellerMemberID;
//@property(nonatomic, strong) NSString*  wareHouseID;
//@property(nonatomic, assign) BOOL   IsSetPick;
//@property(nonatomic, strong) NSString*  salesman;
//@property(nonatomic, strong) NSString*  realMondey;
//@property(nonatomic, assign) NSInteger  realQuantity;
//@property(nonatomic, assign) float  realWeight;
//
//@end
//
//@interface LadingSetting : NSObject<ZTModel>
//
//@property(nonatomic, strong) NSString*  affSysMemberID;
//@property(nonatomic, strong) NSString*  createdDateTimeView;
//@property(nonatomic, strong) NSString*  creatorID;
//@property(nonatomic, strong) NSString*  ID;
//@property(nonatomic, strong) NSString*  interfaceArray;
//@property(nonatomic, strong) NSString*  lastModifiedDateTimeStr;
//@property(nonatomic, strong) NSString*  lastModifiedDateTimeView;
//@property(nonatomic, strong) NSString*  lastModifierID;
//@property(nonatomic, strong) NSString*  memberID;
//@property(nonatomic, strong) NSString*  remark;
//@property(nonatomic, strong) NSString*  repoID;
//@property(nonatomic, strong) NSString*  status;
//@property(nonatomic, strong) NSString*  wareHouseID;
//@property(nonatomic, strong) NSString*  sellerMemberID;
//@property(nonatomic, assign) BOOL  typeCarNo;
//@property(nonatomic, assign) BOOL  typeCard;
//@property(nonatomic, assign) BOOL  typeIden;
//@property(nonatomic, assign) BOOL  saveFalg;
//@property(nonatomic, assign) BOOL  typeLet;
//@property(nonatomic, assign) BOOL  typeLic;
//
//@end
//
//@interface Lading : NSObject<ZTModel>
//
//@property(nonatomic,strong) NSString *ID;
//@property(nonatomic,strong) NSString *buyerName;
//@property(nonatomic,strong) NSString *createdDatetime;
//@property(nonatomic,strong) NSString *delPhone;
//@property(nonatomic,assign) NSInteger electronicFlag;
//@property(nonatomic,assign) NSInteger freeze;
//@property(nonatomic,assign) NSInteger isSetPick;
//@property(nonatomic,strong) NSString *ladingCode;
//@property(nonatomic,strong) NSString *ladingComment;
//@property(nonatomic,strong) NSString *ladingEffectiveDate;
//@property(nonatomic,strong) NSString *ladingId;
//@property(nonatomic,assign) NSInteger ladingStatus;
//@property(nonatomic,strong) NSString *ladingStatusName;
//@property(nonatomic,strong) NSString *mondey;
//@property(nonatomic,strong) NSString *orderBusiId;
//@property(nonatomic,assign) NSInteger orderFlag;
//@property(nonatomic,strong) NSString *orderId;
//@property(nonatomic,assign) NSInteger outWarehouseFlag;
//@property(nonatomic,strong) NSString *pickEndTime;
//@property(nonatomic,strong) NSString *picker;
//@property(nonatomic,strong) NSString *pickerIdcard;
//@property(nonatomic,strong) NSString *quantity;
//@property(nonatomic,strong) NSString *sellerMemberId;
//@property(nonatomic,strong) NSString *sellerName;
//@property(nonatomic,assign) NSInteger trafficFlag;
//@property(nonatomic,strong) NSString *truckCode;
//@property(nonatomic,assign) NSInteger verifyType;
//@property(nonatomic,strong) NSString *warehouse;
//@property(nonatomic,strong) NSString *warehouseId;
//@property(nonatomic,strong) NSString *weight;
//
//@end
//
//@interface Info : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSArray* kindsArr;
//@property(nonatomic,strong) NSArray* factory;
//@property(nonatomic,strong) NSArray* areas;
//
//@end
//
//
////---------------------
//
//@interface UpProgramListObj : NSObject <ZTModel>
//
//@property(nonatomic,strong) NSString *buyerId;
//@property(nonatomic,strong) NSString *buyerName;
//@property(nonatomic,assign) NSInteger cancelPeopleId;//
//@property(nonatomic,assign) NSInteger contractId;//
//@property(nonatomic,strong) NSString *contractNo;
//@property(nonatomic,strong) NSString *fileId;
//@property(nonatomic,strong) NSString *fileName;
//@property(nonatomic,strong) NSString *fileStatus;
//@property(nonatomic,strong) NSString *planFileId;
//@property(nonatomic,strong) NSString *planId;
//@property(nonatomic,strong) NSString *planNo;
//@property(nonatomic,strong) NSString *planType;
//@property(nonatomic,assign) NSInteger sellerId;//
//@property(nonatomic,assign) NSInteger uploadPeopleId;//
//@property(nonatomic,strong) NSString *uploadPeopleName;
//@property(nonatomic,assign) NSInteger uploadTime;//
//
//@property(nonatomic,strong) NSString *planStatus;
//@property(nonatomic,strong) NSString *sumWeight;
//@property(nonatomic,strong) NSString *sellerName;
//@property(nonatomic,strong) NSString *salesman;
//
//@property(nonatomic,strong) NSString *purchaseStartTimeFmt;
//@property(nonatomic,strong) NSString *purchaseEndTimeFmt;
//
//@property(nonatomic,strong) NSString *downLoadPath;
//@property(nonatomic,strong) NSString *filesizeFmt;
//
//@property(nonatomic,strong) NSString *uploadTimeDesc;
//
//
//@property(nonatomic,strong) NSString *planComment;
//@property(nonatomic,strong) NSString *sellerComment;
//
//@property(nonatomic,strong) NSString *createdDatetimeFmt;
//
//@property(nonatomic,strong) NSString *creatorName;
//@end
////---------------------
//@interface SupplyContractObj : NSObject<ZTModel>
//
//
//
//@property(nonatomic,strong) NSString *additionalNum;
//@property(nonatomic,strong) NSString *billType;
//@property(nonatomic,strong) NSString *buyerId;
//@property(nonatomic,strong) NSString *contractExpireBegintime;
//@property(nonatomic,strong) NSString *contractExpireEndtime;
//@property(nonatomic,strong) NSString *contractNo;
//@property(nonatomic,strong) NSString *contractStatus;
//@property(nonatomic,strong) NSString *createdDatetime;
//@property(nonatomic,strong) NSString *deliveryQuantity;
//@property(nonatomic,strong) NSString *deliveryWeight;
//@property(nonatomic,strong) NSString *terminalContractId;//id
//@property(nonatomic,strong) NSString *ladingQuantity;
//@property(nonatomic,strong) NSString *ladingWeight;
//@property(nonatomic,strong) NSString *orderNum;
//@property(nonatomic,strong) NSString *planNum;
//@property(nonatomic,strong) NSString *projectName;
//@property(nonatomic,strong) NSString *sellerId;
//@property(nonatomic,strong) NSString *supplyId;
//@property(nonatomic,strong) NSString *totalMoney;
//@property(nonatomic,strong) NSString *totalPlanWeight;
//@property(nonatomic,strong) NSString *transportFee;
//@property(nonatomic,strong) NSString *weight;
//
//
//@end
////---------------------
//@interface BatchPlaneObj : NSObject<ZTModel>
//
//
//@property(nonatomic,strong) NSString *buyerId;
//@property(nonatomic,strong) NSString *buyerName;
//@property(nonatomic,strong) NSString *contractId;
//@property(nonatomic,strong) NSString *contractNo;
//@property(nonatomic,strong) NSString *createdDatetime;
//@property(nonatomic,strong) NSString *createdDatetimeDesc;
//@property(nonatomic,strong) NSString *creatorMemberId;
//@property(nonatomic,strong) NSString *creatorName;
//@property(nonatomic,strong) NSString *dateStyle;
//@property(nonatomic,strong) NSString *deliveryNum;
//
//@property(nonatomic,strong) NSString *deliveryQuality;
//@property(nonatomic,strong) NSString *deliveryQuantity;
//@property(nonatomic,strong) NSString *deliveryWeight;
//@property(nonatomic,strong) NSString *excuteQuantity;
//@property(nonatomic,strong) NSString *excuteWeight;
//@property(nonatomic,strong) NSString *terminalPlanId;//代替 id
//@property(nonatomic,strong) NSString *lastModifierName;
//@property(nonatomic,strong) NSString *orderNum;
//@property(nonatomic,strong) NSString *planComment;
//@property(nonatomic,strong) NSString *planNo;
//
//@property(nonatomic,strong) NSString *planStatus;
//@property(nonatomic,strong) NSString *planStatusDesc;
//@property(nonatomic,strong) NSString *planType;
//@property(nonatomic,strong) NSString *projectName;
//@property(nonatomic,strong) NSString *purchaseEndTime;
//@property(nonatomic,strong) NSString *purchaseEndTimeDesc;
//@property(nonatomic,strong) NSString *purchaseStartTime;
//@property(nonatomic,strong) NSString *purchaseStartTimeDesc;
//@property(nonatomic,strong) NSString *refMonthPlan;
//@property(nonatomic,strong) NSString *refMonthPlanNo;
//
//@property(nonatomic,strong) NSString *sellerId;
//@property(nonatomic,strong) NSString *sellerName;
//@property(nonatomic,strong) NSString *submitPlanType;
//@property(nonatomic,strong) NSString *sumWeight;
//@property(nonatomic,strong) NSString *totalBuyQuantity;
//@property(nonatomic,strong) NSString *totalBuyWeight;
//@property(nonatomic,strong) NSString *weight;
//
//
//@end
////---------------------
//
//@interface PlanDetailObj : NSObject<ZTModel>
//
//
//@property(nonatomic,strong) NSString *purchaseName;
//@property(nonatomic,strong) NSString *purchaseManager;
//@property(nonatomic,strong) NSString *projectName;
//@property(nonatomic,strong) NSString *terminalPlanInfo;
//
//
//
//@end
//
////---------------------
//@interface terminalPlanResObj : NSObject<ZTModel>
//
//
//
//@property(nonatomic,strong) NSString *addressStr;
//@property(nonatomic,strong) NSString *brandId;
//@property(nonatomic,strong) NSString *brandName;
//@property(nonatomic,strong) NSString *buyQuantity;
//@property(nonatomic,strong) NSString *buyWeight;
//@property(nonatomic,strong) NSString *ID;
//@property(nonatomic,strong) NSString *listingQuantitySum;
//@property(nonatomic,strong) NSString *listingWeightSum;
//@property(nonatomic,strong) NSString *planId;
//@property(nonatomic,strong) NSString *projectId;
//
//@property(nonatomic,strong) NSString *reallyWeight;
//@property(nonatomic,strong) NSString *receiverAdd;
//@property(nonatomic,strong) NSString *resType;
//@property(nonatomic,strong) NSString *reveiverInfoId;
//@property(nonatomic,strong) NSString *specification;
//@property(nonatomic,strong) NSString *specifictionId;
//@property(nonatomic,strong) NSString *steelPlace;
//@property(nonatomic,strong) NSString *steelPlaceId;
//@property(nonatomic,strong) NSString *texture;
//@property(nonatomic,strong) NSString *textureId;
//
//@property(nonatomic,strong) NSString *weight;
//@property(nonatomic,strong) NSString *comment;
//
//
//@property(nonatomic,strong) NSString *transportDatetimeFmt;
//
//
//
//@end
//
////---------
//@interface TerminalReceiverInfo : NSObject<ZTModel>
//
//@property(nonatomic,strong) NSString *contractId;
//@property(nonatomic,strong) NSString *ID;
//@property(nonatomic,strong) NSString *idCard;
//@property(nonatomic,strong) NSString *mobilePhone;
//@property(nonatomic,strong) NSString *projectId;
//@property(nonatomic,strong) NSString *receiveName;
//@property(nonatomic,strong) NSString *receiverAdd;
//@property(nonatomic,strong) NSString *useStatus;
//@property(nonatomic,strong) NSString *deliveryUnit;
//
//@end













//
//  Constants.h
//  Egive
//
//  Created by Tree Yip on 26/10/15.
//  Copyright © 2015 sino. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//#define PRODUCTION_ENV @"PRODUCTION_ENV";
#ifdef PRODUCTION_ENV
    #define faceBookAndWeiboLogin @"0"
    #define SITE_URL @"http://www.egive4u.org"
    #define Weibo_APP_ID @"1177199632"
    #define Weibo_redirectURI @"http://www.egive4u.org/"
    #define Facebook_URL_SCHEMA @"fb1526757704220992"
    #define Arns @"arn:aws:sns:us-east-1:819247114127:app/APNS/EGive_APNS_PROD_NEW"
#else
    #define faceBookAndWeiboLogin @"0"
    #define SITE_URL @"http://www.egiveforyou.com"
    #define Weibo_APP_ID @"1177199632"
    #define Weibo_redirectURI @"http://www.egive4u.org/"
    #define Facebook_URL_SCHEMA @"fb1526757704220992"
    #define Arns @"arn:aws:sns:us-east-1:819247114127:app/APNS_SANDBOX/EGive_SANDBOX_UAT_NEW"
#endif

//****************************************MyLog*****************************************

#ifdef DEBUG

#define MyLog(...) NSLog(__VA_ARGS__)

#else

#define MyLog(...)

#endif


#endif /* Constants_h */

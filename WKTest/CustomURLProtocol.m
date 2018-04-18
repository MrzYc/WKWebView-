//
//  CustomURLProtocol.m
//  WKTest
//
//  Created by 赵永闯 on 2018/4/18.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "CustomURLProtocol.h"

@implementation CustomURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([request.URL.scheme caseInsensitiveCompare:@"myapp"] == NSOrderedSame) {
        return YES;
    }
    return NO;
    
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[self.request URL] MIMEType:@"image/png" expectedContentLength:-1 textEncodingName:nil];
    NSString *imagePath = [self.request.URL.absoluteString componentsSeparatedByString:@"myapp://"].lastObject;
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [[self client]  URLProtocol:self didLoadData:data];
    [[self client] URLProtocolDidFinishLoading:self];
}


- (void)stopLoading {
    
}



@end

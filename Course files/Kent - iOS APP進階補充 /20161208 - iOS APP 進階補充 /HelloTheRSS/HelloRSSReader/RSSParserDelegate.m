//
//  RSSParserDelegate.m
//  HelloRSSReader
//
//  Created by Kent Liu on 2016/3/9.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "RSSParserDelegate.h"


@interface RSSParserDelegate ()
{
    NewsItem *currentNewsItem;
    NSMutableString *currentElementValue;
    
    NSMutableArray *resultsArray;
}

@end


@implementation RSSParserDelegate

- (instancetype) init {
    
    self = [super init];
    resultsArray = [NSMutableArray new];
    return self;
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if([elementName isEqualToString:@"item"]) {
        
        currentNewsItem = [NewsItem new];
        
    } else if([elementName isEqualToString:@"title"]) {
        
        currentElementValue = nil;
        
    } else if([elementName isEqualToString:@"link"]) {
        
        currentElementValue = nil;
        
    } else if([elementName isEqualToString:@"pubDate"]) {
        
        currentElementValue = nil;
        
    }

}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"item"]) {
        
        [resultsArray addObject:currentNewsItem];
        currentNewsItem = nil;
        
    } else if([elementName isEqualToString:@"title"]) {
        
        currentNewsItem.title = currentElementValue;
        
    } else if([elementName isEqualToString:@"link"]) {
        
        currentNewsItem.link = currentElementValue;
        
    } else if([elementName isEqualToString:@"pubDate"]) {
        
        currentNewsItem.pubDate = currentElementValue;
        
    }
    currentElementValue = nil;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(currentElementValue == nil) {
        
        currentElementValue = [[NSMutableString alloc] initWithString:string];
        
    } else {
        
        [currentElementValue appendString:string];
        
    }
    
    
}


- (NSArray*) getResults {
    
    return resultsArray;
    
}

@end






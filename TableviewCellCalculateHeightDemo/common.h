#import "UIColor+Additions.h"
#import "UILabel+Common.h"
#import "NSString+Common.h"
#import "UIView+FrameCategory.h"
#import <FMDB.h>

#define kDeviceWidth [[UIScreen mainScreen] bounds].size.width
#define kDeviceHeight [[UIScreen mainScreen] bounds].size.height
#define ListCellLeftMargin 15
#define ListCellVerticalMargin   15
#define ListCellMargin 8
#define kCommentCell_CotentWidth (kDeviceWidth - ListCellLeftMargin*2)
#define LikeDataBasePath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"like.db"]

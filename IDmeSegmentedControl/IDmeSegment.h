//
//  IDmeSegment.h
//  IDmeSegmentedControl
//
//  Created by Arthur Sabintsev on 7/2/14.
//  Copyright (c) 2014 Arthur Ariel Sabintsev. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * The curvature radius of IDmeSegmentedControl's view layer.
 */
FOUNDATION_EXPORT NSString * const kIDmeSegmentCornerRadius;

/*!
 * The font for the title of each segment
 */
FOUNDATION_EXPORT NSString * const kIDmeSegmentFont;

/*!
 * The font for the numeric results of each segment
 */
FOUNDATION_EXPORT NSString * const kIDmeSegmentResultsFont;

/*!
 * An enum to delineate if a segment is the left-most, right-most, or a sandwiched element.
 */
typedef NS_ENUM(NSUInteger, SegmentType)
{
    SegmentTypeLeft,
    SegmentTypeMiddle,
    SegmentTypeRight
};

@protocol IDmeSegmentDelegate;

@interface IDmeSegment : UIButton

/*!
 * The label that displays a number that delineates the number of resutls returned for a given segment.
 */
@property (nonatomic, strong) UILabel *infoLabel;

/*!
 * An instance of UIActivityIndicatorView that is used to animate while data is being fetched for a specific segment.
 */
@property (nonatomic, strong) UIActivityIndicatorView *infoActivity;

/*!
 * 
 */
@property (nonatomic, weak) id <NSObject, IDmeSegmentDelegate> delegate;

/*!
 */
- (instancetype)initWithFrame:(CGRect)frame
                  segmentType:(SegmentType)segmentType
                   appearance:(NSDictionary *)appearance
                     andTitle:(NSString *)title;

/*!
 *  Determines if the segment should or shouldn't be selected.
 *
 * @param selected A boolean value that does/doesn't set the selected state of the segment.
 */
- (void)selectSegment:(BOOL)selected;

@end

/*!
 * A protocol used to pass messages when a specific segment's state changes.
 */
@protocol IDmeSegmentDelegate <NSObject>

/*!
 * A delegate method that is notified when a specific segment changes its selected state.
 *
 * @return idx The index of the segment that is returned.
 */
- (void)segmentSelectedStateDidChange:(IDmeSegment *)selectedSegment;
@end


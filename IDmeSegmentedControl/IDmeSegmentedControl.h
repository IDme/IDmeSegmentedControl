//
//  IDmeSegmentedControl.h
//  IDmeSegmentedControl
//
//  Created by Arthur Sabintsev on 7/1/14.
//  Copyright (c) 2014 Arthur Ariel Sabintsev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDmeSegment.h"

/*!
 * The active color for IDmeSegmentedControl. Also used to delineate which segment is selected.
 */
FOUNDATION_EXPORT NSString * const kIDmeSegmentedControlActiveColor;

/*!
 * The passive color for IDmeSegmentedControl. Also used to delineate which segment are no selected.
 */
FOUNDATION_EXPORT NSString * const kIDmeSegmentedControlPassiveColor;

/*!
 * The curvature radius of IDmeSegmentedControl's view layer.
 */
FOUNDATION_EXPORT NSString * const kIDmeSegmentedControlCornerRadius;

/*!
 * A protocol used to pass messages when an interaction occurs with a specific segments.
 *
 * @return idx The index of the segment that is returned.
 */
@protocol IDmeSegmentedControlDelegate <NSObject>

/*!
 * A delegate method that is notified when a specific segment is selected. The segments are references from the @c segments instance variable.
 *
 * @return idx The index of the segment that is returned.
 */
- (void)didSelectSegmentAtIndex:(NSUInteger)idx;
@end

@interface IDmeSegmentedControl : UIControl <IDmeSegmentDelegate>

/*!
 * An array that holds a reference to all of the segments that are currentl visible.
 */
@property (nonatomic, strong) NSMutableArray *segments;

/*!
 * The designated IDmeSegmentedControlDelegate delegate object. Used to call the @c didSelectSegmentAtIndex :method
 */
@property (nonatomic, weak) id <NSObject, IDmeSegmentedControlDelegate> delegate;

/*!
 * The designated initializer
 *
 * @param frame The rectangle for the view.
 * @param appearance The UI attributes for the segments
 * @param titles The names that will be displated in the @c UILabel for each segment
 */
- (instancetype)initWithFrame:(CGRect)frame appearance:(NSDictionary *)appearance andTitles:(NSArray *)titles NS_DESIGNATED_INITIALIZER;

/*!
 * Begins animating a specific segment. The segment is referenced from within the @c segments instance variable using the @c idx variable.
 *
 * @param idx The index of the segment that should animate.
 */
- (void)startAnimatingSegmentAtIndex:(NSUInteger)idx;

/*!
 * Stops animating a specific segment. The segment is referenced from within the @c segments instance variable using the @c idx variable.
 *
 * @param idx The index of the segment that should animate.
 * @param number The number to show inside the segment after animation has stopped.
 */
- (void)stopAnimatingSegmentAtIndex:(NSUInteger)idx withNumber:(NSInteger)number;

/*!
 * Begins animating all segments that are found in the @c segments instance variables.
 */
- (void)startAnimatingAllSegments;

/*!
 * Stops animating all segments that are found in the @c segments instance variables.
 *
 * @return numbers Populates all segments in the @c segments array with a number found in the same index in the @c numbers array.
 */
- (void)stopAnimatingAllSegmentsWithArrayOfNumbers:(NSArray *)numbers;

@end

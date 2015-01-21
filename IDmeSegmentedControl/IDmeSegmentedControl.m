//
//  IDmeSegmentedControl.m
//  IDmeSegmentedControl
//
//  Created by Arthur Sabintsev on 7/1/14.
//  Copyright (c) 2014 Arthur Ariel Sabintsev. All rights reserved.
//

#import "IDmeSegmentedControl.h"
#import "IDmeSegment.h"

NSString * const kIDmeSegmentedControlActiveColor                = @"segmentedControlActiveColor";
NSString * const kIDmeSegmentedControlPassiveColor               = @"segmentedControlPassiveColor";
NSString * const kIDmeSegmentedControlCornerRadius               = @"segmentedControlCornerRadius";

@interface IDmeSegmentedControl () <IDmeSegmentDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSDictionary *appearance;

@end

@implementation IDmeSegmentedControl

#pragma mark - Initalize
- (instancetype)initWithFrame:(CGRect)frame
                   appearance:(NSDictionary *)appearance
                    andTitles:(NSArray *)titles

{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupAppearance:appearance andTitles:titles];
    }
    
    return self;
}

#pragma mark - Setup
- (void)setupAppearance:(NSDictionary *)appearance andTitles:(NSArray *)titles
{
    _titles = titles;
    _appearance = appearance;
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[appearance[kIDmeSegmentedControlActiveColor] CGColor]];
    [self.layer setCornerRadius:[appearance[kIDmeSegmentedControlCornerRadius] floatValue]];
    [self.layer setMasksToBounds:YES];
    [self drawSegments];
}

#pragma mark - Drawing
- (void)drawSegments
{
    _segments = [@[] mutableCopy];

    // Force assertion if no _titles exist.
    NSAssert([_titles count] != 0, @"Segments cannot be drawn as IDmeSegmentController was initialized without any titles.");

    for (NSUInteger i = 0; i < [_titles count]; ++i) {
        
        CGFloat segmentWidth = CGRectGetWidth(self.bounds)/[_titles count];
        CGRect segmentFrame = CGRectMake(CGRectGetMinX(self.bounds) + (i * segmentWidth),
                                         CGRectGetMinY(self.bounds),
                                         CGRectGetWidth(self.bounds)/[_titles count],
                                         CGRectGetHeight(self.bounds));
        SegmentType segmentType;
        
        if ([_titles count] == 1) {
            segmentType = SegmentTypeMiddle;
        } else {
            if (0 == i) {
                segmentType = ([_titles count] > 0) ? SegmentTypeLeft : SegmentTypeMiddle;
            } else if ([_titles count]-1 == i) {
                segmentType = SegmentTypeRight;
            } else {
                segmentType = SegmentTypeMiddle;
            }
        }
        
        IDmeSegment *currentSegment = [[IDmeSegment alloc] initWithFrame:segmentFrame
                                                             segmentType:segmentType
                                                              appearance:_appearance
                                                                andTitle:_titles[i]];
        currentSegment.delegate = self;
        [_segments addObject:currentSegment];
        [self addSubview:currentSegment];
    }
}

#pragma mark - Helpers
- (void)startAnimatingSegmentAtIndex:(NSUInteger)idx
{
    IDmeSegment *segment = (IDmeSegment *)_segments[idx];
    [segment.infoActivity startAnimating];
}

- (void)stopAnimatingSegmentAtIndex:(NSUInteger)idx withNumber:(NSInteger)number
{
    IDmeSegment *segment = (IDmeSegment *)_segments[idx];
    [segment.infoActivity stopAnimating];
    [segment.infoLabel setText:[NSString stringWithFormat:@"%d", number]];
}

- (void)startAnimatingAllSegments
{
    for (IDmeSegment *segment in _segments) {
        [segment.infoLabel setText:@""];
        [segment.infoActivity startAnimating];
    }
}

- (void)stopAnimatingAllSegmentsWithArrayOfNumbers:(NSArray *)numbers
{
    [_segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSUInteger number = (NSUInteger)numbers[idx];
        [self stopAnimatingSegmentAtIndex:idx withNumber:number];
    }];
}

#pragma mark - IDmeSegmentDelegate
- (void)segmentSelectedStateDidChange:(IDmeSegment *)selectedSegment
{
    // Notify delegate which index was selected
    NSUInteger segmentIndex = [_segments indexOfObject:selectedSegment];
    [self.delegate didSelectSegmentAtIndex:segmentIndex];
    
    // Deselect 
    for (IDmeSegment *segment in _segments) {
        if ([segment isSelected] && ![segment isEqual:selectedSegment]) {
            [segment selectSegment:NO];
        }
    }
}

@end

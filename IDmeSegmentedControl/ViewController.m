//
//  ViewController.m
//  IDmeSegmentedControl
//
//  Created by Arthur Sabintsev on 7/1/14.
//  Copyright (c) 2014 Arthur Ariel Sabintsev. All rights reserved.
//

#import "ViewController.h"
#import "IDmeSegmentedControl.h"

@interface ViewController () <IDmeSegmentedControlDelegate>

@property (nonatomic, strong) IDmeSegmentedControl *control;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.frame = [[UIScreen mainScreen] bounds];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setupSegmentedControl];
    [self setupButtons];
}

#pragma mark - Setup
- (void)setupSegmentedControl
{
    NSDictionary *appearance = @{kIDmeSegmentedControlActiveColor : [UIColor blueColor],
                                 kIDmeSegmentedControlPassiveColor : [UIColor whiteColor],
                                 kIDmeSegmentedControlCornerRadius : @5.0f,
                                 kIDmeSegmentCornerRadius : @3.0f,
                                 kIDmeSegmentFont : [UIFont systemFontOfSize:11.0f],
                                 kIDmeSegmentResultsFont : [UIFont boldSystemFontOfSize:12.0f]
                                 };
    
    NSArray *titles = @[@"Products", @"Offers", @"Promo Codes"];
    CGRect frame = CGRectMake(7.5f,
                              CGRectGetHeight(self.view.frame) / 2.0f,
                              - 15.0f + CGRectGetWidth(self.view.frame),
                              29.0f);
    _control = [[IDmeSegmentedControl alloc] initWithFrame:frame
                                                appearance:appearance
                                                 andTitles:titles];
    [_control setDelegate:self];
    [self.view addSubview:_control];
}

- (void)setupButtons
{
    UIButton *startAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startAllButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [startAllButton setBackgroundColor:[UIColor whiteColor]];
    [startAllButton setTitle:@"Start All" forState:UIControlStateNormal];
    [startAllButton setTitle:@"Start All" forState:UIControlStateSelected];
    [startAllButton.layer setCornerRadius:5.0];
    [startAllButton.layer setMasksToBounds:YES];
    [startAllButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [startAllButton.layer setBorderWidth:1.0f];
    [startAllButton addTarget:_control action:@selector(startAnimatingAllSegments) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startAllButton];
    
    UIButton *loadResultsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loadResultsButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [loadResultsButton setBackgroundColor:[UIColor whiteColor]];
    [loadResultsButton setTitle:@"Load Results" forState:UIControlStateNormal];
    [loadResultsButton setTitle:@"Load Results" forState:UIControlStateSelected];
    [loadResultsButton.layer setCornerRadius:5.0];
    [loadResultsButton.layer setMasksToBounds:YES];
    [loadResultsButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [loadResultsButton.layer setBorderWidth:1.0f];
    [loadResultsButton addTarget:self action:@selector(loadResults) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadResultsButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(startAllButton, loadResultsButton);
    NSDictionary *metrics = @{@"width" : @150};
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7.5-[startAllButton(width)]-5-[loadResultsButton(width)]"
                                                                             options:NSLayoutFormatAlignAllCenterY
                                                                             metrics:metrics
                                                                               views:views];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-24-[startAllButton]"
                                                                           options:NSLayoutFormatAlignAllCenterX
                                                                           metrics:nil
                                                                             views:views];
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
}

#pragma mark - Actions
- (void)loadResults
{
    NSUInteger constant = 99;
    [_control stopAnimatingSegmentAtIndex:0 withNumber:arc4random() % constant];
    [_control stopAnimatingSegmentAtIndex:1 withNumber:arc4random() % constant];
    [_control stopAnimatingSegmentAtIndex:2 withNumber:arc4random() % constant];
}

#pragma mark - IDmeSegmentedControlDelegate
- (void)didSelectSegmentAtIndex:(NSUInteger)idx
{
    switch (idx) {
        case 0: {
            NSLog(@"Segment 0");
        } break;
            
        case 1: {
            NSLog(@"Segment 1");
        } break;
            
        case 2: {
            NSLog(@"Segment 2");
        } break;
    }
}

@end

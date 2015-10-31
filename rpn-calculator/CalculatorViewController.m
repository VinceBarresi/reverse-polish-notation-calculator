//
//  CalculatorViewController.m
//  rpn-calculator
//
//  Created by Vincent Barresi on 10/8/15.
//  Copyright © 2015 Vincent Barresi. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSMutableArray *periodPressed;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize fullDisplay;
@synthesize userIsInTheMiddleOfEnteringNumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain;
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.fullDisplay.text = [self.fullDisplay.text stringByAppendingString:@" "];
        self.fullDisplay.text = [self.fullDisplay.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.fullDisplay.text = digit;
        self.userIsInTheMiddleOfEnteringNumber = YES;
    }
}

- (IBAction)periodPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringNumber) {
        if ([self.display.text rangeOfString:@"."].location == NSNotFound) {
            self.display.text = [self.display.text stringByAppendingString:@"."];
        }
    } else {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringNumber = YES;
    }
}

- (IBAction)piPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:@"3.14159265359"];
    } else {
        self.display.text = @"3.14159265359";
    }
}

- (IBAction)clearPressed:(id)sender {
    self.display.text = 0;
    self.fullDisplay.text = 0;
    self.userIsInTheMiddleOfEnteringNumber = NO;
    [self.brain emptyStack];
}

- (IBAction)backspacePressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringNumber) {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
        if (self.display.text.length == 0) {
            self.userIsInTheMiddleOfEnteringNumber = NO;
            self.display.text = @"";
            self.fullDisplay.text = @"";
        }
    } else {
        [self.brain removeTop];
        self.display.text = @"";
        self.fullDisplay.text = @"";
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringNumber = NO;
}


- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringNumber) [self enterPressed];
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.fullDisplay.text = [self.fullDisplay.text stringByAppendingString:@" "];
    self.fullDisplay.text = [self.fullDisplay.text stringByAppendingString:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}


@end

//
//  brainController.m
//  rpn-calculator
//
//  Created by Vincent Barresi on 10/9/15.
//  Copyright © 2015 Vincent Barresi. All rights reserved.
//

#import "calculatorBrain.h"
#import "CalculatorViewController.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
    if(!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
                        
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (void) emptyStack
{
    [self.operandStack removeAllObjects];
}

- (void) removeTop
{
    [self.operandStack removeLastObject];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if([operation isEqualToString:(@"+")]) {
        result = [self popOperand] + [self popOperand];
    }
    else if ([operation isEqualToString:(@"*")]) {
        //if (valid)
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:(@"-")]) {
        double subtrahend = [self popOperand];
        //if (valid)
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString:(@"/")]) {
        double divisor = [self popOperand];
        if(divisor) result = [self popOperand] / divisor;
    }
    else if ([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]);
    }
    else if ([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]);
    }
    else if ([operation isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    }
    else if ([operation isEqualToString:@"log"]) {
        result = log10([self popOperand]);
    }
    else if ([operation isEqualToString:@"+ / -"]) {
        double tmp = [self popOperand];
        if (tmp > 0.0) {
            result = tmp * -1;
        } else {
            result = fabs(tmp);
        }
    }
    else if ([operation isEqualToString:@"π"]) {
        result = M_PI;
    }
   
    [self pushOperand:result];
    return result;
}

@end

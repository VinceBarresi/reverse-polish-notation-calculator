//
//  calculatorBrain.h
//  rpn-calculator
//
//  Created by Vincent Barresi on 10/9/15.
//  Copyright © 2015 Vincent Barresi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain: NSObject

- (void)pushOperand:(double)operand;
- (double)popOperand;
- (double)performOperation:(NSString *)operation;


@end

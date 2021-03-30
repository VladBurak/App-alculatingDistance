//
//  ViewController.m
//  AppForDistance
//
//  Created by Vlad Burak on 25.03.2021.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest * req;

@property (weak, nonatomic) IBOutlet UITextField *startLocation;

@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;

@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UITextField *endLocationC;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitController;

@end

@implementation ViewController

- (IBAction)buttonTaped:(id)sender {
    self.calculateButton.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startLocation.text;
    NSString *destA = self.endLocationA.text;
    NSString *destB = self.endLocationB.text;
    NSString *destC = self.endLocationC.text;
    NSArray *dests = @[destA,destB,destC];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void(NSArray *responses) {
        ViewController *strongself = weakSelf;
        if (!strongself) return;
        
        NSNull *badResult = [NSNull null];
        
        if (responses[0] !=badResult ) {
            double num;
            if (strongself.unitController.selectedSegmentIndex == 0 ) {
                
                num =  ([responses[0] floatValue]/1.0);
                 NSString *x = [ NSString stringWithFormat:@"%.2f m" , num];
                 strongself.distanceA.text = x;
            }
            else  if(strongself.unitController.selectedSegmentIndex == 1 ) {
                
               num =  ([responses[0] floatValue]/1000.0);
                NSString *x = [ NSString stringWithFormat:@"%.2f km" , num];
                strongself.distanceA.text = x;
            }
            else {
                    num =  ([responses[0] floatValue]*0.00062137);
                     NSString *x = [ NSString stringWithFormat:@"%.2f miles" , num];
                     strongself.distanceA.text = x;
            }
        }
        else {
            strongself.distanceA.text = @"Error";
        }
        
        
        
        
        if (responses[1] !=badResult ) {
            double num;
            if (strongself.unitController.selectedSegmentIndex == 0 ) {
                num =  ([responses[1] floatValue]/1.0);
                 NSString *x = [ NSString stringWithFormat:@"%.2f m" , num];
                 strongself.distanceB.text = x;
            }
        
            else  if(strongself.unitController.selectedSegmentIndex == 1 ) {
                
               num =  ([responses[1] floatValue]/1000.0);
                NSString *x = [ NSString stringWithFormat:@"%.2f km" , num];
                strongself.distanceB.text = x;
            }
            else {
                    num =  ([responses[1] floatValue]*0.00062137);
                     NSString *x = [ NSString stringWithFormat:@"%.2f miles" , num];
                     strongself.distanceB.text = x;
            }
        }
        else {
            strongself.distanceB.text = @"Error";
        }
        
        
        if (responses[2] !=badResult ) {
            double num;
            if (strongself.unitController.selectedSegmentIndex == 0 ) {
                num =  ([responses[2] floatValue]/1.0);
                 NSString *x = [ NSString stringWithFormat:@"%.2f m" , num];
                 strongself.distanceC.text = x;
            }
        
            else  if(strongself.unitController.selectedSegmentIndex == 1 ) {
                
               num =  ([responses[2] floatValue]/1000.0);
                NSString *x = [ NSString stringWithFormat:@"%.2f km" , num];
                strongself.distanceC.text = x;
            }
            else {
                    num =  ([responses[2] floatValue]*0.00062137);
                     NSString *x = [ NSString stringWithFormat:@"%.2f miles" , num];
                     strongself.distanceC.text = x;
            }
        }
        else {
            strongself.distanceC.text = @"Error";
        }
        
        
        strongself.req = nil ;
        strongself.calculateButton.enabled = YES;
       
    };
    
    [self.req start];
   
    
    
}



@end

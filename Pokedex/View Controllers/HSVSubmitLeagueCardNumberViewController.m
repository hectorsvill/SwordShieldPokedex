//
//  HSVSubmitLeagueCardNumberViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/11/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVSubmitLeagueCardNumberViewController.h"
#import <CloudKit/CloudKit.h>

@interface HSVSubmitLeagueCardNumberViewController ()

@end

@implementation HSVSubmitLeagueCardNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
}

- (void)configureViews {
    self.resetButton.layer.cornerRadius = 8;
    self.submitButton.layer.cornerRadius = 8;

}

- (IBAction)resetButtonPressed:(id)sender {
    self.sectionATextField.text = @"";
    self.sectionBTextField.text = @"";
    self.sectionCTextField.text = @"";
    self.sectionDTextField.text = @"";
}

- (IBAction)submutButtonPressed:(id)sender {
    NSString *textA = self.sectionATextField.text;
    NSString *textB = self.sectionBTextField.text;
    NSString *textC = self.sectionCTextField.text;
    NSString *textD = self.sectionDTextField.text;

    NSString *cardNumber = [NSString stringWithFormat: @"%@ %@ %@ %@", textA, textB, textC, textD];



}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *currentText = [textField text];


    return textField.tag == 4 ? [currentText length] < 2 : [currentText length] < 4;
}

@end

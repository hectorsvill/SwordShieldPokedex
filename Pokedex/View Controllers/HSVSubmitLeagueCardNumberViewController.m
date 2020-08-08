//
//  HSVSubmitLeagueCardNumberViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/11/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVSubmitLeagueCardNumberViewController.h"
#import "HSVSerebiiViewController.h"
#import "HSVLeagueCard.h"
#import <NationalGalarPokedex-Swift.h>
#import <CloudKit/CloudKit.h>


@interface HSVSubmitLeagueCardNumberViewController ()

@property (nonatomic) HSVCloudFramework *cloudFramework;

@end

@implementation HSVSubmitLeagueCardNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    self.cloudFramework = [HSVCloudFramework new];
    [self configureViewAccesibility];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.cardID == nil)
        [self checkiCloudAccountStatus];
}


- (void) configureViewAccesibility {
    self.sectionATextField.isAccessibilityElement = true;
    self.sectionATextField.accessibilityIdentifier = @"SectionATextField";
    
    self.sectionBTextField.isAccessibilityElement = true;
    self.sectionBTextField.accessibilityIdentifier = @"SectionBTextField";
    
    self.sectionCTextField.isAccessibilityElement = true;
    self.sectionCTextField.accessibilityIdentifier = @"SectionCTextField";
    
    self.sectionDTextField.isAccessibilityElement = true;
    self.sectionDTextField.accessibilityIdentifier = @"SectionDTextField";
}

#pragma mark - IBAction

- (IBAction)submutButtonPressed:(id)sender {
    NSString *cardID = [self createCardIDString];
    BOOL isDuplicate = [self checkForDuplicate:cardID];;

    if (isDuplicate) {
        [self alertControlerWith:@"Card Code Error" message:@"Card Code already exist."];
    } else if ((cardID.length ==  17) && [self isValidCardIDText:cardID]) {
        NSString *message = [NSString stringWithFormat:@"Share My Card Code:\n%@", cardID];
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Share my Card Code" message:message preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self resetButtonPressed:self];
            });
        }];

        [ac addAction:cancelAction];

        UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"Share!!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self saveLeagueCardIDToiCloud:cardID];
                [self alertControlerWith:@"Awesome" message:@"Card Code will be posted shortly!"];
            });
        }];

        [ac addAction:shareAction];

        [self presentViewController:ac animated:true completion:nil];

    } else {
        [self alertControlerWith:@"Error" message:@"Invalid Leage Card ID"];
    }
}

- (IBAction)resetButtonPressed:(id)sender {
    if (self.cardID == nil) {
        self.sectionATextField.text = @"";
        self.sectionBTextField.text = @"";
        self.sectionCTextField.text = @"";
        self.sectionDTextField.text = @"";
    }
}

- (void)configureViews {
    if (self.cardID != nil) {
        // user will be viewing leage card id
        [self.resetButton setHidden:true];
        [self.submitButton setHidden:true];

        [self.sectionATextField setUserInteractionEnabled:false];
        [self.sectionBTextField setUserInteractionEnabled:false];
        [self.sectionCTextField setUserInteractionEnabled:false];
        [self.sectionDTextField setUserInteractionEnabled:false];

        NSArray *cardIDComponents = [self.cardID componentsSeparatedByString:@" "];

        self.sectionATextField.text = cardIDComponents[0];
        self.sectionBTextField.text = cardIDComponents[1];
        self.sectionCTextField.text = cardIDComponents[2];
        self.sectionDTextField.text = cardIDComponents[3];
    } else {
        // user will try to input leage card id
        self.resetButton.layer.cornerRadius = 8;
        self.submitButton.layer.cornerRadius = 8;

    }
}

- (BOOL)isValidCardIDText:(NSString *)text {
    for (NSUInteger charIndex = 0; charIndex < text.length; charIndex ++) {
        unichar character = [text characterAtIndex:  charIndex] ;
        NSLog(@"%d", character);
        if (!((character == 32) || (character >= 65 && character <= 90) || (character >= 97 && character <= 122) || (character >= 48 && character <= 57))) {
            return false;
        }
    }

    return true;
}

- (NSString *)createCardIDString {
    NSString *textA = [self.sectionATextField.text uppercaseString];
    NSString *textB = [self.sectionBTextField.text uppercaseString];
    NSString *textC = [self.sectionCTextField.text uppercaseString];
    NSString *textD = [self.sectionDTextField.text uppercaseString];

    self.sectionATextField.text = textA;
    self.sectionBTextField.text = textB;
    self.sectionCTextField.text = textC;
    self.sectionDTextField.text = textD;

    return [NSString stringWithFormat: @"%@ %@ %@ %@", textA, textB, textC, textD];
}

- (HSVLeagueCard *)createLeageCardID:(NSString *)cardID {
    return [[HSVLeagueCard new] initWithCardID:cardID isOld:false recordName:@""];
}

- (void)saveLeagueCardIDToiCloud:(NSString *)cardID {
    HSVLeagueCard *myLeageCard = [self createLeageCardID:cardID];

    for (HSVLeagueCard *card in self.cards) {
        if (card.cardID == myLeageCard.cardID) {
            [self alertControlerWith:@"Error" message:@"Leage Card Already Exist"];
            return;
        }
    }

    CKRecord *record = [self.cloudFramework createLeageCardRecordWithLeageCard:myLeageCard];
    [self.cloudFramework saveWithRecord:record completion:^(NSError *error) {
        if (error != nil) {
            [self alertControlerWith:@"Error" message:@"iCloud error saving Leage Card ID.\n Please try again."];
        }
    }];
}

- (BOOL)checkForDuplicate:(NSString *)cardID {
    for (HSVLeagueCard *card in self.cards) {
        if ([card.cardID isEqualToString:cardID])
            return true;
    }

    return false;
}

- (void)checkiCloudAccountStatus {
    [self.cloudFramework.container accountStatusWithCompletionHandler:^(CKAccountStatus accountStatus, NSError *error) {
        if (error) {
            [self alertControlerWith:@"Error" message:@"Please try again."];
            return;
        }

        if (accountStatus == CKAccountStatusNoAccount) {
            [self alertControlerWith:@"iCloud Error" message:@"User must be signed in to their iCloud account."];
        }
    }];
}

#pragma mark - AlertControllers
- (void)alertControlerWith:(NSString *)title message:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            [self.navigationController popViewControllerAnimated:true];
        }];

        [ac addAction:okAction];

        [self presentViewController:ac animated:false completion:nil];
    });
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LeageCardInfoSegue"]) {
        NSLog(@"LeageCardInfoSegue");
        HSVSerebiiViewController *viewController = (HSVSerebiiViewController *)segue.destinationViewController;
        NSString *urlString = @"https://www.serebii.net/swordshield/leaguecard.shtml";
        viewController.urlString = urlString;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *currentText = [textField text];
    return textField.tag == 4 ? [currentText length] < 2 : [currentText length] < 4;
}

@end

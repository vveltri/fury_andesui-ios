//
//  DropDownObjcViewController.m
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 30/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

#import "DropDownObjcViewController.h"

@interface DropDownObjcViewController () <AndesDropdownDelegate, AndesTextFieldDelegate>

@property(weak, nonatomic) IBOutlet AndesDropdown *andesDropdown;
@property(weak, nonatomic) IBOutlet AndesRadioButton *radioButtonForm;
@property(weak, nonatomic) IBOutlet AndesRadioButton *radioButtonStandAlone;
@property(weak, nonatomic) IBOutlet AndesTextField *textField;
@property(weak, nonatomic) IBOutlet AndesTextField *placelholderField;
@property(weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property(weak, nonatomic) IBOutlet AndesTextField *helperTextField;

@property(nonatomic) AndesDropDownMenuCell *cell;
@property(nonatomic) NSMutableArray *cellArray;

@end

@implementation DropDownObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    self.placelholderField.delegate = self;
    [self.segmentedControl setEnabled:false];
    
    [self config];
    [self setup];
    [self.radioButtonForm setRadioButtonTappedWithCallback:^(AndesRadioButton *selected) {
        [self didTapped:selected];
    }];
    [self.radioButtonStandAlone setRadioButtonTappedWithCallback:^(AndesRadioButton *selected) {
        [self didTapped:selected];
    }];
}

- (void) setup {
    self.andesDropdown.delegate = self;
    [self.andesDropdown setTriggerType:[[FormDropdownTrigger alloc]initWithTitle:@"Title" placeholder:@"Placeholder" helperText:@"Helper Text"]];
    [self.andesDropdown setMenuType:[[DropdownBottomSheetMenu alloc]initWithSeparatorStyle:AndesSeparatorStyleSingleLine
                                                                         numberOfLines:1
                                                                                  rows:self.cellArray
                                                                        selectionStyle:AndesSelectionStyleDefaultStyle]];
}

- (void)config {
    AndesDropDownMenuCell *mastercard = [[AndesDropDownMenuCell alloc] initWithTitle:@"Dinero en cuenta"
                                                                     thumbnail:[[AndesThumbnail alloc] initWithHierarchy: AndesThumbnailHierarchyDefaultHierarchy
                                                                                                                    type:AndesThumbnailTypeImageCircle
                                                                                                                    size:AndesThumbnailSizeSize80
                                                                                                                   state:AndesThumbnailStateEnabled
                                                                                                                   image:[UIImage imageNamed:@"mastercard"]
                                                                                                             accentColor:NULL]];
    AndesDropDownMenuCell *visa = [[AndesDropDownMenuCell alloc] initWithTitle:@"Visa debito **** 0899"
                                                                     thumbnail:[[AndesThumbnail alloc] initWithHierarchy: AndesThumbnailHierarchyDefaultHierarchy
                                                                                                                    type:AndesThumbnailTypeImageCircle
                                                                                                                    size:AndesThumbnailSizeSize80
                                                                                                                   state:AndesThumbnailStateEnabled
                                                                                                                   image:[UIImage imageNamed:@"visa"]
                                                                                                             accentColor:NULL]];
    AndesDropDownMenuCell *bbva1 = [[AndesDropDownMenuCell alloc] initWithTitle:@"BBVA **** 7788"
                                                                     thumbnail:[[AndesThumbnail alloc] initWithHierarchy: AndesThumbnailHierarchyDefaultHierarchy
                                                                                                                    type:AndesThumbnailTypeImageCircle
                                                                                                                    size:AndesThumbnailSizeSize80
                                                                                                                   state:AndesThumbnailStateEnabled
                                                                                                                   image:[UIImage imageNamed:@"american"]
                                                                                                             accentColor:NULL]];
    AndesDropDownMenuCell *bbva2 = [[AndesDropDownMenuCell alloc] initWithTitle:@"BBVA **** 4545"
                                                                     thumbnail:[[AndesThumbnail alloc] initWithHierarchy: AndesThumbnailHierarchyDefaultHierarchy
                                                                                                                    type:AndesThumbnailTypeImageCircle
                                                                                                                    size:AndesThumbnailSizeSize80
                                                                                                                   state:AndesThumbnailStateEnabled
                                                                                                                   image:[UIImage imageNamed:@"american"]
                                                                                                             accentColor:NULL]];
    AndesDropDownMenuCell *mercadoCreditos = [[AndesDropDownMenuCell alloc] initWithTitle:@"Mercado Créditos"
                                                                     thumbnail:[[AndesThumbnail alloc] initWithHierarchy: AndesThumbnailHierarchyDefaultHierarchy
                                                                                                                    type:AndesThumbnailTypeImageCircle
                                                                                                                    size:AndesThumbnailSizeSize80
                                                                                                                   state:AndesThumbnailStateEnabled
                                                                                                                   image:[UIImage imageNamed:@"mercadocredito"]
                                                                                                             accentColor:NULL]];
    
    self.cellArray = [[NSMutableArray alloc]init];
    [self.cellArray addObject:mastercard];
    [self.cellArray addObject:visa];
    [self.cellArray addObject:bbva1];
    [self.cellArray addObject:bbva2];
    [self.cellArray addObject:mercadoCreditos];
}

- (void)didTapped:(AndesRadioButton *)radioButton {
    if (radioButton == self.radioButtonForm) {
        self.radioButtonForm.status = AndesRadioButtonStatusSelected;
        self.radioButtonStandAlone.status = AndesRadioButtonStatusUnselected;
        self.textField.state = AndesTextInputStateIdle;
        self.placelholderField.state = AndesTextInputStateIdle;
        [self.segmentedControl setEnabled:false];
        [self updateFormDropdownView:@"" placeholder:@"Placeholder para Dropdown" helperText:@"Palceholder Helper text"];
    }
    else if (radioButton == self.radioButtonStandAlone) {
        self.radioButtonForm.status = AndesRadioButtonStatusUnselected;
        self.radioButtonStandAlone.status = AndesRadioButtonStatusSelected;
        self.textField.state = AndesTextInputStateDisabled;
        self.placelholderField.state = AndesTextInputStateDisabled;
        [self.segmentedControl setEnabled:true];
        [self updateStandaloneDropdownView:AndesStandaloneSizeMedium];
    }
    self.textField.text = @"";
    self.placelholderField.text = @"";
    self.segmentedControl.selectedSegmentIndex = 1;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
}

- (void)updateFormDropdownView:(NSString *)title placeholder: (NSString *)placeholder helperText: (NSString *)helperText {
    [self.andesDropdown setTriggerType:[[FormDropdownTrigger alloc]initWithTitle:title placeholder:placeholder helperText:helperText]];
}

- (void)updateStandaloneDropdownView:(AndesStandaloneSize)size {
    [self.andesDropdown setTriggerType:[[StandaloneDropdownTrigger alloc]initWithSize:size]];
}

- (IBAction)valueChangeSegmented {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self updateStandaloneDropdownView:AndesStandaloneSizeSmall];
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        [self updateStandaloneDropdownView:AndesStandaloneSizeMedium];
    } else {
        [self updateStandaloneDropdownView:AndesStandaloneSizeLarge];
    }
}

- (void)andesTextFieldDidEndEditing:(AndesTextField *)textField {
    if ([self.andesDropdown.triggerType isMemberOfClass:[FormDropdownTrigger class]]) {
        [self updateFormDropdownView:self.textField.text placeholder:self.placelholderField.text helperText:self.helperTextField.text];
    }
    else {
        [self updateStandaloneDropdownView:AndesStandaloneSizeMedium];
    }
}

@end

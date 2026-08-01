import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Train like an athlete'**
  String get appTitle;

  /// No description provided for @athleteIndexTitle.
  ///
  /// In en, this message translates to:
  /// **'Athlete Index'**
  String get athleteIndexTitle;

  /// Badge shown when the index is based on incomplete data
  ///
  /// In en, this message translates to:
  /// **'Forecast'**
  String get athleteIndexForecast;

  /// No description provided for @weakLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Weak link'**
  String get weakLinkTitle;

  /// No description provided for @allTests.
  ///
  /// In en, this message translates to:
  /// **'All tests'**
  String get allTests;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @levelNovice.
  ///
  /// In en, this message translates to:
  /// **'Novice'**
  String get levelNovice;

  /// No description provided for @levelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get levelBeginner;

  /// No description provided for @levelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get levelIntermediate;

  /// No description provided for @levelAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get levelAdvanced;

  /// No description provided for @levelElite.
  ///
  /// In en, this message translates to:
  /// **'Elite'**
  String get levelElite;

  /// No description provided for @levelAthlete.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get levelAthlete;

  /// No description provided for @categoryStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get categoryStrength;

  /// No description provided for @categorySpeed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get categorySpeed;

  /// No description provided for @categoryEndurance.
  ///
  /// In en, this message translates to:
  /// **'Endurance'**
  String get categoryEndurance;

  /// No description provided for @categoryExplosive.
  ///
  /// In en, this message translates to:
  /// **'Explosive power'**
  String get categoryExplosive;

  /// No description provided for @categoryCoordination.
  ///
  /// In en, this message translates to:
  /// **'Coordination'**
  String get categoryCoordination;

  /// No description provided for @categoryFlexibility.
  ///
  /// In en, this message translates to:
  /// **'Flexibility'**
  String get categoryFlexibility;

  /// No description provided for @categoryBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get categoryBalance;

  /// No description provided for @categoryMobility.
  ///
  /// In en, this message translates to:
  /// **'Mobility'**
  String get categoryMobility;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @onboardingStepGender.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get onboardingStepGender;

  /// No description provided for @onboardingStepBasics.
  ///
  /// In en, this message translates to:
  /// **'About you'**
  String get onboardingStepBasics;

  /// No description provided for @onboardingStepExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience & goal'**
  String get onboardingStepExperience;

  /// No description provided for @onboardingStepEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get onboardingStepEquipment;

  /// No description provided for @onboardingStepHealth.
  ///
  /// In en, this message translates to:
  /// **'Health (PAR-Q)'**
  String get onboardingStepHealth;

  /// No description provided for @onboardingStepConsent.
  ///
  /// In en, this message translates to:
  /// **'Consent'**
  String get onboardingStepConsent;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderUnspecified.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get genderUnspecified;

  /// No description provided for @fieldDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get fieldDateOfBirth;

  /// No description provided for @fieldWeightKg.
  ///
  /// In en, this message translates to:
  /// **'Weight, kg'**
  String get fieldWeightKg;

  /// No description provided for @fieldHeightCm.
  ///
  /// In en, this message translates to:
  /// **'Height, cm'**
  String get fieldHeightCm;

  /// No description provided for @fieldExperience.
  ///
  /// In en, this message translates to:
  /// **'Training experience'**
  String get fieldExperience;

  /// No description provided for @fieldGoal.
  ///
  /// In en, this message translates to:
  /// **'Main goal'**
  String get fieldGoal;

  /// No description provided for @equipmentHint.
  ///
  /// In en, this message translates to:
  /// **'Select the equipment you have access to'**
  String get equipmentHint;

  /// No description provided for @parqIntro.
  ///
  /// In en, this message translates to:
  /// **'Please answer 7 standard readiness questions.'**
  String get parqIntro;

  /// No description provided for @parqAnswerYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get parqAnswerYes;

  /// No description provided for @parqAnswerNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get parqAnswerNo;

  /// No description provided for @parqWarning.
  ///
  /// In en, this message translates to:
  /// **'Based on your answers, consult a doctor before doing maximal tests. You can still use the app.'**
  String get parqWarning;

  /// No description provided for @consentText.
  ///
  /// In en, this message translates to:
  /// **'I accept the Terms of Use and Privacy Policy.'**
  String get consentText;

  /// No description provided for @consentRequired.
  ///
  /// In en, this message translates to:
  /// **'Accepting the terms is required to continue.'**
  String get consentRequired;

  /// No description provided for @medicalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'The app does not replace medical advice.'**
  String get medicalDisclaimer;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill in this field'**
  String get validationRequired;

  /// No description provided for @loadDemoData.
  ///
  /// In en, this message translates to:
  /// **'Load demo results'**
  String get loadDemoData;

  /// No description provided for @clearData.
  ///
  /// In en, this message translates to:
  /// **'Clear results'**
  String get clearData;

  /// No description provided for @takeTestsPrompt.
  ///
  /// In en, this message translates to:
  /// **'Take at least 2 tests in each category to see your index.'**
  String get takeTestsPrompt;

  /// No description provided for @cohortStandardPrefix.
  ///
  /// In en, this message translates to:
  /// **'Standard for'**
  String get cohortStandardPrefix;

  /// No description provided for @catalogTitle.
  ///
  /// In en, this message translates to:
  /// **'Test catalog'**
  String get catalogTitle;

  /// No description provided for @currentScore.
  ///
  /// In en, this message translates to:
  /// **'Current score'**
  String get currentScore;

  /// No description provided for @notTested.
  ///
  /// In en, this message translates to:
  /// **'Not tested'**
  String get notTested;

  /// No description provided for @recordResult.
  ///
  /// In en, this message translates to:
  /// **'Record result'**
  String get recordResult;

  /// No description provided for @howToPerform.
  ///
  /// In en, this message translates to:
  /// **'How to perform'**
  String get howToPerform;

  /// No description provided for @requiredEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get requiredEquipment;

  /// No description provided for @fieldResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get fieldResult;

  /// No description provided for @fieldNote.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get fieldNote;

  /// No description provided for @fieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get fieldDate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @unitSeconds.
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get unitSeconds;

  /// No description provided for @unitMinutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get unitMinutes;

  /// No description provided for @unitMeters.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get unitMeters;

  /// No description provided for @unitCentimeters.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get unitCentimeters;

  /// No description provided for @unitKilograms.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKilograms;

  /// No description provided for @unitReps.
  ///
  /// In en, this message translates to:
  /// **'reps'**
  String get unitReps;

  /// No description provided for @unitMilliseconds.
  ///
  /// In en, this message translates to:
  /// **'ms'**
  String get unitMilliseconds;

  /// No description provided for @reactionTapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to start'**
  String get reactionTapToStart;

  /// No description provided for @reactionWait.
  ///
  /// In en, this message translates to:
  /// **'Wait for green…'**
  String get reactionWait;

  /// No description provided for @reactionTapNow.
  ///
  /// In en, this message translates to:
  /// **'TAP!'**
  String get reactionTapNow;

  /// No description provided for @reactionTooEarly.
  ///
  /// In en, this message translates to:
  /// **'Too early — wait for green'**
  String get reactionTooEarly;

  /// No description provided for @reactionTrial.
  ///
  /// In en, this message translates to:
  /// **'Trial'**
  String get reactionTrial;

  /// No description provided for @reactionAverage.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get reactionAverage;

  /// No description provided for @reactionSaved.
  ///
  /// In en, this message translates to:
  /// **'Reaction result saved'**
  String get reactionSaved;

  /// No description provided for @unitPounds.
  ///
  /// In en, this message translates to:
  /// **'lb'**
  String get unitPounds;

  /// No description provided for @unitInches.
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get unitInches;

  /// No description provided for @unitFeet.
  ///
  /// In en, this message translates to:
  /// **'ft'**
  String get unitFeet;

  /// No description provided for @ratingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating 1–5'**
  String get ratingLabel;

  /// No description provided for @scoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get scoreLabel;

  /// No description provided for @previewNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get previewNow;

  /// No description provided for @previewAfter.
  ///
  /// In en, this message translates to:
  /// **'After saving'**
  String get previewAfter;

  /// No description provided for @indexLabel.
  ///
  /// In en, this message translates to:
  /// **'Index'**
  String get indexLabel;

  /// No description provided for @infoTitle.
  ///
  /// In en, this message translates to:
  /// **'About the test'**
  String get infoTitle;

  /// No description provided for @infoCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get infoCategory;

  /// No description provided for @infoStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard (min → max)'**
  String get infoStandard;

  /// No description provided for @infoDirectionHigher.
  ///
  /// In en, this message translates to:
  /// **'Higher is better'**
  String get infoDirectionHigher;

  /// No description provided for @infoDirectionLower.
  ///
  /// In en, this message translates to:
  /// **'Lower is better'**
  String get infoDirectionLower;

  /// No description provided for @infoDetailsSoon.
  ///
  /// In en, this message translates to:
  /// **'Detailed guidance (how to perform, common mistakes, safety) is coming.'**
  String get infoDetailsSoon;

  /// No description provided for @savedSnack.
  ///
  /// In en, this message translates to:
  /// **'Result saved'**
  String get savedSnack;

  /// No description provided for @indexOverTime.
  ///
  /// In en, this message translates to:
  /// **'Index over time'**
  String get indexOverTime;

  /// No description provided for @personalRecords.
  ///
  /// In en, this message translates to:
  /// **'Personal records'**
  String get personalRecords;

  /// No description provided for @notEnoughData.
  ///
  /// In en, this message translates to:
  /// **'Take more tests to see the chart'**
  String get notEnoughData;

  /// No description provided for @lastChange.
  ///
  /// In en, this message translates to:
  /// **'Change since previous test'**
  String get lastChange;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No results yet. Record your first test.'**
  String get historyEmpty;

  /// No description provided for @infoWhatMeasures.
  ///
  /// In en, this message translates to:
  /// **'What it measures'**
  String get infoWhatMeasures;

  /// No description provided for @infoWhyNeeded.
  ///
  /// In en, this message translates to:
  /// **'Why it matters'**
  String get infoWhyNeeded;

  /// No description provided for @infoHowToPerform.
  ///
  /// In en, this message translates to:
  /// **'How to perform'**
  String get infoHowToPerform;

  /// No description provided for @infoHowToEnter.
  ///
  /// In en, this message translates to:
  /// **'How to enter the result'**
  String get infoHowToEnter;

  /// No description provided for @infoCommonMistakes.
  ///
  /// In en, this message translates to:
  /// **'Common mistakes'**
  String get infoCommonMistakes;

  /// No description provided for @infoSafety.
  ///
  /// In en, this message translates to:
  /// **'Contraindications & safety'**
  String get infoSafety;

  /// No description provided for @infoRadarImpact.
  ///
  /// In en, this message translates to:
  /// **'Radar impact'**
  String get infoRadarImpact;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsUnits.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get settingsUnits;

  /// No description provided for @unitsMetric.
  ///
  /// In en, this message translates to:
  /// **'Metric'**
  String get unitsMetric;

  /// No description provided for @unitsImperial.
  ///
  /// In en, this message translates to:
  /// **'Imperial'**
  String get unitsImperial;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @settingsScale.
  ///
  /// In en, this message translates to:
  /// **'Score scale'**
  String get settingsScale;

  /// No description provided for @scaleLinear.
  ///
  /// In en, this message translates to:
  /// **'Linear'**
  String get scaleLinear;

  /// No description provided for @scaleNonlinear.
  ///
  /// In en, this message translates to:
  /// **'Non-linear'**
  String get scaleNonlinear;

  /// No description provided for @scaleHint.
  ///
  /// In en, this message translates to:
  /// **'Non-linear scale grows faster at the start and plateaus near 100.'**
  String get scaleHint;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsNotifications;

  /// No description provided for @settingsData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsData;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export my data'**
  String get exportData;

  /// No description provided for @exportDone.
  ///
  /// In en, this message translates to:
  /// **'Export ready'**
  String get exportDone;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my data'**
  String get deleteAccount;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all data?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Your profile and all results will be permanently removed from this device.'**
  String get deleteConfirmBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// No description provided for @scienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Science base'**
  String get scienceTitle;

  /// No description provided for @scienceRationale.
  ///
  /// In en, this message translates to:
  /// **'Why these tests'**
  String get scienceRationale;

  /// No description provided for @scienceFormula.
  ///
  /// In en, this message translates to:
  /// **'How the score is calculated'**
  String get scienceFormula;

  /// No description provided for @scienceNorms.
  ///
  /// In en, this message translates to:
  /// **'Choosing the norms'**
  String get scienceNorms;

  /// No description provided for @scienceReferences.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get scienceReferences;

  /// No description provided for @scienceDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get scienceDisclaimerTitle;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @achievementsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked'**
  String get achievementsUnlocked;

  /// No description provided for @peerTitle.
  ///
  /// In en, this message translates to:
  /// **'Cohort comparison'**
  String get peerTitle;

  /// No description provided for @peerHigherThan.
  ///
  /// In en, this message translates to:
  /// **'Higher than'**
  String get peerHigherThan;

  /// No description provided for @peerCohort.
  ///
  /// In en, this message translates to:
  /// **'of your cohort'**
  String get peerCohort;

  /// No description provided for @peerLocked.
  ///
  /// In en, this message translates to:
  /// **'Complete a full test cycle (all 8 categories) to compare with your cohort.'**
  String get peerLocked;

  /// No description provided for @peerModelNote.
  ///
  /// In en, this message translates to:
  /// **'Estimated from a statistical cohort model until real data is available.'**
  String get peerModelNote;

  /// No description provided for @batteriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Test batteries'**
  String get batteriesTitle;

  /// No description provided for @batteryRecord.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get batteryRecord;

  /// No description provided for @batteryDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get batteryDone;

  /// No description provided for @batterySessionTime.
  ///
  /// In en, this message translates to:
  /// **'Session time'**
  String get batterySessionTime;

  /// No description provided for @batteryProgress.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get batteryProgress;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import my data'**
  String get importData;

  /// No description provided for @importHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the exported JSON here'**
  String get importHint;

  /// No description provided for @importApply.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importApply;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data imported'**
  String get importSuccess;

  /// No description provided for @importError.
  ///
  /// In en, this message translates to:
  /// **'Could not read the data'**
  String get importError;

  /// No description provided for @currentWeight.
  ///
  /// In en, this message translates to:
  /// **'Current weight, kg'**
  String get currentWeight;

  /// No description provided for @currentHeight.
  ///
  /// In en, this message translates to:
  /// **'Current height, cm'**
  String get currentHeight;

  /// No description provided for @bodyMetricsHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm or update your weight and height for this test'**
  String get bodyMetricsHint;

  /// No description provided for @updateWeight.
  ///
  /// In en, this message translates to:
  /// **'Update weight'**
  String get updateWeight;

  /// No description provided for @updateHeight.
  ///
  /// In en, this message translates to:
  /// **'Update height'**
  String get updateHeight;

  /// No description provided for @saveShort.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveShort;

  /// No description provided for @improveCta.
  ///
  /// In en, this message translates to:
  /// **'Improve'**
  String get improveCta;

  /// No description provided for @improveTitle.
  ///
  /// In en, this message translates to:
  /// **'How to improve'**
  String get improveTitle;

  /// No description provided for @improveWhy.
  ///
  /// In en, this message translates to:
  /// **'This is your lowest-scoring quality. Focus here for the biggest gains.'**
  String get improveWhy;

  /// No description provided for @planCta.
  ///
  /// In en, this message translates to:
  /// **'Weekly plan'**
  String get planCta;

  /// No description provided for @planTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly plan'**
  String get planTitle;

  /// No description provided for @planDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get planDay;

  /// No description provided for @planEmpty.
  ///
  /// In en, this message translates to:
  /// **'Take a few tests so we can find your weak links.'**
  String get planEmpty;

  /// No description provided for @shareRadar.
  ///
  /// In en, this message translates to:
  /// **'Share radar'**
  String get shareRadar;

  /// No description provided for @shareAction.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareAction;

  /// No description provided for @cloudTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync'**
  String get cloudTitle;

  /// No description provided for @cloudNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync is not configured in this build.'**
  String get cloudNotConfigured;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @cloudSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as'**
  String get cloudSignedInAs;

  /// No description provided for @cloudSignInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in to back up and sync your data across devices.'**
  String get cloudSignInPrompt;

  /// No description provided for @cloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Back up to cloud'**
  String get cloudBackup;

  /// No description provided for @cloudRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore from cloud'**
  String get cloudRestore;

  /// No description provided for @cloudBackupHint.
  ///
  /// In en, this message translates to:
  /// **'Your profile and results are stored privately (only you can access them).'**
  String get cloudBackupHint;

  /// No description provided for @cloudBackupDone.
  ///
  /// In en, this message translates to:
  /// **'Backed up to cloud'**
  String get cloudBackupDone;

  /// No description provided for @cloudRestoreDone.
  ///
  /// In en, this message translates to:
  /// **'Restored from cloud'**
  String get cloudRestoreDone;

  /// No description provided for @cloudSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get cloudSignedIn;

  /// No description provided for @cloudError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get cloudError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

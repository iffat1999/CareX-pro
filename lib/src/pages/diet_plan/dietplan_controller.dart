class DietplanController {
  String name = '';
  int age = 0;
  String gender = 'Male';
  double bmi = 0.0;

  bool hasDiabetes = false;
  int? glucoseLevel;
  int? hba1c;
  String currentMedications = '';

  bool hasBP = false;
  int? sysPressure;
  int? diastolicPressure;

  // loading indicator for diet plan generator...
  bool isLoading = false;

  String dietPlan = """""";

  String generatePrompt() {
    String medicalCondition = hasBP
        ? "I have Blood Pressure with, "
            "\nSystolic Pressure (mmHg): $sysPressure"
            "\nDiastolic Pressure (mmHg): $diastolicPressure"
        : hasDiabetes
            ? "I have diabetes with, "
                "\nBlood Glucose Level (mg/dL): $glucoseLevel"
                "\nHbA1c: $hba1c%"
                "\nCurrent Medications: $currentMedications"
            : "";

    return 'Generate a personalized diet plan for the following details:'
        '\nName: $name'
        '\nAge: $age'
        '\nGender: $gender'
        '\nBMI: $bmi'
        '\nMedical Condition: $medicalCondition. Only diet plan details and do not need introduction.';
  }
}

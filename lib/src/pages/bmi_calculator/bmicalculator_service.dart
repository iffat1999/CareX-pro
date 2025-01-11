import 'package:carex_pro/src/pages/bmi_calculator/bmicalculator_controller.dart';

class BmicalculatorService {
  final bmiCalcController = BmicalculatorController();

  double calculateBmi() {
    // BMI Calculation
    double heightInMeters = bmiCalcController.height / 100;
    bmiCalcController.bmi =
        bmiCalcController.weight / (heightInMeters * heightInMeters);

    // IBW Calculation (Devine Formula)
    if (bmiCalcController.gender == 'Male') {
      return bmiCalcController.ibw = 50 +
          0.9 * (bmiCalcController.height - 152.4); // Ideal weight for males
    } else {
      return bmiCalcController.ibw = 45.5 +
          0.9 * (bmiCalcController.height - 152.4); // Ideal weight for females
    }
  }
}

import 'package:sensors_plus/sensors_plus.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class SensorData {
  late double ax, ay, az, gx, gy, gz = 0;

  SensorData(double ax, double ay, double az, double gx, double gy, double gz) {
    this.ax = normalizer(ax, 1, 0);
    this.ay = normalizer(ay, 1, 0);
    this.az = normalizer(az, 1, 0);
    this.gx = normalizer(gx, 1, 0);
    this.gy = normalizer(gy, 1, 0);
    this.gz = normalizer(gz, 1, 0);
  }

  double normalizer(double value, double minmax, double avg) {
    double v = value;

    if (value < -minmax) {
      v = -minmax;
    }

    if (value > minmax) {
      v = minmax;
    }

    v = (v - avg) / minmax;
    return v;
  }

  List<double> toList() {
    return [ax, ay, az, gx, gy, gz];
  }
}

class ModelProcessor {
  //Model Stuff
  bool _modelLoaded = false;
  late Interpreter _tfInterpreter;
  ModelResult results = ModelResult.unkown;
  late final List<List<double>> _inputs;

  void initModel() async {
    _tfInterpreter =
        await Interpreter.fromAsset("TF_LariModel_Conv_S64_V13.tflite");
    _modelLoaded = true;
    _inputs =
        List.filled(64, SensorData(0, 0, 0, 0, 0, 0).toList(), growable: true);
  }

  ModelProcessor();

  void _addInput(SensorData data) {
    _inputs.add(data.toList());
    if (_inputs.length > 128) {
      _inputs.removeAt(0);
    }
  }

  ModelResult run(AccelerometerEvent a, GyroscopeEvent g) {
    if (_modelLoaded == false) {
      return ModelResult.unkown;
    }

    var data = SensorData(a.x, a.y, a.z, g.x, g.y, g.z);
    _addInput(data);

    var input = [_inputs];

    // if output tensor shape [1,1] and type is float32
    var output = List.filled(2 * 1, 0).reshape([2, 1]);

    // inference
    _tfInterpreter.run(input, output);

    //double result = (output[0][0] + output[1][0]) / 2;

    //get the smallest value
    double result = output[0][0] < output[1][0] ? output[0][0] : output[1][0];

    //print("$result : $input");

    int r = result.round();

    if (r == 1) {
      return ModelResult.jalanCepat;
    } else {
      return ModelResult.jalanBiasa;
    }
  }
}

enum ModelResult { jalanBiasa, jalanCepat, unkown }

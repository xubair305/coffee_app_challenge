import 'package:coffee_challenge/app/app.dart';
import 'package:coffee_challenge/bootstrap.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  dotenv.load(fileName: 'dev.env');
  bootstrap(() => const App());
}

import 'package:coffee_challenge/app/app.dart';
import 'package:coffee_challenge/bootstrap.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  dotenv.load(fileName: 'production.env');
  bootstrap(() => const App());
}

import 'dart:convert';
import 'dart:io';

import 'package:foodmarket/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'user_services.dart';
part 'food_services.dart';
part 'transaction_services.dart';

String baseURL = 'http://foodmarket-backend.buildwithangga.id/api/';

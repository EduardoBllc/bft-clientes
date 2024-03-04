import 'package:flutter/cupertino.dart';

import '../models/customer.dart';

class CustomersProvider extends ChangeNotifier {
  final List<Customer> customersList = [
    Customer(
        name: 'João de Almeida',
        birthdate: DateTime(1998, 2, 24),
        whatsapp: '54996758088'),
    Customer(
        name: 'Adriano Souza Vieira',
        birthdate: DateTime(1967, 5, 15),
        whatsapp: '54992814567'),
    Customer(
        name: 'Pedro Augusto Dias',
        birthdate: DateTime(2003, 2, 28),
        whatsapp: '54995734512'),
    Customer(
        name: 'Claudecir Araujo',
        birthdate: DateTime(1973, 8, 17),
        whatsapp: '54998175339'),
    Customer(
        name: 'Isadora Mendes',
        birthdate: DateTime(1977, 11, 22),
        whatsapp: '7199853505'),
    Customer(
        name: 'João Vitor Alves',
        birthdate: DateTime(1974, 2, 29),
        whatsapp: '7198609930'),
    Customer(
        name: 'Marcos Vinicius Barros',
        birthdate: DateTime(1967, 06, 18),
        whatsapp: '8196376662'),
    Customer(
        name: 'Carlos Eduardo Monteiro',
        birthdate: DateTime(1974, 05, 17),
        whatsapp: '1194273767'),
    Customer(
        name: 'Ian Araújo',
        birthdate: DateTime(2001, 11, 03),
        whatsapp: '4197028781'),
    Customer(
        name: 'Theo Dias',
        birthdate: DateTime(1967, 09, 16),
        whatsapp: '4195247733'),
    Customer(
        name: 'João Vitor Souza',
        birthdate: DateTime(1994, 2, 21),
        whatsapp: '5196026353'),
    Customer(
        name: 'Benjamin Lima',
        birthdate: DateTime(2000, 05, 13),
        whatsapp: '6190945813'),
    Customer(
        name: 'Luigi Porto',
        birthdate: DateTime(1977, 02, 14),
        whatsapp: '3196197147'),
    Customer(
        name: 'Joaquim Barbosa',
        birthdate: DateTime(1989, 07, 13),
        whatsapp: '8190259640')
  ];
}

import 'package:flutter/cupertino.dart';

import '../../models/customer.dart';

class CustomersProvider extends ChangeNotifier {
  List<Customer> _customersList = [
    // Customer(name: 'João de Almeida', birthdate: DateTime(1998, 2, 24), whatsapp: '54996758088'),
    // Customer(name: 'Adriano Souza Vieira', birthdate: DateTime(1967, 3, 16), whatsapp: '54992814567'),
    // Customer(name: 'Pedro Augusto Dias', birthdate: DateTime(2003, 3, 16), whatsapp: '54995734512'),
    // Customer(name: 'Claudecir Araujo', birthdate: DateTime(1973, 3, 16), whatsapp: '54998175339'),
    // Customer(name: 'Isadora Mendes', birthdate: DateTime(1977, 3, 16), whatsapp: '7199853505'),
    // Customer(
    //   name: 'João Vitor Alves',
    //   birthdate: DateTime(1974, 3, 16),
    //   whatsapp: '7198609930',
    //   customMessage: 'Este é um exemplo de mensagem personalizada',
    // ),
    // Customer(name: 'Marcos Vinicius Barros', birthdate: DateTime(1967, 03, 15), whatsapp: '8196376662'),
    // Customer(name: 'Carlos Eduardo Monteiro', birthdate: DateTime(1974, 05, 17), whatsapp: '1194273767'),
    // Customer(name: 'Ian Araújo', birthdate: DateTime(2001, 11, 03), whatsapp: '4197028781'),
    // Customer(name: 'Theo Dias', birthdate: DateTime(1967, 09, 16), whatsapp: '4195247733'),
    // Customer(name: 'João Vitor Souza', birthdate: DateTime(1994, 2, 21), whatsapp: '5196026353'),
    // Customer(name: 'Benjamin Lima', birthdate: DateTime(2000, 05, 13), whatsapp: '6190945813'),
    // Customer(name: 'Luigi Porto', birthdate: DateTime(1977, 02, 14), whatsapp: '3196197147'),
    // Customer(name: 'Joaquim Barbosa', birthdate: DateTime(1989, 07, 13), whatsapp: '8190259640'),
    // Customer(name: 'Rafael Gonçalves', birthdate: DateTime(2004, 4, 4), whatsapp: '11987654321'),
    // Customer(name: 'Lucas Pereira', birthdate: DateTime(1992, 4, 5), whatsapp: '21987654322'),
    // Customer(name: 'Mateus Oliveira', birthdate: DateTime(1985, 4, 6), whatsapp: '31987654323'),
    // Customer(name: 'Gabriel Santos', birthdate: DateTime(1978, 4, 7), whatsapp: '41987654324'),
    // Customer(name: 'Fernando Costa', birthdate: DateTime(1980, 4, 8), whatsapp: '51987654325'),
    // Customer(name: 'Gustavo Silva', birthdate: DateTime(1983, 4, 9), whatsapp: '61987654326'),
    // Customer(name: 'Felipe Moura', birthdate: DateTime(1995, 4, 10), whatsapp: '71987654327'),
    // Customer(name: 'Rodrigo Teixeira', birthdate: DateTime(1990, 4, 12), whatsapp: '81987654328'),
    // Customer(name: 'Guilherme Almeida', birthdate: DateTime(1987, 4, 14), whatsapp: '91987654329'),
    // Customer(name: 'Leonardo Souza', birthdate: DateTime(1996, 4, 16), whatsapp: '21987654330'),
    // Customer(name: 'Marcelo Barros', birthdate: DateTime(1989, 4, 18), whatsapp: '31987654331'),
    // Customer(name: 'Tiago Leal', birthdate: DateTime(1982, 4, 20), whatsapp: '41987654332'),
    // Customer(name: 'Caio Cunha', birthdate: DateTime(1991, 4, 22), whatsapp: '51987654333'),
    // Customer(name: 'Vitor Lopes', birthdate: DateTime(1984, 4, 24), whatsapp: '61987654334'),
    // Customer(name: 'Henrique Dias', birthdate: DateTime(1975, 4, 26), whatsapp: '71987654335'),
    // Customer(name: 'André Lima', birthdate: DateTime(1998, 4, 28), whatsapp: '81987654336'),
    // Customer(name: 'Bruno Rocha', birthdate: DateTime(2001, 4, 4), whatsapp: '91987654337'),
    // Customer(name: 'Carlos Eduardo Ferreira', birthdate: DateTime(1976, 4, 5), whatsapp: '21987654338'),
    // Customer(name: 'Daniel Fonseca', birthdate: DateTime(1988, 4, 7), whatsapp: '31987654339'),
    // Customer(name: 'Eduardo Pires', birthdate: DateTime(1993, 4, 9), whatsapp: '41987654340'),
    // Customer(name: 'Fábio Araújo', birthdate: DateTime(1979, 4, 11), whatsapp: '51987654341'),
    // Customer(name: 'Giovanni Brito', birthdate: DateTime(1994, 4, 13), whatsapp: '61987654342'),
    // Customer(name: 'Hélio Camargo', birthdate: DateTime(1981, 4, 15), whatsapp: '71987654343'),
    // Customer(name: 'Ítalo Drummond', birthdate: DateTime(1972, 4, 17), whatsapp: '81987654344'),
    // Customer(name: 'Júlio Martins', birthdate: DateTime(1986, 4, 19), whatsapp: '91987654345'),
    // Customer(name: 'Léo Nascimento', birthdate: DateTime(2000, 4, 21), whatsapp: '21987654346'),
    // Customer(name: 'Márcio Ramos', birthdate: DateTime(1974, 4, 23), whatsapp: '31987654347'),
    // Customer(name: 'Nelson Ribeiro', birthdate: DateTime(1997, 4, 25), whatsapp: '41987654348'),
    // Customer(name: 'Otávio Mendonça', birthdate: DateTime(2003, 4, 27), whatsapp: '51987654349'),
    // Customer(name: 'Paulo Gomes', birthdate: DateTime(1983, 4, 4), whatsapp: '61987654350'),
    // Customer(name: 'Marlon Braga', birthdate: DateTime(1983, 4, 4), whatsapp: '91987665438'),
    // Customer(name: 'Eduardo Silva', birthdate: DateTime(1978, 4, 4), whatsapp: '21987665439'),
    // Customer(name: 'Roberto Farias', birthdate: DateTime(1992, 4, 4), whatsapp: '31987665440'),
  ];

  List<Customer> get customersList => _customersList;
  set customersList(List<Customer> customerList) {
    _customersList = customerList;
    notifyListeners();
  }

  void addCustomer(Customer customer) {
    _customersList.add(customer);
    notifyListeners();
  }

  Customer _customerFinder(Customer customer) {
    return _customersList[_customersList.indexOf(customer)];
  }

  void changeCustomerMessage(Customer customer, String message) {
    _customerFinder(customer).customMessage = message;
    notifyListeners();
  }

  Customer editCustomer(
    Customer customer, {
    String? name,
    String? message,
    String? whatsapp,
    DateTime? birthdate,
  }) {
    Customer providerCustomer = _customerFinder(customer);
    if (name != null) {
      providerCustomer.name = name;
    }
    if (birthdate != null) {
      providerCustomer.birthdate = birthdate;
    }
    if (whatsapp != null) {
      providerCustomer.whatsapp = whatsapp;
    }
    if (message != null) {
      providerCustomer.customMessage = message;
    }
    notifyListeners();
    return providerCustomer;
  }

  void removeCustomer(Customer customer) {
    _customersList.remove(customer);
    notifyListeners();
  }
}

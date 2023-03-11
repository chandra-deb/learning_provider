// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learning_provider/babies.dart';
import 'package:provider/provider.dart';

import 'dog.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog>(
          create: (context) => Dog(name: 'Dogy', breed: 'FulDog', age: 2),
        ),
        FutureProvider(
          create: (context) {
            final int dogAge = context.read<Dog>().age;
            final babies = Babies(age: dogAge);
            return babies.getBabies();
          },
          initialData: 0,
        ),
        StreamProvider<String>(
          create: (context) {
            final int dogAge = context.read<Dog>().age;
            final babies = Babies(age: dogAge * 2);
            return babies.bark();
          },
          initialData: 'Bark 0 times',
        )
      ],
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 4'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.select<Dog, String>((dog) => dog.name)),
            const SizedBox(),
            const BreedAndAge(),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Rebuilt BreedAndAge');
    return Column(
      children: [
        Text(context.select<Dog, String>((dog) => dog.breed)),
        const SizedBox(height: 10),
        const Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Age Rebuilt');
    return Column(
      children: [
        Text(context.select<Dog, int>((dog) => dog.age).toString()),
        Consumer<int>(
          builder: (context, intVal, child) {
            return Text(intVal.toString());
          },
        ),
        // (
        //   builder: (context) {
        //     return Text('Babies Age : ${context.watch<int>()}');
        //   }
        // ),
        ElevatedButton(
          onPressed: context.read<Dog>().grow,
          child: const Text('Increase'),
        ),
        Text(context.watch<String>())
      ],
    );
  }
}

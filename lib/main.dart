// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

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
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dog = Dog(name: 'Dog3', breed: 'breed3');

  @override
  void initState() {
    dog.addListener(dogListener);
    super.initState();
  }

  void dogListener() {
    setState(() {});
    log(dog.age.toString());
  }

  @override
  void dispose() {
    dog.removeListener(dogListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dog.name),
            const SizedBox(),
            BreedAndAge(dog: dog),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  final Dog dog;
  const BreedAndAge({
    Key? key,
    required this.dog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(dog.breed),
        const SizedBox(height: 10),
        Age(age: dog.age, ageIncreaser: dog.grow),
      ],
    );
  }
}

class Age extends StatelessWidget {
  final int age;
  final void Function() ageIncreaser;

  const Age({
    Key? key,
    required this.age,
    required this.ageIncreaser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(age.toString()),
        ElevatedButton(
          onPressed: ageIncreaser,
          child: const Text('Increase'),
        )
      ],
    );
  }
}

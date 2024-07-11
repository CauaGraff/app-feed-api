import 'package:flutter/material.dart';

class ESMenu extends StatelessWidget {
  const ESMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/clientes');
            },
            child: const Text('Clientes')),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/servicos');
            },
            child: const Text('Serviços')),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

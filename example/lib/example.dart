import 'package:flutter/material.dart';
import 'package:neumorphism_widgets/neumorphism_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeuAppBar(
        boxShadowColor: Colors.grey.shade50,
        title: Text(widget.title),
        bottom: TabBar(
          dividerColor:
              Colors.transparent, // Set to transparent to hide the divider
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Buttons'),
            Tab(text: 'Switches'),
            Tab(
              text: 'Sliders',
            ),
            Tab(text: 'Containers')
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Buttons(),
          Switches(),
          Sliders(),
          Containers(),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                style: TextStyle(fontWeight: FontWeight.bold), '    NeuButton'),
            Text(
                style: TextStyle(fontWeight: FontWeight.bold),
                '   NeuCheckbox'),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    NeuButton(
                      boxShadowColor: Colors.grey.shade50,
                      onPressed: (bool isPressed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Button pressed: $isPressed')));
                      },
                      child: const Text(' NeuButton '),
                    ),
                    NeuButton(
                      tapMode: TapMode.static,
                      boxShadowColor: Colors.grey.shade50,
                      onPressed: (bool isPressed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Button 2 pressed: $isPressed')));
                      },
                      child: const Text('  Static  '),
                    ),
                    NeuButton(
                      tapMode: TapMode.none,
                      boxShadowColor: Colors.grey.shade50,
                      onPressed: (bool isPressed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Button 2 pressed: $isPressed')));
                      },
                      child: const Text('  None  '),
                    ),
                    NeuButton(
                      enabled: false,
                      boxShadowColor: Colors.grey.shade50,
                      onPressed: (bool isPressed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Button 2 pressed: $isPressed')));
                      },
                      child: const Text('  Disables  '),
                    ),
                  ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeuCheckbox(
                    boxShadowColor: Colors.grey.shade50,
                  ),
                  NeuCheckbox(
                    tapMode: TapMode.static,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.red,
                    boxShadowColor: Colors.grey.shade50,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class Switches extends StatefulWidget {
  const Switches({super.key});

  @override
  State<Switches> createState() => _SwitchesState();
}

class _SwitchesState extends State<Switches> {
  bool _isSwitched = false;
  bool _isSwitched2 = false;
  bool _isSwitched3 = false;
  bool _isSwitched4 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Normal: $_isSwitched'),
        const SizedBox(height: 20),
        NeuSwitch(
          boxShadowColor: Colors.grey.shade50,
          onChanged: (bool value) {
            setState(() {
              _isSwitched = value;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Switch state: $_isSwitched')));
          },
          value: _isSwitched,
        ),
        const SizedBox(height: 80),
        Text('Colored: $_isSwitched2'),
        const SizedBox(height: 20),
        NeuSwitch(
          activeColor: Colors.blue,
          inactiveColor: Colors.red,
          boxShadowColor: Colors.grey.shade50,
          onChanged: (bool value) {
            setState(() {
              _isSwitched2 = value;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Switch state: $_isSwitched2')));
          },
          value: _isSwitched2,
        ),
        const SizedBox(height: 80),
        Text('Vertical: $_isSwitched3'),
        const SizedBox(height: 20),
        NeuSwitch(
          vertical: true,
          boxShadowColor: Colors.grey.shade50,
          onChanged: (bool value) {
            setState(() {
              _isSwitched3 = value;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Switch state: $_isSwitched3')));
          },
          value: _isSwitched3,
        ),
        const SizedBox(height: 80),
        Text('Disabled: $_isSwitched4'),
        const SizedBox(height: 20),
        NeuSwitch(
          enabled: false,
          boxShadowColor: Colors.grey.shade50,
          onChanged: (bool value) {
            setState(() {
              _isSwitched4 = value;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Switch state: $_isSwitched4')));
          },
          value: _isSwitched4,
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class Sliders extends StatefulWidget {
  const Sliders({super.key});

  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Normal'),
        const SizedBox(height: 20),
        NeuSlider(boxShadowColor: Colors.grey.shade50, onChanged: (value) {}),
        const SizedBox(height: 80),
        const Text('Colored'),
        const SizedBox(height: 20),
        NeuSlider(
            boxShadowColor: Colors.grey.shade50,
            color: Colors.red,
            handleColor: Colors.blue,
            onChanged: (value) {}),
        const SizedBox(height: 80),
        const Text('Vertical'),
        const SizedBox(height: 20),
        NeuSlider(
            boxShadowColor: Colors.grey.shade50,
            vertical: true,
            onChanged: (value) {}),
        const SizedBox(height: 80),
        const Text('Disabled'),
        const SizedBox(height: 20),
        NeuSlider(
            boxShadowColor: Colors.grey.shade50,
            enabled: false,
            onChanged: (value) {}),
        const SizedBox(height: 80),
      ],
    );
  }
}

class Containers extends StatelessWidget {
  const Containers({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NeuContainer(
            boxShadowColor: Colors.grey.shade50,
            child: const SizedBox(
                width: 200, height: 200, child: Center(child: Text('Square')))),
        NeuContainer(
            inset: true,
            shape: BoxShape.circle,
            boxShadowColor: Colors.grey.shade50,
            child: const SizedBox(
              width: 200,
              height: 200,
              child: Center(child: Text('Inset Circle')),
            )),
      ],
    );
  }
}

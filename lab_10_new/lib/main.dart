import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MainScreen(
        isDarkMode: isDarkMode,
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const MainScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Assignments'),
        elevation: 0,
        actions: [
          Row(
            children: [
              Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode, size: 20),
              Switch(value: isDarkMode, onChanged: (value) => onThemeToggle()),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Assignment 1: Understanding Widgets
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitle(
                    text: '1. Understanding Widgets',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildColorBox(Colors.red, 'Red'),
                            _buildColorBox(Colors.green, 'Green'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildColorBox(Colors.blue, 'Blue'),
                            _buildColorBox(Colors.orange, 'Orange'),
                            _buildColorBox(Colors.purple, 'Purple'),
                            _buildColorBox(Colors.teal, 'Teal'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Assignment 2 & 3: Custom Widgets
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTitle(
                    text: '2 & 3. Custom Widgets',
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  CustomTitle(text: 'Stateless Widget', color: Colors.purple),
                  const SizedBox(height: 16),
                  const CustomCounter(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Assignment 4: Combining Widgets
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    CustomTitle(
                      text: '4. Combined Widgets',
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    const CustomCounter(),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Assignment 5: AnimatedContainer
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTitle(text: '5. AnimatedContainer', color: Colors.pink),
                  const SizedBox(height: 16),
                  const AnimatedContainerDemo(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Assignment 6: Explicit Animation
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTitle(
                    text: '6. Explicit Animation',
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 16),
                  const ExplicitAnimationDemo(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Assignment 7: GestureDetector
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTitle(text: '7. GestureDetector', color: Colors.teal),
                  const SizedBox(height: 16),
                  const GestureDemo(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Assignment 9: AnimatedList
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomTitle(
                    text: '9. AnimatedList',
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(height: 16),
                  const AnimatedListDemo(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Assignment 10: Mini Project
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MiniProjectScreen(),
                ),
              );
            },
            icon: const Icon(Icons.rocket_launch),
            label: const Text('10. Open Mini Project'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorBox(Color color, String label) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Assignment 2: Custom Stateless Widget
class CustomTitle extends StatelessWidget {
  final String text;
  final Color color;

  const CustomTitle({Key? key, required this.text, required this.color})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
    );
  }
}

// Assignment 3: Custom Stateful Widget
class CustomCounter extends StatefulWidget {
  const CustomCounter({Key? key}) : super(key: key);

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                counter--;
              });
            },
            icon: const Icon(Icons.remove_circle),
            iconSize: 40,
            color: Colors.red,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$counter',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            icon: const Icon(Icons.add_circle),
            iconSize: 40,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

// Assignment 5: AnimatedContainer
class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  bool isExpanded = false;
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];
  int colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          colorIndex = (colorIndex + 1) % colors.length;
        });
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: isExpanded ? 200 : 100,
          height: isExpanded ? 200 : 100,
          decoration: BoxDecoration(
            color: colors[colorIndex],
            borderRadius: BorderRadius.circular(isExpanded ? 100 : 20),
            boxShadow: [
              BoxShadow(
                color: colors[colorIndex].withOpacity(0.5),
                blurRadius: isExpanded ? 20 : 10,
                spreadRadius: isExpanded ? 5 : 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Tap Me',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isExpanded ? 24 : 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Assignment 6: Explicit Animation
class ExplicitAnimationDemo extends StatefulWidget {
  const ExplicitAnimationDemo({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimationDemo> createState() => _ExplicitAnimationDemoState();
}

class _ExplicitAnimationDemoState extends State<ExplicitAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animation.value, 0),
                child: const FlutterLogo(size: 60),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          icon: const Icon(Icons.play_arrow),
          label: const Text('Animate'),
        ),
      ],
    );
  }
}

// Assignment 7: GestureDetector
class GestureDemo extends StatefulWidget {
  const GestureDemo({Key? key}) : super(key: key);

  @override
  State<GestureDemo> createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo> {
  Color bgColor = Colors.grey;
  String gesture = 'Tap me!';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          bgColor = Colors.blue;
          gesture = 'Single Tap';
        });
      },
      onDoubleTap: () {
        setState(() {
          bgColor = Colors.green;
          gesture = 'Double Tap';
        });
      },
      onLongPress: () {
        setState(() {
          bgColor = Colors.red;
          gesture = 'Long Press';
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 150,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            gesture,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Assignment 9: AnimatedList
class AnimatedListDemo extends StatefulWidget {
  const AnimatedListDemo({Key? key}) : super(key: key);

  @override
  State<AnimatedListDemo> createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items = [];
  int _counter = 0;

  void _addItem() {
    _items.insert(0, _counter++);
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _addItem,
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(_items[index], animation);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem(int item, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOut)),
      ),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(child: Text('${item + 1}')),
          title: Text('Item ${item + 1}'),
          trailing: const Icon(Icons.star, color: Colors.amber),
        ),
      ),
    );
  }
}

// Assignment 10: Mini Project - Themed Interactive UI
class MiniProjectScreen extends StatefulWidget {
  const MiniProjectScreen({Key? key}) : super(key: key);

  @override
  State<MiniProjectScreen> createState() => _MiniProjectScreenState();
}

class _MiniProjectScreenState extends State<MiniProjectScreen> {
  bool isExpanded = false;
  int likes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Dashboard'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTitle(
              text: '🚀 Welcome!',
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),

            // Interactive Card with Gesture
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                height: isExpanded ? 300 : 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(isExpanded ? 30 : 20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: isExpanded ? 30 : 15,
                      spreadRadius: isExpanded ? 5 : 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        size: isExpanded ? 80 : 50,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isExpanded ? 'Tap to collapse' : 'Tap to expand',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isExpanded ? 24 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Counter Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomTitle(
                      text: 'Activity Counter',
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 16),
                    const CustomCounter(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Like Button with Animation
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CustomTitle(text: 'Like This?', color: Colors.pink),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          likes++;
                        });
                      },
                      child: AnimatedScale(
                        scale: likes > 0 ? 1.0 : 0.9,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            likes > 0 ? Icons.favorite : Icons.favorite_border,
                            size: 60,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$likes Likes',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

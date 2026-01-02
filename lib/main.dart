import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _mode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Raghav Portfolio",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _mode,
      home: PortfolioHome(toggleTheme: toggleTheme),
    );
  }
}

class PortfolioHome extends StatelessWidget {
  final VoidCallback toggleTheme;

  const PortfolioHome({super.key, required this.toggleTheme});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0, bottom: 6),
      child: Text(title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  Widget skillChip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.black,
      labelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget expTile(String title, String subtitle, String date) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle)]),
          Text(date)
        ],
      ),
    );
  }

  Widget projectCard(String title, String description, List<String> tags) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(description),
          const SizedBox(height: 8),
          Wrap(spacing: 6, children: tags.map((e) => Chip(label: Text(e))).toList())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HERO
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hi, I'm Raghav",
                            style: TextStyle(
                                fontSize: 44, fontWeight: FontWeight.bold)),
                        SizedBox(height: 6),
                        SizedBox(
                          width: 500,
                          child: Text(
                              "Building intelligent apps and scalable backend systems."),
                        )
                      ],
                    ),
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage("https://via.placeholder.com/140"),
                    )
                  ],
                ),

                sectionTitle("About"),
                const Text(
                    "Full-stack developer passionate about AI, backend systems, scalable APIs, and Flutter applications. Experienced in Flask, Node.js, Firebase and ML workflows."),

                sectionTitle("Work Experience"),
                expTile("Quadrant Digital Solutions", "Full Stack Developer",
                    "Apr 2024 – Present"),
                expTile("Bookzy Edufy Pvt Ltd", "Python Backend Developer",
                    "Nov 2023 – Feb 2024"),

                sectionTitle("Skills"),
                Wrap(
                  spacing: 8,
                  children: [
                    "Python",
                    "Flask",
                    "Django",
                    "Node.js",
                    "React",
                    "Flutter",
                    "Firebase",
                    "FastAPI",
                    "REST APIs",
                    "JWT",
                    "MoviePy",
                    "FFmpeg"
                  ].map(skillChip).toList(),
                ),

                const SizedBox(height: 10),
                Center(
                    child: FilledButton(
                        onPressed: () {},
                        child: const Text("My Projects"))),

                sectionTitle("Projects"),

                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    projectCard("Smart Story Teller",
                        "AI storytelling with TTS and video generation", [
                      "Python",
                      "Pollination AI ( Open Source AI)",
                      "Flask",
                      "MoviePy"
                    ]),
                    projectCard("Flask Backend System",
                        "Auth, contests, Firebase secure APIs", [
                      "Flask",
                      "JWT",
                      "Firebase"
                    ]),
                    projectCard("Medical Learning App",
                        "Flutter UI + Firebase backend", [
                      "Flutter",
                      "Dart",
                      "Firebase"
                    ]),
                  ],
                ),

                sectionTitle("Education"),
                expTile("Indian Institure of Technolgy Ropar", "Diploma Degree (Artificial Intelligence )",
                    "2024 – 2025"),
                expTile("Arya College of Engineering & IT", "B.Tech (ECE)",
                    "2019 – 2023"),

                sectionTitle("Get in Touch"),
                const Text(
                    "Email: raghavarora1163@gmail.com\nPhone: +91 8955013675"),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),

      // floating bottom navigation bar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.grey.withOpacity(.2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.dataset_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.link)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
            IconButton(
                onPressed: toggleTheme,
                icon: const Icon(Icons.dark_mode_outlined)),
          ],
        ),
      ),
    );
  }
}

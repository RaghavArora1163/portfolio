import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      title: "Raghav Arora Portfolio",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: _mode,
      home: PortfolioHome(toggleTheme: toggleTheme),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  final VoidCallback toggleTheme;

  const PortfolioHome({super.key, required this.toggleTheme});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
        ..forward();

  late final AnimationController _slideController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
        ..forward();

  final ScrollController _scroll = ScrollController();

  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 600),
    );
  }

  /// open external links
  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: const Text("Mr. Raghav Arora Portfolio"),
              actions: [
                IconButton(
                  onPressed: widget.toggleTheme,
                  icon: const Icon(Icons.dark_mode_outlined),
                )
              ],
            )
          : null,

      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  const DrawerHeader(
                    child: Text("Navigation",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  ListTile(title: const Text("About"), onTap: () => scrollTo(aboutKey)),
                  ListTile(title: const Text("Skills"), onTap: () => scrollTo(skillsKey)),
                  ListTile(title: const Text("Projects"), onTap: () => scrollTo(projectsKey)),
                  ListTile(title: const Text("Contact"), onTap: () => scrollTo(contactKey)),
                ],
              ),
            )
          : null,

      body: Row(
        children: [
          /// ⛓️ SIDEBAR WITH SOCIAL ICONS ONLY (DESKTOP)
          if (!isMobile)
            NavigationRail(
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.code),
                  label: Text("LeetCode"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.linked_camera_outlined),
                  label: Text("LinkedIn"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.account_circle),
                  label: Text("GitHub"),
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (i) {
                if (i == 0) openLink("https://leetcode.com/u/raghavarora1163/");
                if (i == 1) openLink("https://www.linkedin.com/in/raghav-arora-b06534210/");
                if (i == 2) openLink("https://github.com/RaghavArora1163");
              },
            ),

          Expanded(
            child: SingleChildScrollView(
              controller: _scroll,
              padding: const EdgeInsets.all(18),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 950),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _fadeController,
                      child: SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(0, .2), end: Offset.zero)
                            .animate(_slideController),
                        child: LayoutBuilder(
                          builder: (context, c) {
                            final mobile = c.maxWidth < 700;

                            return mobile
                                ? Column(
                                    children: const [
                                      CircleAvatar(
                                          radius: 60,
                                          backgroundImage: NetworkImage(
                                              "https://via.placeholder.com/140")),
                                      SizedBox(height: 12),
                                      Text("Hi, I'm Raghav Arora 👋",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 6),
                                      Text(
                                        "Building intelligent apps and scalable backend systems with Flutter and flask with degree in artificial intelligence from IIT Ropar.",
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Hi, I'm Raghav Arora 👋",
                                              style: TextStyle(
                                                  fontSize: 44,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 8),
                                          SizedBox(
                                              width: 500,
                                              child: Text(
                                                  "Building intelligent apps and scalable backend systems."))
                                        ],
                                      ),
                                      CircleAvatar(
                                          radius: 60,
                                          backgroundImage: NetworkImage(
                                              "https://via.placeholder.com/140"))
                                    ],
                                  );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    sectionTitle("About", aboutKey),
                    animatedText(
                        "Full-stack developer passionate about AI, backend systems, scalable APIs, and Flutter applications."),

                    sectionTitle("Skills", skillsKey),
                    animatedWrap([
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
                      "AI/ML Integration"
                    ]),

                    sectionTitle("Projects", projectsKey),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int count = 2;
                        if (constraints.maxWidth < 600) count = 1;
                        if (constraints.maxWidth > 1100) count = 3;

                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: count,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            mainAxisExtent: 170,
                          ),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return projectCard(
                                "Smart Story Teller",
                                "AI storytelling with TTS and video generation",
                                ["Python", "Flask", "MoviePy"],
                              );
                            } else if (index == 1) {
                              return projectCard(
                                "Flask Backend System",
                                "Auth, contests, Firebase secure APIs",
                                ["Flask", "JWT", "Firebase"],
                              );
                            } else {
                              return projectCard(
                                "Medical Learning App",
                                "Flutter UI + Firebase backend",
                                ["Flutter", "Dart", "Firebase"],
                              );
                            }
                          },
                        );
                      },
                    ),

                    sectionTitle("Get in Touch", contactKey),
                    animatedText(
                        "Email: raghavarora1163@gmail.com\nPhone: +91 8955013675"),

                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, Key key) {
    return Padding(
      key: key,
      padding: const EdgeInsets.only(top: 35, bottom: 6),
      child: Text(title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  Widget animatedText(String text) {
    return AnimatedOpacity(
      opacity: 1,
      duration: const Duration(milliseconds: 900),
      child: Text(text),
    );
  }

  Widget animatedWrap(List<String> list) {
    return Wrap(
      spacing: 8,
      children: list
          .map((e) => Chip(
                label: Text(e),
                backgroundColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.white),
              ))
          .toList(),
    );
  }

  Widget projectCard(String title, String desc, List<String> tags) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey.withOpacity(.12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(desc),
          const SizedBox(height: 6),
          Wrap(
              spacing: 5,
              children: tags.map((t) => Chip(label: Text(t))).toList())
        ],
      ),
    );
  }
}

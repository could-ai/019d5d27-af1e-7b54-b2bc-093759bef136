import 'package:flutter/material.dart';

void main() {
  runApp(const BusinessPresentationApp());
}

class BusinessPresentationApp extends StatelessWidget {
  const BusinessPresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Presentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Professional dark blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final String content;
  final IconData icon;
  final Color color;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.icon,
    required this.color,
  });
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: 'The Future of Business',
      subtitle: 'Adapting to a Changing World',
      content: 'Welcome to our annual business overview. Today we will discuss our strategic vision, market opportunities, and financial health in an ever-evolving global landscape.',
      icon: Icons.business_center,
      color: const Color(0xFF1E3A8A),
    ),
    SlideData(
      title: 'Strategic Planning',
      subtitle: 'Vision & Execution',
      content: '• Define clear, actionable goals\n• Mobilize resources efficiently\n• Foster a culture of continuous innovation\n• Monitor KPIs and adapt swiftly',
      icon: Icons.insights,
      color: const Color(0xFF047857),
    ),
    SlideData(
      title: 'Marketing & Growth',
      subtitle: 'Expanding Our Reach',
      content: '• Customer-centric product development\n• Data-driven digital marketing campaigns\n• Building strong brand loyalty\n• Exploring emerging international markets',
      icon: Icons.campaign,
      color: const Color(0xFFB45309),
    ),
    SlideData(
      title: 'Financial Health',
      subtitle: 'Sustainable Profitability',
      content: '• Robust cash flow management\n• Strategic investments in R&D\n• Cost optimization across supply chains\n• Delivering consistent shareholder value',
      icon: Icons.attach_money,
      color: const Color(0xFF4338CA),
    ),
    SlideData(
      title: 'Conclusion',
      subtitle: 'Moving Forward Together',
      content: 'Resilience and innovation are the keys to our long-term success. Thank you for your continued dedication and partnership as we build the future.',
      icon: Icons.lightbulb,
      color: const Color(0xFFBE123C),
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentPage + 1) / _slides.length,
              backgroundColor: Colors.grey[300],
              color: _slides[_currentPage].color,
              minHeight: 6,
            ),
            
            // Slide Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return _buildSlide(_slides[index]);
                },
              ),
            ),
            
            // Bottom Navigation Controls
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  TextButton.icon(
                    onPressed: _currentPage == 0 ? null : _previousPage,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      disabledForegroundColor: Colors.grey[400],
                    ),
                  ),
                  
                  // Page Indicator
                  Row(
                    children: List.generate(
                      _slides.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentPage == index ? 12.0 : 8.0,
                        height: _currentPage == index ? 12.0 : 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? _slides[_currentPage].color
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  
                  // Next Button
                  ElevatedButton.icon(
                    onPressed: _currentPage == _slides.length - 1 ? null : _nextPage,
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(_currentPage == _slides.length - 1 ? 'Finish' : 'Next'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _slides[_currentPage].color,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      disabledForegroundColor: Colors.grey[500],
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(SlideData slide) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Card(
            elevation: 8,
            shadowColor: slide.color.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: slide.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      slide.icon,
                      size: 80,
                      color: slide.color,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    slide.title,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    slide.subtitle,
                    style: TextStyle(
                      fontSize: 22,
                      color: slide.color,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    slide.content,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: slide.content.contains('•') ? TextAlign.left : TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

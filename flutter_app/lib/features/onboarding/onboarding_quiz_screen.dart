import 'package:flutter/material.dart';

class OnboardingQuizScreen extends StatefulWidget {
  const OnboardingQuizScreen({super.key});

  @override
  State<OnboardingQuizScreen> createState() => _OnboardingQuizScreenState();
}

class _OnboardingQuizScreenState extends State<OnboardingQuizScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Quiz responses
  String? _travelType;
  String? _budgetRange;
  String? _travelPace;
  List<String> _interests = [];
  String? _foodPreference;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Who are you traveling with?',
      'type': 'single',
      'options': ['Solo', 'Couple', 'Family', 'Friends'],
      'values': ['solo', 'couple', 'family', 'friends'],
    },
    {
      'question': 'What\'s your budget range?',
      'type': 'single',
      'options': ['Budget', 'Mid-range', 'Luxury'],
      'values': ['budget', 'mid-range', 'luxury'],
    },
    {
      'question': 'How do you like to travel?',
      'type': 'single',
      'options': ['Relaxed', 'Balanced', 'Packed'],
      'values': ['relaxed', 'balanced', 'packed'],
    },
    {
      'question': 'What interests you? (Select all that apply)',
      'type': 'multiple',
      'options': ['Nature', 'Culture', 'Food', 'Adventure'],
      'values': ['nature', 'culture', 'food', 'adventure'],
    },
    {
      'question': 'Food preference?',
      'type': 'single',
      'options': ['Vegetarian', 'Non-vegetarian', 'Mixed'],
      'values': ['veg', 'non-veg', 'mixed'],
    },
  ];

  void _nextPage() {
    if (_currentPage < _questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Complete quiz
      _completeQuiz();
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

  void _completeQuiz() {
    // Save preferences and navigate to dashboard
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences saved!')),
    );
    // Navigate to dashboard
  }

  bool _canProceed() {
    switch (_currentPage) {
      case 0:
        return _travelType != null;
      case 1:
        return _budgetRange != null;
      case 2:
        return _travelPace != null;
      case 3:
        return _interests.isNotEmpty;
      case 4:
        return _foodPreference != null;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentPage + 1) / _questions.length,
              backgroundColor: Colors.grey[300],
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestionPage(_questions[index], index);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousPage,
                        child: const Text('Back'),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _canProceed() ? _nextPage : null,
                      child: Text(_currentPage == _questions.length - 1 ? 'Complete' : 'Next'),
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

  Widget _buildQuestionPage(Map<String, dynamic> question, int index) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question['question'],
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          if (question['type'] == 'single')
            ..._buildSingleChoiceOptions(question['options'], question['values'], index)
          else
            ..._buildMultipleChoiceOptions(question['options'], question['values']),
        ],
      ),
    );
  }

  List<Widget> _buildSingleChoiceOptions(List<String> options, List<String> values, int questionIndex) {
    return options.map((option) {
      final value = values[options.indexOf(option)];
      final isSelected = _getCurrentValue(questionIndex) == value;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          child: InkWell(
            onTap: () => _setValue(questionIndex, value),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: isSelected ? Theme.of(context).colorScheme.primary : null,
                  ),
                  const SizedBox(width: 16),
                  Text(option, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildMultipleChoiceOptions(List<String> options, List<String> values) {
    return options.map((option) {
      final value = values[options.indexOf(option)];
      final isSelected = _interests.contains(value);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          child: InkWell(
            onTap: () => _toggleInterest(value),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                    color: isSelected ? Theme.of(context).colorScheme.primary : null,
                  ),
                  const SizedBox(width: 16),
                  Text(option, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  String? _getCurrentValue(int questionIndex) {
    switch (questionIndex) {
      case 0:
        return _travelType;
      case 1:
        return _budgetRange;
      case 2:
        return _travelPace;
      case 4:
        return _foodPreference;
      default:
        return null;
    }
  }

  void _setValue(int questionIndex, String value) {
    setState(() {
      switch (questionIndex) {
        case 0:
          _travelType = value;
          break;
        case 1:
          _budgetRange = value;
          break;
        case 2:
          _travelPace = value;
          break;
        case 4:
          _foodPreference = value;
          break;
      }
    });
  }

  void _toggleInterest(String value) {
    setState(() {
      if (_interests.contains(value)) {
        _interests.remove(value);
      } else {
        _interests.add(value);
      }
    });
  }
}
import 'package:basketball_counter_app/constant/colors.dart';
import 'package:basketball_counter_app/cubits/countir_cubit.dart';
import 'package:basketball_counter_app/cubits/countir_state.dart';
import 'package:basketball_counter_app/utils/vertical_devider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Points Counter',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize + 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<CounterCubit>().showHistory(context),
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<CounterCubit, CounterState>(
                      builder: (context, state) => buildTeamSection(
                        size,
                        context.read<CounterCubit>().teamAName,
                        context.read<CounterCubit>().teamAScore,
                        context,
                      ),
                    ),
                    CustomVerticalDevider(height: size.height * 0.5),
                    BlocBuilder<CounterCubit, CounterState>(
                      builder: (context, state) => buildTeamSection(
                        size,
                        context.read<CounterCubit>().teamBName,
                        context.read<CounterCubit>().teamBScore,
                        context,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                buildResetButton(size, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTeamSection(
    Size size,
    String teamName,
    int score,
    BuildContext context,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              teamName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () =>
                  context.read<CounterCubit>().editTeamName(context, teamName),
              child: Icon(
                Icons.edit,
                color: Colors.black12,
                size: size.width * 0.05,
              ),
            ),
          ],
        ),
        Text(
          '$score',
          style: TextStyle(
            fontSize: size.width * 0.25,
            fontWeight: FontWeight.bold,
            color: scoreTextColor,
          ),
        ),
        Column(
          children: [
            buildPointControl(size, '1 Point', teamName, 1, context),
            SizedBox(height: size.height * 0.02),
            buildPointControl(size, '2 Points', teamName, 2, context),
            SizedBox(height: size.height * 0.02),
            buildPointControl(size, '3 Points', teamName, 3, context),
          ],
        ),
      ],
    );
  }

  Widget buildPointControl(
    Size size,
    String title,
    String team,
    int points,
    BuildContext context,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.035,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () =>
                    context.read<CounterCubit>().addScore(team, points),
                icon: Icon(
                  Icons.add_circle,
                  color: addIconColor,
                  size: size.width * 0.08,
                ),
              ),
              CustomVerticalDevider(height: size.height * 0.03),
              IconButton(
                onPressed: () =>
                    context.read<CounterCubit>().minusScore(team, -points),
                icon: Icon(
                  Icons.remove_circle,
                  color: removeIconColor,
                  size: size.width * 0.08,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildResetButton(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CounterCubit>().resetScores(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Reset Scores",
          style: TextStyle(
            color: buttonTextColor,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.045,
          ),
        ),
      ),
    );
  }
}

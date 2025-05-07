import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGirdItem extends StatelessWidget {
  const CategoryGirdItem(this.category, {required this.onItemClicked, super.key});

  final Category category;
  final void Function() onItemClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemClicked,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withValues(alpha: 0.55),
              category.color.withValues(alpha: 0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

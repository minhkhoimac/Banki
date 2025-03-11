# Banki
Flashcards study app with spaced repetition

## Description

The Flashcard App is designed to help users study and retain information efficiently by using flashcards. The app enables users to create decks of flashcards, each with a question and answer, and track their progress as they study. It features an intuitive interface, offering an easy way to study and review material by swiping through cards. Users can mark cards as "correct" or "incorrect" to adjust the order in which they appear based on their proficiency. The app helps learners retain knowledge by adapting the order of cards according to their recall accuracy.

### Key Features

- **Deck Creation**: Create, edit, and delete custom flashcard decks.
- **Study Mode**: Swipe to mark flashcards as “knew” (correct) or “did not know” (incorrect), adjusting their display order accordingly.
- **Customizable deck colors**: Color coding each deck for user association
- **Progress tracking**: Tracking amount of successful recalls
- **Dark mode**: Supports dark mode
- **Splash screen**: Splash screen on first launch
- **Rate alert**: Alert to rate app on 3rd launch (alert appears, but no real functionality as the app is not going in the App Store)



## Key words:
Flashcards, Study, Learn, Education, Memory, Knowledge, Review, Study App, Educational Tools

## Age group:
4+ (Suitable for all ages)

## App Store category:
Education

## Executive summary
This app is motivated because the current most popular flashcard study app that uses spaced repetition, Anki, has an expensive mobile app of $20 in the App Store. This app is a much simpler version of Anki that is free for all users. The app can become a personalized learning tool aimed at improving study efficiency. The app allows users to create and manage decks of flashcards, track their progress, and adapt their study sessions based on their performance. The app fits into the App Store landscape by addressing the need for a FREE Anki-like app that is very simple to use, as Anki can get very complex sometimes with the amount of data presented to the user about their decks.

The app helps users of all ages and educational levels, from students to professionals, to study effectively using flashcards. This applies to medical students to language learners. 

From a technical standpoint, Banki utilizes UserDefaults to store data locally and act as a context/ground truth for the application. This works for this simple implementation, but as the app scales up- and outward, a different implementation might be necessary to handle more card data. It comprises of a TabView with three tabs: a DecksView, StudyView, and UserView. DecksView allows users to add, delete, or modify decks (by adding or removing cards), StudyView allows users to study a given deck (chosen in UserView) by swiping left or right for each card, and UserView allows for change switch between dark and light mode and choose the deck they would like to study.
 





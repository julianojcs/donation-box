# donation-box
An iOS app developed with swift language where users will list or search for toys to donate!!!

### Developed by:
- **Name**: Juliano Costa Silva
- **Course**: Mobile Development 
- **Subject**: Native Development for iOS

Now that we've learned how to work with apps that use data persisted in the cloud, let's put this knowledge to work by creating a collaborative toy donation app.
As we were all children at one time, it is very likely that we have a toy at home that we no longer use. Or else we have access to children (younger brothers/sisters, cousins ​​or even sons and daughters) who have in their closet some toys that are no longer part of their day-to-day play. Wouldn't it be great if there was a way to promote these toys so that children in need or from more humble families could have access to these toys? That's exactly what we're going to build, an app where users will list or search for toys to donate!!!

## The application should work as follows:

1) The application will have 2 screens: Toy Listing, Registration/Change;

2) The initial screen will be the Toy Listing screen, a TableViewController where all the toys available in the application will be listed. In this list should appear the name of the toy and the state of conservation (New, Used, Needs repair);

3) Navigation between screens will be done via NavigationController;

4) From the initial screen, the user will be able to register a new toy (by clicking on any button present) or select one of the toys listed;

5) He can also delete a toy using the Swipe gesture;

6) When selecting a toy, it will be taken to the Registration/Change screen, where all its data will be presented, which are:

    * toy name
    * Status (segmented control with 3 states)
    * donor name
    * Address
    * Telephone

    Below is an example:

    > **Name**: Toy name: Mermaid Barbie
    **Status**: Used
    **Donor name**: Joaquim de Oliveira
    **Address**: Avenida Lins de Vasconcelos, 5000
    **Phone**: (00) 0000-0000

7) From this screen, he can return to the List screen or change the toy's data;

8) The Edit/Create screen will be used both for editing a new record (changing its data) and for creating a new one. If it is accessed from the crafting button on the Toy Listing screen, it will enter "Crafting" mode;

9) Data must be stored using Cloud Firestore;

10) All application interface (UI) definition will be up to the student.

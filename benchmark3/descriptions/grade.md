There is a set of people named "Person". "Person" is partitioned into the subsets "Student" and "Professor", and every "Student" and every "Professor" is a "Person".

There is a set named "Class". Each "Class" has an "assistant_for" relation to a set of "Student" elements. A class may have any number of students in "assistant_for", including none. Each "Class" has an "instructor_of" relation to exactly one "Professor".

There is a set named "Assignment". Each "Assignment" has an "associated_with" relation to exactly one "Class". Each "Assignment" has an "assigned_to" relation to one or more "Student" elements.

There is a named condition called "PolicyAllowsGrading" that applies to a "Person" and an "Assignment". "PolicyAllowsGrading" holds exactly when that person is either one of the students in the "assistant_for" relation of the class in the assignment’s "associated_with" relation, or the professor in the "instructor_of" relation of that same class.

There is a global rule named "NoOneCanGradeTheirOwnAssignment". For every "Person" and every "Assignment", if "PolicyAllowsGrading" holds for that person and that assignment, then that person is not one of the students in the assignment’s "assigned_to" relation.
This model describes objects called "Listings", which have two special kinds: "Address" and "Name". 

There are also objects called "Books". Each Book has a set of Names associated with it, represented by the field "entry". Furthermore, each Book is associated with a set of Listings through an association represented by the field "listed". The "listed" association is not direct, but rather between each Name in a Book's "entry" and a set of Listings. 

There is a function called "lookup" which takes a Book and a Name as inputs. It takes the transitive closure of the "listed" relation starting from a given Name in the context of a given Book. The result is a set of Listings. 

There are also three constraints for these objects:

- For every Book, each Name in the Book's "entry" is associated with at most one Listing in the Book's "listed" relation. 
- If a Name appears in the result of a "lookup" function for a given Book and Name, then this Name must also be in the Book's "entry" set. 
- No Name in a Book's "entry" set can appear in the result of the "lookup" operation with the same Book and Name as inputs.
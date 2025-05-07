
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import mysql.connector

app = FastAPI()

# Database connection setup
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="your_password",
        database="library_db"
    )

# Pydantic model
class Book(BaseModel):
    title: str
    author_id: int
    category_id: int
    isbn: str
    available_copies: int

# CREATE
@app.post("/books/")
def create_book(book: Book):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO books (title, author_id, category_id, isbn, available_copies) "
        "VALUES (%s, %s, %s, %s, %s)",
        (book.title, book.author_id, book.category_id, book.isbn, book.available_copies)
    )
    conn.commit()
    conn.close()
    return {"message": "Book added successfully"}

# READ
@app.get("/books/")
def get_books():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM books")
    books = cursor.fetchall()
    conn.close()
    return books

# UPDATE
@app.put("/books/{book_id}")
def update_book(book_id: int, book: Book):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE books SET title=%s, author_id=%s, category_id=%s, isbn=%s, available_copies=%s "
        "WHERE book_id=%s",
        (book.title, book.author_id, book.category_id, book.isbn, book.available_copies, book_id)
    )
    conn.commit()
    conn.close()
    return {"message": "Book updated successfully"}

# DELETE
@app.delete("/books/{book_id}")
def delete_book(book_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM books WHERE book_id=%s", (book_id,))
    conn.commit()
    conn.close()
    return {"message": "Book deleted successfully"}

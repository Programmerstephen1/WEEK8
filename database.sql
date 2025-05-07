
-- Create Authors Table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create Categories Table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Create Books Table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author_id INT NOT NULL,
    category_id INT NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    available_copies INT DEFAULT 0,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create Members Table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

-- Create Borrowed Books Table
CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Insert Authors
INSERT INTO authors (name) VALUES
('George Orwell'), ('J.K. Rowling'), ('Chinua Achebe');

-- Insert Categories
INSERT INTO categories (name) VALUES
('Fiction'), ('Fantasy'), ('Classic');

-- Insert Books
INSERT INTO books (title, author_id, category_id, isbn, available_copies) VALUES
('1984', 1, 1, '9780451524935', 5),
('Harry Potter and the Sorcerer''s Stone', 2, 2, '9780439708180', 3),
('Things Fall Apart', 3, 3, '9780385474542', 4);

-- Insert Members
INSERT INTO members (name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '1234567890'),
('Bob Smith', 'bob@example.com', '0987654321');

-- Insert Borrowed Books
INSERT INTO borrowed_books (book_id, member_id, borrow_date, return_date) VALUES
(1, 1, '2024-04-01', '2024-04-15'),
(2, 2, '2024-04-03', NULL);

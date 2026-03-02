import 'package:bookly_app/Core/errors/failures.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<BooksModel>>> fetchSearchBooks({
    required String bookName,
  });
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yad_sys/models/cart_model.dart';

class CartDatabase {
  static const _dbFileName = 'YademanSystem.db';
  static const _dbVersion = 1;

  static final CartDatabase instance = CartDatabase._init();

  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbFileName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE IF NOT EXISTS $tableCart('
        '${CartFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${CartFields.productId} INTEGER NOT NULL,'
        '${CartFields.productImage} TEXT NOT NULL,'
        '${CartFields.productName} TEXT NOT NULL,'
        '${CartFields.productPrice} INTEGER NOT NULL,'
        '${CartFields.productQuantity} INTEGER NOT NULL,'
        '${CartFields.productTotalPrice} INTEGER NOT NULL)');
  }

  Future<Cart> insert(Cart cart) async {
    final db = await instance.database;
    final id = await db.insert(tableCart, cart.toJson());
    return cart.copy(id: id);
  }

  Future readCart(int productId) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCart,
      columns: CartFields.values,
      where: "${CartFields.productId} = ?",
      whereArgs: [productId],
    );

    if (maps.isNotEmpty) {
      return Cart.fromJson(maps.first);
    } else {
      print('ID $productId not found');
      return false;
    }
  }

  Future<List<Cart>> readAllCart() async {
    final db = await instance.database;

    final result = await db.query(
      tableCart,
      orderBy: '${CartFields.id} ASC',
    );

    return result.map((json) => Cart.fromJson(json)).toList();
  }

  Future<int> update(Cart cart) async {
    final db = await instance.database;

    return db.update(
      tableCart,
      cart.toJson(),
      where: '${CartFields.id} = ?',
      whereArgs: [cart.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      tableCart,
      where: '${CartFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await instance.database;
    return db.delete(
      tableCart,
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

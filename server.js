var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var pool = mysql.createPool({
	host: 'localhost',
	user: process.env.DBUSER,
	password: process.env.DBPASS,
	database: process.env.DBNAME
});

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout: 'main'});

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 3000);
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(express.static('public'));

app.get('/', function(req, res) {
	res.render('home');
});

var selectTableData = function(res, table) {
  var ctx = {};
  pool.query('SELECT * FROM ' + table, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = rows;
    res.send(ctx);
  });
};

app.get('/characters', function(req, res) {
  selectTableData(res, 'character');
});

app.get('/series', function(req, res) {
  selectTableData(res, 'series');
});

app.get('/nations', function(req, res) {
  selectTableData(res, 'nation');
});

app.get('/combats', function(req, res) {
  selectTableData(res, 'combat');
});


app.get('/character_combats', function(req, res) {
  selectTableData(res, 'character_combats');
});


app.post('/search_character', function(req, res) {
  var ctx = {};
  var body = req.body;
  var queryStr = "SELECT character.name FROM character ";
  queryStr += 'INNER JOIN nation ON st_character.id = character_series.character_id ';
  queryStr += 'INNER JOIN series ON series.id = character.series_id';
  queryStr += ' WHERE character.name = "' + body.title + '";';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = rows;
    res.send(ctx);
  });
});

var generateUpdateStr = function(body, table) {
  var keys = [];
  var values = [];
  var str = '';
  for (var key in body) {
    keys.push(key);
    values.push("'" + body[key] + "'");
  }
  str += "INSERT INTO " + table;
  str += "(" + keys.join(",") + ")";
  str += " VALUES (" + values.join(",") + ");";

  return str;
};

var updateEntry = function(req, res, table) {
  var updateStr = generateUpdateStr(req.body, table);

  pool.query(updateStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    res.send(JSON.stringify(rows));
  });
};


app.post('/characters', function(req, res) {
  updateEntry(req, res, 'character');
});

app.post('/series', function(req, res) {
  updateEntry(req, res, 'series');
});

app.post('/combat', function(req, res) {
  updateEntry(req, res, 'combat');
});

app.post('/nations', function(req, res) {
  updateEntry(req, res, 'nation');
});

app.post('/character_combats', function(req, res) {
  updateEntry(req, res, 'character_combats');
});

var deleteEntry = function(req, res, table) {
  var ctx = {};
  var id = req.body.id;
  pool.query('DELETE FROM ' + table + ' WHERE id = ' + id, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
};


app.delete('/characters', function(req, res) {
  deleteEntry(req, res, 'character');
});

app.delete('/nations', function(req, res) {
  deleteEntry(req, res, 'nations');
});

app.delete('/series', function(req, res) {
  deleteEntry(req, res, 'series');
});

app.delete('/combats', function(req, res) {
  deleteEntry(req, res, 'combat');
});

app.delete('/character_combats', function(req, res) {
  var ctx = {};
  var body = req.body;
  var character_id = body.character_id;
  var combat_id = body.combat_id;

  var queryStr = 'DELETE FROM character_combats WHERE character_id = ' + character_id;
  queryStr += ' AND combat_id = ' + combat_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});



app.use(function(req, res) {
	res.status(404);
	res.render('404');
});

app.use(function(err, req, res, next){
	console.log(err.stack);
	res.status(500);
	res.render('500');
});

app.listen(app.get('port'), function() {
	console.log('Application started on port ' + app.get('port'));
});

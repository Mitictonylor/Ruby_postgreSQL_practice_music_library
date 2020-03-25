require ('pg')

class SqlRunner

  def SqlRunner.run(sql, values)
    begin#try to do but it may fail the connection
      db = PG.connect({dbname: 'music_collection', host: 'localhost'})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure#make sure it always close the database before crash
      db.close
    end
    return result
  end

end

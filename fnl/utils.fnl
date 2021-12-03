(fn merge-tables [t1 t2]
  (each [k v (pairs t2)]
    (tset t1 k v))
  t1)

(fn table-to-string [t]
  (let [s { }]
    (each [k v (pairs t)]
      (table.insert s (string.format "%s = %s" 
                                     k
                                     (if (= (type v) "string") (.. "\"" v "\"") v))))
    (.. "{" (table.concat s ", ") "}")))

{: merge-tables
 : table-to-string}

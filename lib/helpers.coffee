Agility.Helpers =
  getPath: (root, path) ->
    parts = path.split(".")
    root = root[part] for part in parts
    root

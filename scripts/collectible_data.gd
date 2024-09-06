extends Resource
class_name CollectibleData

@export var title : String
@export_enum('Dades', 'ERP', 'Webapps', 'Suport', 'POs', 'Technocuca', 'Cuca') var team : String
@export var time : String
@export var related_fites : Array[String]
@export_multiline var impacte : String
@export_multiline var enabler : String
@export_multiline var added_value : String

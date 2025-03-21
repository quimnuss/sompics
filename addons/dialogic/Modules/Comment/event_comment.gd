@tool
class_name DialogicCommentEvent
extends DialogicEvent

## Event that does nothing but store a comment string. Will print the comment in debug builds.


### Settings

## Content of the comment.
var text :String = ""


################################################################################
##                      EXECUTE
################################################################################

func _execute() -> void:
    print("[Dialogic Comment] #",  text)
    finish()


################################################################################
##                      INITIALIZE
################################################################################

func _init() -> void:
    event_name = "Comment"
    set_default_color('Color9')
    event_category = "Helpers"
    event_sorting_index = 0


################################################################################
##                      SAVING/LOADING
################################################################################

func to_text() -> String:
    var result_string = "# "+text
    return result_string


func from_text(string:String) -> void:
    text = string.trim_prefix("# ")


func is_valid_event(string:String) -> bool:
    if string.strip_edges().begins_with('#'):
        return true
    return false


################################################################################
##                      EDITOR REPRESENTATION
################################################################################

func build_event_editor():
    add_header_edit('text', ValueType.SINGLELINE_TEXT, {'left_text':'#', 'autofocus':true})


#################### SYNTAX HIGHLIGHTING #######################################
################################################################################

func _get_syntax_highlighting(Highlighter:SyntaxHighlighter, dict:Dictionary, line:String) -> Dictionary:
    dict[0] = {'color':event_color.lerp(Highlighter.normal_color, 0.3)}
    return dict

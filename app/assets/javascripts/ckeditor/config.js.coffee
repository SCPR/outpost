CKEDITOR.editorConfig = (config) ->
    config.extraPlugins = 'mediaembed,codemirror'
    
    config.codemirror =
        # Note: All other theme CSS files have been removed from this repo.
        # "default" may be used as it is built-in.
        # See https://github.com/w8tcha/CKEditor-CodeMirror-Plugin to download more themes.
        theme: 'monokai' # Set this to the theme you wish to use (codemirror themes)
        lineNumbers: true # Whether or not you want to show line numbers
        lineWrapping: false # Whether or not you want to use line wrapping
        matchBrackets: true # Whether or not you want to highlight matching braces
        autoCloseTags: false # Whether or not you want tags to automatically close themselves
        enableSearchTools: false  # Whether or not to enable search tools, CTRL+F (Find), CTRL+SHIFT+F (Replace), CTRL+SHIFT+R (Replace All), CTRL+G (Find Next), CTRL+SHIFT+G (Find Previous)
        enableCodeFolding: false # Whether or not you wish to enable code folding (requires 'lineNumbers' to be set to 'true')
        enableCodeFormatting: true # Whether or not to enable code formatting
        autoFormatOnStart: false # Whether or not to automatically format code should be done every time the source view is opened
        autoFormatOnUncomment: false # Whether or not to automatically format code which has just been uncommented
        highlightActiveLine: false # Whether or not to highlight the currently active line
        highlightMatches: false # Whether or not to highlight all matches of current word/selection
        showTabs: false # Whether or not to display tabs
        showFormatButton: false # Whether or not to show the format button on the toolbar
        showCommentButton: false # Whether or not to show the comment button on the toolbar
        showUncommentButton: false # Whether or not to show the uncomment button on the toolbar

    config.toolbar = [
        ['Bold', 'Italic', 'Underline', "RemoveFormat"]
        ['NumberedList', 'BulletedList', 'Blockquote']
        ['Link', 'Unlink', 'Image', 'MediaEmbed']
        ['Find', 'Paste']
        ['Source', 'Maximize']
    ]
    

    config.language = 'en'
    config.height = "400px"
    config.width  = "635px"
    config.bodyClass = 'ckeditor-body'
    config.contentsCss = "/assets/application.css"
    
    config.disableNativeSpellChecker = false
    config.forcePasteAsPlainText = true
    
    true

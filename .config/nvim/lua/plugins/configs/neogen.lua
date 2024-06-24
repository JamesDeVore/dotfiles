require('neogen').setup({
  enabled = true,
  languages = {
    php = {
      template = {
        annotation_convention = "phpdoc",
        function_template = {
          { "*/" },
          { " * ${1:Summary}" },
          { " *" },
          { " * @param ${2:type} ${3:name} ${4:Description}" },
          { " * @return ${5:type} ${6:Description}" },
          { " */" },
          { "${7:public} function ${8:function_name}(${9:parameters}) {" },
          { "\t${10:// code...}" },
          { "}" }
        },
        class_template = {
          { "*/" },
          { " * ${1:Summary}" },
          { " */" },
          { "class ${2:ClassName} {" },
          { "\t${3:/** @var ${4:type} */}" },
          { "\t${5:private $${6:property};}" },
          { "}" }
        }
      }
    },
    javascript = {
      template = {
        annotation_convention = "jsdoc",
        function_template = {
          { "/**" },
          { " * ${1:Summary}" },
          { " *" },
          { " * @param {${2:type}} ${3:name} ${4:Description}" },
          { " * @return {${5:type}} ${6:Description}" },
          { " */" },
          { "function ${7:function_name}(${8:parameters}) {" },
          { "\t${9:// code...}" },
          { "}" }
        },
        class_template = {
          { "/**" },
          { " * ${1:Summary}" },
          { " */" },
          { "class ${2:ClassName} {" },
          { "\t/**" },
          { "\t * Creates an instance of ${3:ClassName}." },
          { "\t * @constructor" },
          { "\t */" },
          { "\tconstructor(${4:parameters}) {" },
          { "\t\t${5:// code...}" },
          { "\t}" },
          { "}" }
        }
      }
    }
  }
})

-- Optional: Keymap for generating annotations
vim.api.nvim_set_keymap('n', '<leader>nf', ':lua require("neogen").generate()<CR>', { noremap = true, silent = true })


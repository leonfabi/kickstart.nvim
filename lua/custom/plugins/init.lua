-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- ── Jupyter / Notebook support ──────────────────────────────────────

  -- Runs Jupyter kernels and shows output inline
  {
    'benlubas/molten-nvim',
    version = '^1.0.0',
    build = ':UpdateRemotePlugins',
    init = function()
      vim.g.molten_image_provider = 'none' -- set to 'image.nvim' if you install image.nvim
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true -- show truncated output as virtual text
    end,
    keys = {
      { '<leader>mi', ':MoltenInit<CR>', desc = '[M]olten [I]nit kernel' },
      { '<leader>ml', ':MoltenEvaluateLine<CR>', desc = '[M]olten evaluate [L]ine' },
      { '<leader>me', ':MoltenEvaluateOperator<CR>', desc = '[M]olten [E]valuate operator' },
      { '<leader>mv', ':MoltenEvaluateVisual<CR>', mode = 'v', desc = '[M]olten evaluate [V]isual' },
      { '<leader>mr', ':MoltenReevaluateCell<CR>', desc = '[M]olten [R]e-evaluate cell' },
      { '<leader>md', ':MoltenDelete<CR>', desc = '[M]olten [D]elete cell' },
      { '<leader>mh', ':MoltenHideOutput<CR>', desc = '[M]olten [H]ide output' },
      { '<leader>ms', ':MoltenShowOutput<CR>', desc = '[M]olten [S]how output' },
      { '<leader>mx', ':MoltenInterrupt<CR>', desc = '[M]olten interrupt e[X]ecution' },
    },
  },

  -- Transparently opens .ipynb files as editable Python (# %% cell markers)
  {
    'GCBallesteros/jupytext.nvim',
    config = function()
      require('jupytext').setup {
        style = 'hydrogen', -- cell separator: # %%
        output_extension = 'auto', -- keep .ipynb on disk, edit as .py
        force_ft = 'python',
      }
    end,
  },

  -- Cell navigation and batch execution (]n / [n to move between # %% cells)
  {
    'GCBallesteros/NotebookNavigator.nvim',
    dependencies = { 'benlubas/molten-nvim', 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { ']n', function() require('notebook-navigator').move_cell 'd' end, desc = 'Next cell' },
      { '[n', function() require('notebook-navigator').move_cell 'u' end, desc = 'Prev cell' },
      { '<leader>cc', function() require('notebook-navigator').run_cell() end, desc = '[C]ell run' },
      { '<leader>ca', function() require('notebook-navigator').run_all_cells() end, desc = '[C]ell run [A]ll' },
    },
    config = function()
      require('notebook-navigator').setup {
        activate_hydra_keys = nil,
        show_hydra_hint = false,
        cell_highlight_group = 'CurSearch',
        repl_provider = 'molten',
      }
    end,
  },
}

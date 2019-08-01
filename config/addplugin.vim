command! -nargs=1 -complete=customlist,EditConfigComplete
	\ EditConfig call EditConfig(<f-args>)
call SetupCommandAlias('E', 'EditConfig')

if !exists('g:plugins_config') || type(g:plugins_config) != type({})
	let g:plugins_config = {}
endif

function! GetPluginName(repo)
	return split(a:repo, '/')[-1]
endfunction

function! GetPluginConfigFilename(repo)
	let plugin_name = GetPluginName(a:repo)
	return substitute(plugin_name, '\v\c(\.n?vim)?$', '.vim', '')
endfunction

function! GetPluginConfigPath(repo)
	let plugin_config_filename = GetPluginConfigFilename(a:repo)
	return join([$plugin_config_dir, plugin_config_filename], '/')
endfunction

function! AddPlugin(repo, ...)
	let plugin_config_path    = GetPluginConfigPath(a:repo)
	let plugin_config_options = get(a:, 1, {})

	let fsize = getfsize(plugin_config_path)
	if fsize > 0
		let plugin_config_options = extend(
			\ { 'hook_add': 'source '.plugin_config_path },
			\ plugin_config_options
			\)
	elseif fsize == 0
		call delete(plugin_config_path)
	endif

	let g:plugins_config = extend(g:plugins_config,
		\ { a:repo: plugin_config_options }
		\)
endfunction

function! GetPluginConfigPathFromPlugins(plugin_name)
	let match_plugins = filter(copy(g:plugins_config),
		\ {k, v -> GetPluginName(k) =~? '\v<\V'.a:plugin_name.'\v>'})

	if len(match_plugins) == 1
		let match_options = values(match_plugins)[0]
		let source = get(match_options, 'hook_add', '')
		return matchstr(source, '\S\+$')
	endif

	return ''
endfunction

function! EditConfig(plugin_name)
	let config_path = GetPluginConfigPathFromPlugins(a:plugin_name)
	if config_path != ''
		exec 'edit' config_path
	else
		exec 'edit '.GetPluginConfigPath(a:plugin_name)
	endif
endfunction

function! EditConfigComplete(ArgLead, CmdLine, CursorPos)
	let plugins_repo = keys(g:plugins_config)
	let plugins_name = map(plugins_repo, 'GetPluginName(v:val)')
	return filter(plugins_name, {idx, val -> val =~? '\V'.a:ArgLead})
endfunction

function! EEditConfig(plugin_name)
	exec 'edit '.GetPluginConfigPath(a:plugin_name)
endfunction

function! EEditConfigComplete(ArgLead, CmdLine, CursorPos)
	let plugins_repo = keys(g:plugins_config)
	let plugins_config_filename = map(plugins_repo, 'GetPluginConfigFilename(v:val)')
	return filter(plugins_config_filename, {idx, val -> val =~? '\V'.a:ArgLead})
endfunction

#
# Module manifest for module 'PsTokens'
#
# Generated by: Craig Buchanan <craibuc@gmail.com>
#
# Generated on: 2015/03/17
#

@{

    # Script module or binary module file associated with this manifest
    RootModule = 'PsTokens.psm1'

    # Version number of this module.
    ModuleVersion = '0.0.4'

    # ID used to uniquely identify this module
    GUID = 'B91B8494-CCAF-11E4-A69A-23029EF54746'

    # Author of this module
    Author = 'Craig Buchanan'

    # Company or vendor of this module
    CompanyName = 'Cogniza, Inc.'

    # Copyright statement for this module
    Copyright = '(c) 2021 Cogniza, Inc. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'PowerShell token-replacement library, based on work by Brice Lambson (https://gist.github.com/bricelam/a5debdbfc495eb7b116c).'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.0'

    # Name of the Windows PowerShell host required by this module
    PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    PowerShellHostVersion = ''

    # Minimum version of the .NET Framework required by this module
    DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module
    CLRVersion = ''

    # Processor architecture (None, X86, Amd64, IA64) required by this module
    ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module
    ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in ModuleToProcess
    NestedModules = ''

    # Functions to export from this module
    FunctionsToExport = 'Merge-Tokens'

    # Cmdlets to export from this module
    CmdletsToExport = '*'

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module
    AliasesToExport = '*'

    # List of all modules packaged with this module
    ModuleList = @()

    # List of all files packaged with this module
    FileList = @()

    # Private data to pass to the module specified in ModuleToProcess
    PrivateData = ''

}
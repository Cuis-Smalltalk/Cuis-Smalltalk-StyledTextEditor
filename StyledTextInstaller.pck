'From Cuis 4.0 of 16 November 2011 [latest update: #1144] on 4 December 2011 at 10:12:25 am'!Object subclass: #StyledTextInstaller	instanceVariableNames: ''	classVariableNames: ''	poolDictionaries: ''	category: 'StyledTextInstaller'!StyledTextInstaller class	instanceVariableNames: ''!!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 09:14'!     createStyledTextEditorDocumentation	"self new createStyledTextEditorDocumentation"	| model styleSet |	model _ StyledTextModel new.	SystemWindow		editFancierStyledText: model		label: 'Styled Text Editor Documentation'.	styleSet _ model styleSet.	styleSet		createDocumentationParagraphStyleSet;		createDocumentationCharacterStyleSet! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 10:09'!                   install	"self new install"	self styledTextPackages do: [:each | self installPackage: each].	self openExamples! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 07:58'!                       installPackage: packageName	| versionName |	versionName := self versionName: packageName.	CodeFileBrowser installPackage: (FileDirectory default readOnlyFileNamed: versionName)! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 08:54'!                    open: name	| file model |	file _ FileStream fileNamed: name , '.object'.	[model _ (SmartRefStream on: file) next] ensure: [file close].	^SystemWindow editFancierStyledText: model label: name! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 10:10'!     openExamples	"self new openExamples"	self		openStyledTextEditorDocumentation;		openMacbethExample! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 08:55'!  openMacbethExample	"self new openMacbethExample"	| window |	window _ self open: 'Macbeth Example'.	window color: Color white! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 09:58'!       openStyledTextEditorDocumentation	"self new openStyledTextEditorDocumentation"	self open: 'Styled Text Editor Documentation'! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 10:06'!         recreateDocumentationStyleSet	"self new recreateDocumentationStyleSet"	| model styleSet |	model _ self styledTextModelNamed: 'Styled Text Editor Documentation'.	styleSet _ model styleSet.	styleSet		createDocumentationParagraphStyleSet;		createDocumentationCharacterStyleSet! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 10:01'!               save: name	| model refStream |	model _ self styledTextModelNamed: name.	refStream _ SmartRefStream fileNamed: name , '.object'.	[refStream nextPut: model] ensure: [refStream close]! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 09:40'!               saveStyledTextEditorDocumentation	"self new saveStyledTextEditorDocumentation"	self save: 'Styled Text Editor Documentation'! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 09:59'!         styledTextModelNamed: name	| window |	window _ SystemWindow allInstances detect: [:each | each label = name].	^window model! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 07:54'!         styledTextPackages	^#('RTF' 'FFI' 'ExtendedClipboard' 'CrappyOSProcess' 'StyledText' 'StyledTextNotebook' 'StyledTextWiki')! !!StyledTextInstaller methodsFor: 'as yet unclassified' stamp: 'bp 12/4/2011 08:09'!           versionName: packageName	^(FileDirectory default fileNamesMatching: packageName , '.*.pck') sort last! !
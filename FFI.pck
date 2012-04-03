'From Cuis 4.0 of 16 November 2011 [latest update: #1144] on 14 March 2012 at 1:26:17 pm'!
!classDefinition: #FFIConstants category: #'FFI-Pools'!
SharedPool subclass: #FFIConstants
	instanceVariableNames: ''
	classVariableNames: 'FFIAtomicTypeMask FFIAtomicTypeShift FFICallTypeApi FFICallTypeCDecl FFIErrorAddressNotFound FFIErrorAttemptToPassVoid FFIErrorBadAddress FFIErrorBadArg FFIErrorBadArgs FFIErrorBadAtomicType FFIErrorBadExternalFunction FFIErrorBadExternalLibrary FFIErrorBadReturn FFIErrorCallFrameTooBig FFIErrorCallType FFIErrorCoercionFailed FFIErrorGenericError FFIErrorIntAsPointer FFIErrorInvalidPointer FFIErrorModuleNotFound FFIErrorNoModule FFIErrorNotFunction FFIErrorStructSize FFIErrorWrongType FFIFlagAtomic FFIFlagPointer FFIFlagStructure FFINoCalloutAvailable FFIStructSizeMask FFITypeBool FFITypeDoubleFloat FFITypeSignedByte FFITypeSignedChar FFITypeSignedInt FFITypeSignedLongLong FFITypeSignedShort FFITypeSingleFloat FFITypeUnsignedByte FFITypeUnsignedChar FFITypeUnsignedInt FFITypeUnsignedLongLong FFITypeUnsignedShort FFITypeVoid'
	poolDictionaries: ''
	category: 'FFI-Pools'!
!classDefinition: 'FFIConstants class' category: #'FFI-Pools'!
FFIConstants class
	instanceVariableNames: ''!

!classDefinition: #ExternalAddress category: #'FFI-Kernel'!
ByteArray variableByteSubclass: #ExternalAddress
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalAddress class' category: #'FFI-Kernel'!
ExternalAddress class
	instanceVariableNames: ''!

!classDefinition: #ExternalForm category: #'FFI-Kernel'!
Form subclass: #ExternalForm
	instanceVariableNames: 'pointer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalForm class' category: #'FFI-Kernel'!
ExternalForm class
	instanceVariableNames: ''!

!classDefinition: #ExternalObject category: #'FFI-Kernel'!
Object subclass: #ExternalObject
	instanceVariableNames: 'handle'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalObject class' category: #'FFI-Kernel'!
ExternalObject class
	instanceVariableNames: ''!

!classDefinition: #ExternalFunction category: #'FFI-Kernel'!
ExternalObject subclass: #ExternalFunction
	instanceVariableNames: 'flags argTypes'
	classVariableNames: 'FFIErrorMessages'
	poolDictionaries: 'FFIConstants'
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalFunction class' category: #'FFI-Kernel'!
ExternalFunction class
	instanceVariableNames: ''!

!classDefinition: #ExternalLibrary category: #'FFI-Kernel'!
ExternalObject subclass: #ExternalLibrary
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalLibrary class' category: #'FFI-Kernel'!
ExternalLibrary class
	instanceVariableNames: ''!

!classDefinition: #ExternalLibraryFunction category: #'FFI-Kernel'!
ExternalFunction subclass: #ExternalLibraryFunction
	instanceVariableNames: 'name module'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalLibraryFunction class' category: #'FFI-Kernel'!
ExternalLibraryFunction class
	instanceVariableNames: ''!

!classDefinition: #ExternalStructure category: #'FFI-Kernel'!
ExternalObject subclass: #ExternalStructure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'FFIConstants'
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalStructure class' category: #'FFI-Kernel'!
ExternalStructure class
	instanceVariableNames: 'compiledSpec'!

!classDefinition: #ExternalData category: #'FFI-Kernel'!
ExternalStructure subclass: #ExternalData
	instanceVariableNames: 'type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalData class' category: #'FFI-Kernel'!
ExternalData class
	instanceVariableNames: ''!

!classDefinition: #ExternalType category: #'FFI-Kernel'!
Object subclass: #ExternalType
	instanceVariableNames: 'compiledSpec referentClass referencedType'
	classVariableNames: 'AtomicSelectors AtomicTypeNames AtomicTypes StructTypes'
	poolDictionaries: 'FFIConstants'
	category: 'FFI-Kernel'!
!classDefinition: 'ExternalType class' category: #'FFI-Kernel'!
ExternalType class
	instanceVariableNames: ''!


!ExternalAddress commentStamp: '<historical>' prior: 0!
            An ExternalAddress is an opaque handle to objects outside Smalltalk memory (e.g., a pointer).!

!ExternalData commentStamp: '<historical>' prior: 0!
           Instances of ExternalData explicitly describe objects with associated type. They can be used for describing atomic C types like arrays of atomic types (e.g., 'int[]') or pointer to atomic types (e.g., 'int *').

Instance variables:
	type	<Integer | Behavior>	The basic type of the receiver.

The encoding of type is equivalent to that of the basic type in class ExternalType. The interpretation of whether the receiver describes an array of data or a pointer to data depends on the contents of the instance variable 'handle'. If handle contains an ExternalAddress the receiver is treated as pointer to type. If the handle contains a ByteArray the receiver is interpreted as describing an array of type. Note that both interpretations are treated equivalent in external calls, e.g., if one describes an argument to an external call as taking 'int*' then, depending on the type of handle either the actual contents (if ExternalAddress) or a pointer to the contents (if ByteArray) is passed.

!

!ExternalForm commentStamp: 'jcg 1/29/2010 01:00' prior: 0!
   An ExternalForm is a specialized Form whose pixel-data is stored in memory that the user provides a pointer to.  This can simply be memory on the C heap, or (the motivating use-case...) it can be a pointer that is temporarily "mapped" from GPU memory by an API such as OpenCL.

The user is responsible for both releasing the image-memory, as well as destroying the surface handle (perhaps the latter should be handled by automatic finalization).

Example usage:

| extent form ptr |
extent := 400@300.
form := ExternalForm extent: extent depth: 32.
ptr := ExternalAddress gcallocate: (extent x * extent y * 4).
form setManualSurfacePointer: ptr.
Display displayScaledOn: form.
form displayAt: 0@0.
form destroySurface.
!

!ExternalFunction commentStamp: '<historical>' prior: 0!
                     This class represents an external function called from Smalltalk. Instances of ExternalFunction can be created if the address/parameters of the function are known by some other means than loading from a shared library or compiling the appropriate primitive specification.

Instance variables:
	flags	<Integer>	a set of flags encoding the calling convention
	args	<Array of: ExternalType>		the parameters of the function

Implementation notes:

The arguments consist of an array with the first element defining the return type, the remaining arguments defining the parameters of the call.
!

!ExternalLibrary commentStamp: '<historical>' prior: 0!
                         An external library bundles calls to functions from the same library. It is provided mainly as convenience since every external function can be fully specified by the name and the module it resides in.

Every external function that is defined in an external library by default will use the library it is defined in. This can always be modified by providing the appropriate module in the specification. !

!ExternalLibraryFunction commentStamp: '<historical>' prior: 0!
           An ExternalLibraryFunction specifies a fully qualified function from an external library.

Instance variables:
	name	<Integer | String>	name or ordinal of function
	module	<String | nil>			name of module (nil if bound in the VM).!

!ExternalObject commentStamp: '<historical>' prior: 0!
 External objects represent entities that are not part of the Smalltalk universe. They are accessed using a unique handle which is interpreted depending on the actual entity that is represented. 

Instance variables:
	handle	<ByteArray | ExternalAddress>!

!ExternalStructure commentStamp: '<historical>' prior: 0!
      This class provides an abstract base for all structures that can be used by external functions. ExternalStructures have two possible handle types:
	- ExternalAddress
		If the handle is an external address then the object described does not reside in the Smalltalk object memory.
	- ByteArray
		If the handle is a byte array then the object described resides in Smalltalk memory.
Useful methods should be implemented by subclasses of ExternalStructure using the common ByteArray/ExternalAddress platform dependent access protocol which will transparently access the correct memory location.!

!ExternalType commentStamp: '<historical>' prior: 0!
                           An external type represents the type of external objects.

Instance variables:
	compiledSpec	<WordArray>		Compiled specification of the external type
	referentClass	<Behavior | nil>	Class type of argument required
	referencedType	<ExternalType>	Associated (non)pointer type with the receiver

Compiled Spec:
The compiled spec defines the type in terms which are understood by the VM. Each word is defined as:
	bits 0...15 	- byte size of the entity
	bit 16		- structure flag (FFIFlagStructure)
				  This flag is set if the following words define a structure
	bit 17		- pointer flag (FFIFlagPointer)
				  This flag is set if the entity represents a pointer to another object
	bit 18		- atomic flag (FFIFlagAtomic)
				  This flag is set if the entity represents an atomic type.
				  If the flag is set the atomic type bits are valid.
	bits 19...23	- unused
	bits 24...27	- atomic type (FFITypeVoid ... FFITypeDoubleFloat)
	bits 28...31	- unused

Note that all combinations of the flags FFIFlagPointer, FFIFlagAtomic, and FFIFlagStructure are invalid, EXCEPT from the following:

	FFIFlagPointer + FFIFlagAtomic:
		This defines a pointer to an atomic type (e.g., 'char*', 'int*').
		The actual atomic type is represented in the atomic type bits.

	FFIFlagPointer + FFIFlagStructure:
		This defines a structure which is a typedef of a pointer type as in
			typedef void* VoidPointer;
			typedef Pixmap* PixmapPtr;
		It requires a byte size of four (e.g. a 32bit pointer) to work correctly.

[Note: Other combinations may be allowed in the future]
!

!ExternalAddress methodsFor: 'arithmetic' stamp: 'ar 9/16/2010 21:05'!
           + offset
	"Create an address that is offset by the given number of bytes.
	More tricky than one would think due to the FFI's handling of ExternalAddress
	as pointer to an object so that 'self unsignedLongAt: ' would dereference."

	| bytes |
	"Convert xaddr -> bytes"
	bytes := self asByteArrayPointer.
	"Update bytes using platform dependent accessors"
	bytes unsignedLongAt: 1 put: (bytes unsignedLongAt: 1) + offset.
	"Convert bytes -> xaddr"
	^bytes asExternalPointer! !

!ExternalAddress class methodsFor: 'instance creation' stamp: 'ar 11/28/1999 23:20'!
               allocate: byteSize
	"Primitive. Allocate an object on the external heap."
	<primitive:'primitiveFFIAllocate' module:'SqueakFFIPrims'>
	^self primitiveFailed! !

!ExternalForm methodsFor: 'initialize' stamp: 'jcg 6/6/2010 14:32'!
                           allocateSpace
	"Convenient way to allocate space for the pixels.  This isn't done by default, because it is common to use a pointer obtained from elsewhere."
	| addr |
	pointer ifNotNil: [self error: 'space is already allocated'].
	addr := ExternalAddress gcallocate: width*height * depth/8. "area times bytes/pixel"
	self setManualSurfacePointer: addr.! !

!ExternalFunction methodsFor: 'accessing' stamp: 'ar 11/19/1999 19:13'!
                  argTypes
	^argTypes! !

!ExternalAddress methodsFor: 'private' stamp: 'ar 1/28/2000 17:45'!
    asByteArrayPointer
	"Return a ByteArray describing a pointer to the contents of the receiver."
	^(ByteArray new: 4)
		byteAt: 1 put: (self basicAt: 1);
		byteAt: 2 put: (self basicAt: 2);
		byteAt: 3 put: (self basicAt: 3);
		byteAt: 4 put: (self basicAt: 4);
	yourself! !

!ByteArray methodsFor: '*FFI-Kernel' stamp: 'ar 1/28/2000 17:45'!
            asExternalPointer
	"Convert the receiver assuming that it describes a pointer to an object."
	^(ExternalAddress new)
		basicAt: 1 put: (self byteAt: 1);
		basicAt: 2 put: (self byteAt: 2);
		basicAt: 3 put: (self byteAt: 3);
		basicAt: 4 put: (self byteAt: 4);
	yourself! !

!ExternalAddress methodsFor: 'private' stamp: 'jcg 2/16/2010 01:00'!
        asExternalPointer
	"No need to convert."
	^self! !

!ExternalAddress methodsFor: 'converting' stamp: 'bf 2/21/2001 23:50'!
     asInteger
	"convert address to integer"
	^ self asByteArrayPointer unsignedLongAt: 1! !

!ExternalType methodsFor: 'converting' stamp: 'ar 12/2/1999 16:41'!
   asNonPointerType
	"convert the receiver into a non pointer type"
	self isPointerType
		ifTrue:[^referencedType]
		ifFalse:[^self]! !

!ExternalType methodsFor: 'converting' stamp: 'ar 12/2/1999 16:40'!
                      asPointerType
	"convert the receiver into a pointer type"
	self isPointerType
		ifTrue:[^self]
		ifFalse:[^referencedType]! !

!ExternalType methodsFor: 'accessing' stamp: 'ar 12/2/1999 14:15'!
                              atomicType
	^(self headerWord bitAnd: FFIAtomicTypeMask) >> FFIAtomicTypeShift! !

!ExternalFunction class methodsFor: 'compiler support' stamp: 'ar 12/2/1999 16:20'!
                         atomicTypeNamed: aString
	^ExternalType atomicTypeNamed: aString! !

!ExternalType class methodsFor: 'private' stamp: 'ar 12/2/1999 16:59'!
                    atomicTypeNamed: aString
	^AtomicTypes at: aString ifAbsent:[nil]! !

!ExternalAddress methodsFor: 'initialize-release' stamp: 'ar 11/22/1999 04:25'!
          beNull
	"Make the receiver a NULL pointer"
	self atAllPut: 0.! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:56'!
                bool
	^AtomicTypes at: 'bool'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:15'!
  booleanAt: byteOffset
	"bool is only valid with function declarations"
	^self shouldNotImplement! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:15'!
                               booleanAt: byteOffset put: value
	"bool is only valid with function declarations"
	^self shouldNotImplement! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 11/20/1999 17:29'!
 byte
	"byte defaults to unsigned byte"
	^self unsignedByte! !

!ExternalAddress methodsFor: 'accessing' stamp: 'ar 11/21/1999 15:43'!
                          byteAt: byteOffset
	"Go through a different primitive since the receiver describes data in the outside world"
	^self unsignedByteAt: byteOffset! !

!ExternalAddress methodsFor: 'accessing' stamp: 'ar 11/21/1999 15:43'!
     byteAt: byteOffset put: value
	"Go through a different primitive since the receiver describes data in the outside world"
	^self unsignedByteAt: byteOffset put: value! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 12/2/1999 14:31'!
 byteSize
	"Return the size in bytes of this structure."
	^self compiledSpec first bitAnd: FFIStructSizeMask! !

!ExternalType methodsFor: 'accessing' stamp: 'ar 12/2/1999 14:11'!
             byteSize
	"Return the size in bytes of this type"
	^self headerWord bitAnd: FFIStructSizeMask! !

!ExternalFunction class methodsFor: 'constants' stamp: 'ar 11/19/1999 16:36'!
                callTypeAPI
	^FFICallTypeApi! !

!ExternalFunction class methodsFor: 'constants' stamp: 'ar 11/19/1999 16:36'!
                 callTypeCDecl
	^FFICallTypeCDecl! !

!ExternalFunction class methodsFor: 'compiler support' stamp: 'ar 11/17/1999 19:58'!
      callingConventionFor: aString
	"Return the constant describing the calling convention for the given string specification or nil if unknown."
	aString = 'cdecl:' ifTrue:[^self callTypeCDecl].
	aString = 'apicall:' ifTrue:[^self callTypeAPI].
	^nil! !

!ExternalFunction methodsFor: 'printing' stamp: 'ar 11/19/1999 16:35'!
                              callingConventionString
	(flags allMask: FFICallTypeApi) 
		ifTrue:[^'apicall']
		ifFalse:[^'cdecl']! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 11/20/1999 17:29'!
        char
	"char defaults to unsigned char"
	^self unsignedChar! !

!ExternalType class methodsFor: 'housekeeping' stamp: 'ar 12/2/1999 18:00'!
                     cleanupUnusedTypes
	"ExternalType cleanupUnusedTypes"
	| value |
	StructTypes keys do:[:key|
		value := StructTypes at: key.
		value == nil ifTrue:[StructTypes removeKey: key ifAbsent:[]]].! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'gk 3/1/2005 12:06'!
          compileAlias: spec withAccessors: aBool
	"Define all the fields in the receiver.
	Return the newly compiled spec."
	| fieldName fieldType isPointerField externalType |
	fieldName := spec first.
	fieldType := spec second.
	isPointerField := fieldType last = $*.
	fieldType := fieldType copyWithout: $*.
	externalType := ExternalType atomicTypeNamed: fieldType.
	externalType == nil ifTrue:["non-atomic"
		Symbol hasInterned: fieldType ifTrue:[:sym|
			externalType := ExternalType structTypeNamed: sym]].
	externalType == nil ifTrue:[
		Transcript show:'(', fieldType,' is void)'.
		externalType := ExternalType void].
	isPointerField ifTrue:[externalType := externalType asPointerType].
	(fieldName notNil and:[aBool]) ifTrue:[
		self defineAliasAccessorsFor: fieldName
			type: externalType].
	isPointerField 
		ifTrue:[compiledSpec := WordArray with: 
					(ExternalType structureSpec bitOr: ExternalType pointerSpec)]
		ifFalse:[compiledSpec := externalType compiledSpec].
	ExternalType noticeModificationOf: self.
	^compiledSpec! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 12/2/1999 15:35'!
                              compileAllFields
	"ExternalStructure compileAllFields"
	self withAllSubclassesDo:[:cls|
		cls compileFields.
	].! !

!ExternalData class methodsFor: 'class initialization' stamp: 'ar 8/14/2006 23:18'!
                       compileFields
	"Ensure proper initialization of ExternalType when first loading"
	ExternalType initialize.
	^super compileFields! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 12/2/1999 14:28'!
      compileFields
	"Compile the field definition of the receiver.
	Return the newly compiled spec."
	^self compileFields: self fields! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 12/2/1999 14:28'!
     compileFields: fieldSpec
	"Compile the field definition of the receiver.
	Return the newly compiled spec."
	^self compileFields: fieldSpec withAccessors: false.! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'tbn 8/4/2010 16:06'!
      compileFields: specArray withAccessors: aBool 
	"Define all the fields in the receiver. 
	Return the newly compiled spec."
	| fieldName fieldType isPointerField externalType byteOffset typeSize typeSpec selfRefering |
	(specArray size > 0 and: [specArray first class ~~ Array])
		ifTrue: [^ self compileAlias: specArray withAccessors: aBool].
	byteOffset := 1.
	typeSpec := WriteStream on: (WordArray new: 10).
	typeSpec nextPut: FFIFlagStructure.
	"dummy for size"
	specArray do: [:spec | 
		fieldName := spec first.
		fieldType := spec second.
		isPointerField := fieldType last = $*.
		fieldType := (fieldType findTokens: ' *') first.
		externalType := ExternalType atomicTypeNamed: fieldType.
		selfRefering := (externalType == nil and: [fieldType = self asString]) and: isPointerField.
		selfRefering ifTrue: [
			externalType := ExternalType void asPointerType
		] ifFalse:[
			externalType == nil ifTrue: ["non-atomic"
				Symbol
					hasInterned: fieldType
					ifTrue: [:sym | externalType := ExternalType structTypeNamed: sym].
			].
			externalType == nil ifTrue:[
				Transcript show: '(' , fieldType , ' is void)'.
				externalType := ExternalType void.
			].
			isPointerField ifTrue: [externalType := externalType asPointerType]].
			typeSize := externalType byteSize.
			spec size > 2 ifTrue: ["extra size"
				spec third < typeSize
					ifTrue: [^ self error: 'Explicit type size is less than expected'].
				typeSize := spec third.
			].
			(fieldName notNil and: [aBool]) ifTrue: [
				self defineFieldAccessorsFor: fieldName startingAt: byteOffset type: externalType.
			].
			typeSpec nextPutAll: (externalType embeddedSpecWithSize: typeSize).
			byteOffset := byteOffset + typeSize.
		].
	compiledSpec := typeSpec contents.
	compiledSpec at: 1 put: (byteOffset - 1 bitOr: FFIFlagStructure).
	ExternalType noticeModificationOf: self.
	^ compiledSpec! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 12/2/1999 14:28'!
                        compiledSpec
	"Return the compiled spec of the receiver"
	^compiledSpec ifNil:[self compileFields].! !

!ExternalType methodsFor: 'accessing' stamp: 'ar 12/2/1999 14:29'!
                     compiledSpec
	"Return the compiled spec of the receiver"
	^compiledSpec! !

!ExternalType methodsFor: 'private' stamp: 'ar 12/2/1999 15:19'!
                   compiledSpec: aWordArray
	compiledSpec := aWordArray.! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'jmv 3/13/2012 15:33'!
                defineAliasAccessorsFor: fieldName type: type
	"Define read/write accessors for the given field"
	| code refClass argName |
	(type isVoid and:[type isPointerType not]) ifTrue:[^self].
	refClass := type referentClass.
	code := String streamContents:[:s|
		s 
			nextPutAll: fieldName; newLine; tab;
			nextPutAll:'"This method was automatically generated"'; newLine; tab.
		refClass == nil 
			ifTrue:[(type isAtomic and:[type isPointerType not]) 
				ifTrue:[s nextPutAll:'^handle']
				ifFalse:[s nextPutAll:'^ExternalData fromHandle: handle'.
						type isPointerType ifTrue:[s nextPutAll:' asExternalPointer'].
						s nextPutAll:' type: ';
						nextPutAll: type externalTypeName]]
			ifFalse:[s nextPutAll:'^', refClass name,' fromHandle: handle'.
					type isPointerType ifTrue:[s nextPutAll:' asExternalPointer']]].
	self compile: code classified: 'accessing'.

	code := String streamContents:[:s|
		argName := refClass == nil 
			ifTrue:[(type isAtomic and:[type isPointerType not])
				ifTrue:['anObject']
				ifFalse:['anExternalData']]
			ifFalse:['a',refClass name].
		s
			nextPutAll: fieldName,': '; nextPutAll: argName; newLine; tab;
			nextPutAll:'"This method was automatically generated"'; newLine; tab.
		(refClass == nil and:[type isAtomic and:[type isPointerType not]])
			ifTrue:[s nextPutAll:'handle := ', argName]
			ifFalse:[s nextPutAll:'handle := ', argName,' getHandle'.
					type isPointerType ifTrue:[s nextPutAll:' asByteArrayPointer']]].
	self compile: code classified: 'accessing'.! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 11/29/1999 00:42'!
                           defineFieldAccessorsFor: fieldName startingAt: byteOffset type: type
	"Define read/write accessors for the given field"
	| code |
	(type isVoid and:[type isPointerType not]) ifTrue:[^self].
	code := fieldName,'
	"This method was automatically generated"
	', (type readFieldAt: byteOffset).
	self compile: code classified: 'accessing'.
	code := fieldName,': anObject
	"This method was automatically generated"
	', (type writeFieldAt: byteOffset with:'anObject').
	self compile: code classified: 'accessing'.! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 12/2/1999 14:37'!
            defineFields
	"Define all the fields in the receiver"
	self defineFields: self fields.! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 12/2/1999 14:38'!
                defineFields: fields
	"Define all the fields in the receiver"
	self compileFields: fields withAccessors: true.! !

!ExternalForm methodsFor: 'initialize' stamp: 'jcg 1/29/2010 01:29'!
        destroySurface
	"Users must call this explicitly when this object is no longer needed; otherwise, resource-leakage will occur in the SurfacePlugin"
	bits ifNotNil: [:surfaceID |
		bits := nil.
		self primDestroyManualSurface: surfaceID
	].! !

!ExternalStructure class methodsFor: 'class management' stamp: 'ar 11/22/1999 10:10'!
                      doneCompiling
	"I have been recompiled. Update any types that reference me."
	ExternalType noticeModificationOf: self.! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:56'!
                       double
	^AtomicTypes at: 'double'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:44'!
                              doubleAt: byteOffset
	<primitive:'primitiveFFIDoubleAt' module:'SqueakFFIPrims'>
	^self primitiveFailed! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:13'!
                        doubleAt: byteOffset put: value
	<primitive:'primitiveFFIDoubleAtPut' module:'SqueakFFIPrims'>
	^self primitiveFailed! !

!ExternalType methodsFor: 'private' stamp: 'ar 12/2/1999 20:34'!
     embeddedSpecWithSize: typeSize
	"Return a compiled spec for embedding in a new compiled spec."
	| spec header |
	spec := self compiledSpec copy.
	header := spec at: 1.
	header := (header bitAnd: FFIStructSizeMask bitInvert32) bitOr: typeSize.
	spec at: 1 put: header.
	(self isStructureType and:[self isPointerType not])
		ifTrue:[spec := spec copyWith: self class structureSpec].
	^spec! !

!ExternalFunction class methodsFor: 'error handling' stamp: 'ar 11/19/1999 14:17'!
     errorMessageFor: code
	"Return the error message for the given error code from the foreign function interface"
	^FFIErrorMessages at: code ifAbsent:['Call to external function failed'].! !

!Object methodsFor: '*FFI-Kernel' stamp: 'ar 8/14/2006 23:02'!
   externalCallFailed
	"Raise an error after a failed call to an external function"
	| errCode |
	errCode := ExternalFunction getLastError. "this allows us to look at the actual error code"
	^self error: (ExternalFunction errorMessageFor: errCode).! !

!ExternalStructure class methodsFor: 'instance creation' stamp: 'ar 12/1/1999 15:58'!
                externalNew
	"Create an instance of the receiver on the external heap"
	^self fromHandle: (ExternalAddress allocate: self byteSize)! !

!ExternalStructure class methodsFor: 'converting' stamp: 'ar 12/2/1999 16:55'!
         externalType
	"Return an external type describing the receiver as a structure"
	^ExternalType structTypeNamed: self name! !

!ExternalType methodsFor: 'private' stamp: 'ar 1/27/2000 00:22'!
  externalTypeName
	^'ExternalType ', (AtomicTypeNames at: self atomicType), ' asPointerType'! !

!ExternalData class methodsFor: 'field definition' stamp: 'ar 1/27/2000 01:23'!
                fields
	"ExternalData defineFields"
	"Note: The definition is for completeness only.
	ExternalData is treated specially by the VM."
	^#(nil 'void*')! !

!ExternalStructure class methodsFor: 'field definition' stamp: 'ar 11/29/1999 00:28'!
                 fields
	"Return the fields defining the receiver"
	^#()! !

!ExternalStructure class methodsFor: 'class management' stamp: 'jmv 3/13/2012 12:34'!
              fileOutInitializerOn: aFileStream

	super fileOutInitializerOn: aFileStream.
	aFileStream newLine.
	aFileStream newLine.
	aFileStream nextChunkPut: self name , ' compileFields'.
	aFileStream newLine.! !

!ExternalStructure class methodsFor: 'class management' stamp: 'jmv 3/13/2012 12:34'!
                              fileOutOn: aFileStream moveSource: moveSource toFile: fileIndex initializing: aBool

	super fileOutOn: aFileStream
		moveSource: moveSource
		toFile: fileIndex
		initializing: aBool.
	(aBool and:[moveSource not]) ifTrue: [
		aFileStream newLine.
		aFileStream newLine.
		aFileStream nextChunkPut: self name , ' compileFields'.
		aFileStream newLine]! !

!ExternalAddress methodsFor: 'initialize-release' stamp: 'nice 5/19/2006 03:17'!
             finalize
	"I am an executor (a copy) of an ExternalAddress that was just garbage collected.
	I must finalize. my mission is to free memory"
	
	self free! !

!ExternalFunction methodsFor: 'accessing' stamp: 'ar 11/19/1999 19:13'!
                           flags
	^flags! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:57'!
float
	^AtomicTypes at: 'float'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:13'!
floatAt: byteOffset
	<primitive:'primitiveFFIFloatAt' module:'SqueakFFIPrims'>
	^self primitiveFailed! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:13'!
                          floatAt: byteOffset put: value
	<primitive:'primitiveFFIFloatAtPut' module:'SqueakFFIPrims'>
	^self primitiveFailed! !

!ExternalLibrary methodsFor: 'initialize-release' stamp: 'ar 12/8/1999 21:49'!
                         forceLoading
	"Primitive. Force loading the given library.
	The primitive will fail if the library is not available
	or if anything is wrong with the receiver."
	<primitive: 'primitiveForceLoad' module:'SqueakFFIPrims'>
	^self externalCallFailed "The primitive will set the error code"! !

!ExternalFunction class methodsFor: 'compiler support' stamp: 'ar 12/2/1999 16:49'!
          forceTypeNamed: aString
	^ExternalType forceTypeNamed: aString! !

!ExternalType class methodsFor: 'private' stamp: 'ar 12/2/1999 16:50'!
                      forceTypeNamed: aString
	^self newTypeNamed: aString force: true! !

!ExternalAddress methodsFor: 'initialize-release' stamp: 'ar 11/28/1999 23:40'!
           free
	"Primitive. Free the object pointed to on the external heap.
	Dangerous - may break your system if the receiver hasn't been
	allocated by ExternalAddress class>>allocate:. No checks are done."
	<primitive:'primitiveFFIFree' module:'SqueakFFIPrims'>
	^self primitiveFailed! !

!ExternalStructure methodsFor: 'initialize-release' stamp: 'ar 11/28/1999 23:21'!
                    free
	"Free the handle pointed to by the receiver"
	(handle ~~ nil and:[handle isExternalAddress]) ifTrue:[handle free].
	handle := nil.! !

!ExternalData methodsFor: 'conversion' stamp: 'hg 2/25/2000 14:51'!
               fromCString
	"Assume that the receiver represents a C string and convert it to a Smalltalk string. hg 2/25/2000 14:18"

	| stream index char |
	type isPointerType ifFalse: [self error: 'External object is not a pointer type.'].
	stream := WriteStream on: String new.
	index := 1.
	[(char := handle unsignedCharAt: index) = 0 asCharacter] whileFalse: [
		stream nextPut: char.
		index := index + 1].
	^stream contents! !

!ExternalData methodsFor: 'conversion' stamp: 'jrd 4/23/2009 17:35'!
                      fromCStrings
	"Assume that the receiver represents a set of C strings and is teerminated by a empty string and convert it to a Smalltalk ordered collection of strings"

	| stream index char strings str |
	type isPointerType ifFalse: [self error: 'External object is not a pointer type.'].
	strings := OrderedCollection new.
	index := 1.
	[
		stream := WriteStream on: String new.
		[(char := handle unsignedCharAt: index) = 0 asCharacter]
			whileFalse: [
				stream nextPut: char.
				index := index + 1
			].
		str := stream contents.
		strings addLast: str.
		str size = 0
	] whileFalse.
	^strings! !

!ExternalStructure class methodsFor: 'instance creation' stamp: 'ar 11/29/1999 00:36'!
            fromHandle: aHandle
	^self basicNew setHandle: aHandle! !

!ExternalData class methodsFor: 'instance creation' stamp: 'ar 12/2/1999 14:57'!
                    fromHandle: aHandle type: aType
	"Create a pointer to the given type"
	"ExternalData fromHandle: ExternalAddress new type: ExternalType float"
	^self basicNew setHandle: aHandle type: aType! !

!ExternalAddress methodsFor: 'converting' stamp: 'bf 2/21/2001 23:50'!
                       fromInteger: address
	"set my handle to point at address."
	"Do we really need this? bf 2/21/2001 23:48"

	| pointer |
	pointer := ByteArray new: 4.
	pointer unsignedLongAt: 1 put: address.
	self basicAt: 1 put: (pointer byteAt: 1);
		basicAt: 2 put: (pointer byteAt: 2);
		basicAt: 3 put: (pointer byteAt: 3);
		basicAt: 4 put: (pointer byteAt: 4)
! !

!ExternalAddress class methodsFor: 'instance creation' stamp: 'nice 5/19/2006 03:24'!
        gcallocate: byteSize
	"Primitive. Allocate an object on the external heap.
	The external memory will be freed when i am garbage collected.
	BEWARE: there should be no copy of self, nor any pointer to a sub part..."
	
	| externalAddress |
	externalAddress := self allocate: byteSize.
	self finalizationRegistry add: externalAddress.
	^externalAddress! !

!ExternalObject methodsFor: 'private' stamp: 'ar 11/16/1999 20:25'!
                          getHandle
	"Private. Return the handle used to represent the external entitiy."
	^handle! !

!ExternalFunction class methodsFor: 'error handling' stamp: 'ar 11/28/1999 18:37'!
                getLastError
	"Return the last error from an external call.
	Only valid immediately after the external call failed."
	<primitive: 'primitiveFFIGetLastError' module:'SqueakFFIPrims'>
	^-1! !

!ExternalLibrary methodsFor: 'accessing' stamp: 'ar 11/17/1999 19:35'!
                          handle
	^handle! !

!ExternalType methodsFor: 'private' stamp: 'ar 12/2/1999 14:11'!
           headerWord
	"Return the compiled header word"
	^compiledSpec at: 1! !

!ExternalForm methodsFor: 'initialize' stamp: 'jcg 6/4/2010 02:04'!
                     initialize
	super initialize.
	pointer := nil.
	! !

!ExternalFunction class methodsFor: 'class initialization' stamp: 'ar 3/9/2010 21:45'!
                    initialize
	"ExternalFunction initialize"
	FFIConstants initialize. "ensure proper initialization"
	self initializeErrorMessages.
	(Smalltalk specialObjectsArray at: 47) == self 
		ifFalse:[Smalltalk recreateSpecialObjectsArray].
! !

!ExternalFunction methodsFor: 'initialize-release' stamp: 'ar 11/29/1999 00:35'!
    initialize
	"Initialize the receiver"
	handle := ExternalAddress new.! !

!ExternalLibrary methodsFor: 'initialize-release' stamp: 'ar 11/29/1999 00:35'!
      initialize
	"Initialize the receiver"
	name := self class moduleName.
	handle := ExternalAddress new.! !

!ExternalObject class methodsFor: 'class initialization' stamp: 'ar 11/19/1999 22:37'!
                               initialize
	"ExternalObject initialize"
	Smalltalk addToStartUpList: self after: ShortRunArray.! !

!ExternalType class methodsFor: 'class initialization' stamp: 'ar 12/2/1999 16:15'!
        initialize
	"ExternalType initialize"
	self initializeFFIConstants.
	self initializeDefaultTypes.! !

!FFIConstants class methodsFor: 'pool initialization' stamp: 'ar 5/18/2003 18:54'!
       initialize
	"FFIConstants initialize"
	self initializeTypeConstants.
	self initializeErrorConstants.
	self initializeCallingConventions.! !

!ExternalType class methodsFor: 'class initialization' stamp: 'ar 4/7/2009 23:42'!
initializeAtomicTypes
	"ExternalType initialize"
	| atomicType byteSize type typeName |
	#(
		"name		atomic id		byte size"
		('void' 		0 				0)
		('bool' 		1 				1)
		('byte' 		2 				1)
		('sbyte' 	3 				1)
		('ushort' 	4 				2)
		('short' 		5 				2)
		('ulong' 	6 				4)
		('long' 		7 				4)
		('ulonglong' 8 				8)
		('longlong' 	9 				8)
		('char' 		10 				1)
		('schar' 	11 				1)
		('float' 		12 				4)
		('double' 	13 				8)
	) do:[:typeSpec| | compiled |
		typeName := typeSpec first.
		atomicType := typeSpec second.
		byteSize := typeSpec third.
		compiled := WordArray with: ((byteSize bitOr: FFIFlagAtomic) bitOr:
				(atomicType bitShift: FFIAtomicTypeShift)).
		type := (AtomicTypes at: typeName).
		type compiledSpec: compiled.
		compiled := WordArray with: ((self pointerSpec bitOr: FFIFlagAtomic) bitOr:
				(atomicType bitShift: FFIAtomicTypeShift)).
		type asPointerType compiledSpec: compiled.
	].! !

!FFIConstants class methodsFor: 'pool initialization' stamp: 'ar 5/18/2003 18:50'!
                    initializeCallingConventions
	FFICallTypeCDecl := 0.
	FFICallTypeApi := 1.
! !

!ExternalType class methodsFor: 'class initialization' stamp: 'ar 12/2/1999 17:01'!
                            initializeDefaultTypes
	"ExternalType initialize"
	| type pointerType |
	AtomicTypes = nil ifTrue:[
		"Create new atomic types and setup the dictionaries"
		AtomicTypes := Dictionary new.
		StructTypes := WeakValueDictionary new.
		AtomicTypeNames valuesDo:[:k|
			type := self basicNew.
			pointerType := self basicNew.
			AtomicTypes at: k put: type.
			type setReferencedType: pointerType.
			pointerType setReferencedType: type.
		].
	].
	self initializeAtomicTypes.
	self initializeStructureTypes.
	"AtomicTypes := nil"! !

!FFIConstants class methodsFor: 'pool initialization' stamp: 'eem 11/5/2009 10:21'!
                           initializeErrorConstants
	"FFIConstants initializeErrorConstants"

	"No callout mechanism available"
	FFINoCalloutAvailable := -1.
	"generic error"
	FFIErrorGenericError := 0.
	"primitive invoked without ExternalFunction"
	FFIErrorNotFunction := 1.
	"bad arguments to primitive call"
	FFIErrorBadArgs := 2.

	"generic bad argument"
	FFIErrorBadArg := 3.
	"int passed as pointer"
	FFIErrorIntAsPointer := 4.
	"bad atomic type (e.g., unknown)"
	FFIErrorBadAtomicType := 5.
	"argument coercion failed"
	FFIErrorCoercionFailed := 6.
	"Type check for non-atomic types failed"
	FFIErrorWrongType := 7.
	"struct size wrong or too large"
	FFIErrorStructSize := 8.
	"unsupported calling convention"
	FFIErrorCallType := 9.
	"cannot return the given type"
	FFIErrorBadReturn := 10.
	"bad function address"
	FFIErrorBadAddress := 11.
	"no module given but required for finding address"
	FFIErrorNoModule := 12.
	"function address not found"
	FFIErrorAddressNotFound := 13.
	"attempt to pass 'void' parameter"
	FFIErrorAttemptToPassVoid := 14.
	"module not found"
	FFIErrorModuleNotFound := 15.
	"external library invalid"
	FFIErrorBadExternalLibrary := 16.
	"external function invalid"
	FFIErrorBadExternalFunction := 17.
	"ExternalAddress points to ST memory (don't you dare to do this!!)"
	FFIErrorInvalidPointer := 18.
	"Stack frame required more than 16k bytes to pass arguments."
	FFIErrorCallFrameTooBig := 19! !

!ExternalFunction class methodsFor: 'class initialization' stamp: 'ar 5/18/2003 18:53'!
       initializeErrorMessages
	"ExternalFunction initializeErrorConstants"
	FFIErrorMessages := Dictionary new.
	FFIErrorMessages
		at: FFINoCalloutAvailable put: 'Callout mechanism not available';
		at: FFIErrorGenericError put: 'A call to an external function failed';
		at: FFIErrorNotFunction put: 'Only ExternalFunctions can be called';
		at: FFIErrorBadArgs put: 'Bad arguments in primitive invokation';
		at: FFIErrorBadArg put: 'Bad argument for external function';
		at: FFIErrorIntAsPointer put: 'Cannot use integer as pointer';
		at: FFIErrorBadAtomicType put: 'Unknown atomic type in external call';
		at: FFIErrorCoercionFailed put: 'Could not coerce arguments';
		at: FFIErrorWrongType put: 'Wrong type in external call';
		at: FFIErrorStructSize put: 'Bad structure size in external call';
		at: FFIErrorCallType put: 'Unsupported calling convention';
		at: FFIErrorBadReturn put: 'Cannot return the given type';
		at: FFIErrorBadAddress put: 'Bad function address';
		at: FFIErrorNoModule put: 'No module to load address from';
		at: FFIErrorAddressNotFound put: 'Unable to find function address';
		at: FFIErrorAttemptToPassVoid put: 'Cannot pass ''void'' parameter';
		at: FFIErrorModuleNotFound put: 'External module not found';
		at: FFIErrorBadExternalLibrary put: 'External library is invalid';
		at: FFIErrorBadExternalFunction put: 'External function is invalid';
		at: FFIErrorInvalidPointer put: 'Attempt to pass invalid pointer';
	yourself! !

!ExternalType class methodsFor: 'class initialization' stamp: 'ar 8/14/2006 23:13'!
                   initializeFFIConstants
	"ExternalType initialize"
	FFIConstants initialize. "ensure proper initialization"
	AtomicTypeNames := IdentityDictionary new.
	AtomicSelectors := IdentityDictionary new.
	AtomicTypeNames
		at: FFITypeVoid put: 'void';
		at: FFITypeBool put: 'bool';
		at: FFITypeUnsignedByte put: 'byte';
		at: FFITypeSignedByte put: 'sbyte';
		at: FFITypeUnsignedShort put: 'ushort';
		at: FFITypeSignedShort put: 'short';
		at: FFITypeUnsignedInt put: 'ulong';
		at: FFITypeSignedInt put: 'long';
		at: FFITypeUnsignedLongLong put: 'ulonglong';
		at: FFITypeSignedLongLong put: 'longlong';
		at: FFITypeUnsignedChar put: 'char';
		at: FFITypeSignedChar put: 'schar';
		at: FFITypeSingleFloat put: 'float';
		at: FFITypeDoubleFloat put: 'double';
	yourself.

	AtomicSelectors
		at: FFITypeVoid put: #voidAt:;
		at: FFITypeBool put: #booleanAt:;
		at: FFITypeUnsignedByte put: #unsignedByteAt:;
		at: FFITypeSignedByte put: #signedByteAt:;
		at: FFITypeUnsignedShort put: #unsignedShortAt:;
		at: FFITypeSignedShort put: #signedShortAt:;
		at: FFITypeUnsignedInt put: #unsignedLongAt:;
		at: FFITypeSignedInt put: #signedLongAt:;
		at: FFITypeUnsignedLongLong put: #unsignedLongLongAt:;
		at: FFITypeSignedLongLong put: #signedLongLongAt:;
		at: FFITypeUnsignedChar put: #unsignedCharAt:;
		at: FFITypeSignedChar put: #signedCharAt:;
		at: FFITypeSingleFloat put: #floatAt:;
		at: FFITypeDoubleFloat put: #doubleAt:;
	yourself! !

!ExternalType class methodsFor: 'class initialization' stamp: 'ar 3/22/2007 20:14'!
             initializeStructureTypes
	"ExternalType initialize"
	| referentClass pointerType |
	self cleanupUnusedTypes.
	StructTypes keysAndValuesDo:[:referentName :type|
		referentClass := (Smalltalk at: referentName ifAbsent:[nil]).
		(referentClass isBehavior and:[
			referentClass includesBehavior: ExternalStructure])
				ifFalse:[referentClass := nil].
		type compiledSpec: 
			(WordArray with: self structureSpec).
		type newReferentClass: referentClass.
		pointerType := type asPointerType.
		pointerType compiledSpec: 
			(WordArray with: self pointerSpec).
		pointerType newReferentClass: referentClass.
	].! !

!FFIConstants class methodsFor: 'pool initialization' stamp: 'ar 5/18/2003 18:34'!
         initializeTypeConstants
	"type void"
	FFITypeVoid := 0.

	"type bool"
	FFITypeBool := 1.

	"basic integer types.
	note: (integerType anyMask: 1) = integerType isSigned"

	FFITypeUnsignedByte := 2.
	FFITypeSignedByte := 3.
	FFITypeUnsignedShort := 4.
	FFITypeSignedShort := 5.
	FFITypeUnsignedInt := 6.
	FFITypeSignedInt := 7.

	"64bit types"
	FFITypeUnsignedLongLong := 8.
	FFITypeSignedLongLong := 9.

	"special integer types"
	FFITypeUnsignedChar := 10.
	FFITypeSignedChar := 11.

	"float types"
	FFITypeSingleFloat := 12.
	FFITypeDoubleFloat := 13.

	"type flags"
	FFIFlagAtomic := 16r40000. "type is atomic"
	FFIFlagPointer := 16r20000. "type is pointer to base type"
	FFIFlagStructure := 16r10000. "baseType is structure of 64k length"
	FFIStructSizeMask := 16rFFFF. "mask for max size of structure"
	FFIAtomicTypeMask := 16r0F000000. "mask for atomic type spec"
	FFIAtomicTypeShift := 24. "shift for atomic type"
! !

!ExternalObject class methodsFor: 'system startup' stamp: 'ar 11/28/1999 23:37'!
                   install
	"Notify all instances of the receiver that we're coming up on a new platform.
	Note: The default implementation does nothing since the general external
	objects are cleaned up by ExternalAddress>>startUp: but subclasses may
	implement this method so that the appropriate action for existing instances can
	be taken."! !

!ExternalObject class methodsFor: 'system startup' stamp: 'ar 11/28/1999 23:36'!
     installSubclasses
	"Notify all the subclasses of ExternalObject that we are starting up on a new platform."
	self withAllSubclassesDo:[:cls| cls install].! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/28/1999 23:56'!
     integerAt: byteOffset put: value size: nBytes signed: aBoolean
	"Primitive. Store the given value as integer of nBytes size
	in the receiver. Fail if the value is out of range.
	Note: This primitive will access memory in the outer space if
	invoked from ExternalAddress."
	<primitive: 'primitiveFFIIntegerAtPut' module:'SqueakFFIPrims'>
	^self primitiveFailed! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/28/1999 23:55'!
                        integerAt: byteOffset size: nBytes signed: aBoolean
	"Primitive. Return an integer of nBytes size from the receiver.
	Note: This primitive will access memory in the outer space if
	invoked from ExternalAddress."
	<primitive: 'primitiveFFIIntegerAt' module:'SqueakFFIPrims'>
	^self primitiveFailed! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 11/19/1999 21:54'!
            invoke
	^self invokeWithArguments: #()! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 11/19/1999 21:53'!
              invokeWith: arg1
	^self invokeWithArguments: (Array with: arg1)! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 11/19/1999 21:53'!
                     invokeWith: arg1 with: arg2
	^self invokeWithArguments: (Array with: arg1 with: arg2)! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 11/19/1999 21:53'!
                               invokeWith: arg1 with: arg2 with: arg3
	^self invokeWithArguments: (Array with: arg1 with: arg2 with: arg3)! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 11/19/1999 19:08'!
         invokeWith: arg1 with: arg2 with: arg3 with: arg4
	^self invokeWithArguments: (Array with: arg1 with: arg2 with: arg3 with: arg4)! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 11/19/1999 21:53'!
                   invokeWith: arg1 with: arg2 with: arg3 with: arg4 with: arg5
	^self invokeWithArguments: (Array with: arg1 with: arg2 with: arg3 with: arg4 with: arg5)! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 11/19/1999 21:54'!
                             invokeWith: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6
	^self invokeWithArguments: (Array with: arg1 with: arg2 with: arg3 with: arg4 with: arg5 with: arg6)! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 11/28/1999 20:12'!
       invokeWithArguments: argArray
	"Manually invoke the receiver, representing an external function."
	<primitive: 'primitiveCalloutWithArgs' module:'SqueakFFIPrims'>
	^self externalCallFailed! !

!ExternalType methodsFor: 'testing' stamp: 'ar 12/2/1999 20:27'!
                              isAtomic
	"Return true if the receiver describes a built-in type"
	^self headerWord anyMask: FFIFlagAtomic! !

!ByteArray methodsFor: '*FFI-Kernel' stamp: 'jcg 6/4/2010 02:40'!
               isExternalAddress
	"Return true if the receiver describes the address of an object in the outside world"
	^false! !

!ExternalAddress methodsFor: 'accessing' stamp: 'jcg 6/4/2010 02:40'!
     isExternalAddress
	"Return true if the receiver describes the address of an object in the outside world"
	^true! !

!ExternalObject methodsFor: 'testing' stamp: 'jcg 6/4/2010 02:40'!
         isExternalAddress
	"Return true if the receiver describes the address of an object in the outside world"
	^false! !

!ExternalType methodsFor: 'testing' stamp: 'ar 12/2/1999 14:14'!
          isIntegerType
	"Return true if the receiver is a built-in integer type"
	| type |
	type := self atomicType.
	^type > FFITypeBool and:[type <= FFITypeUnsignedLongLong]! !

!ByteArray methodsFor: '*FFI-Kernel' stamp: 'ar 11/16/2006 15:35'!
                  isNull
	"Answer false since only external addresses can be null"
	^false! !

!ExternalAddress methodsFor: 'testing' stamp: 'ar 11/16/2006 15:35'!
              isNull
	"Answer true if I am a null pointer"
	1 to: self size do:[:i| (self at: i) = 0 ifFalse:[^false]].
	^true! !

!ExternalObject methodsFor: 'testing' stamp: 'ar 11/16/2006 15:36'!
       isNull
	"Answer true if the receiver currently is a NULL pointer"
	^handle == nil or:[handle isNull]! !

!ExternalType methodsFor: 'testing' stamp: 'ar 1/27/2000 00:29'!
                      isPointerType
	"Return true if the receiver represents a pointer type"
	^self isStructureType not and:[self headerWord anyMask: FFIFlagPointer]! !

!ExternalType methodsFor: 'testing' stamp: 'ar 12/2/1999 14:15'!
           isSigned
	"Return true if the receiver is a signed type.
	Note: Only useful for integer types."
	^self atomicType anyMask: 1! !

!ExternalType methodsFor: 'testing' stamp: 'ar 12/2/1999 14:15'!
                              isStructureType
	"Return true if the receiver represents a structure type"
	^self headerWord anyMask: FFIFlagStructure! !

!ExternalType methodsFor: 'testing' stamp: 'ar 11/18/1999 18:28'!
   isUnsigned
	"Return true if the receiver is an unsigned type.
	Note: Only useful for integer types."
	^self isSigned not! !

!ExternalFunction class methodsFor: 'compiler support' stamp: 'ar 12/2/1999 16:30'!
               isValidType: anObject
	^anObject isBehavior and:[anObject includesBehavior: ExternalStructure]! !

!ExternalType methodsFor: 'testing' stamp: 'ar 12/2/1999 14:16'!
                            isVoid
	"Return true if the receiver describes a plain 'void' type"
	^self isAtomic and:[self atomicType = 0]! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 11/22/1999 13:10'!
                               long
	^self signedLong! !

!ExternalStructure methodsFor: 'printing' stamp: 'jmv 3/13/2012 12:33'!
                             longPrintOn: aStream 
	"Append to the argument, aStream, the names and values of all the record's variables."
	| fields |
	fields := self class fields.
	(fields isEmpty or: [fields first isNil]) ifTrue: [fields := #()]
		ifFalse: [(fields first isKindOf: Array) ifFalse: [fields := Array with: fields]].
	fields do: [ :field |
		field first notNil ifTrue: [
			aStream nextPutAll: field first; nextPut: $:; space; tab.
			(self perform: field first) printOn: aStream.
			aStream newLine]].! !

!ExternalFunction methodsFor: 'accessing' stamp: 'ar 11/17/1999 19:55'!
          module
	^nil! !

!ExternalLibraryFunction methodsFor: 'accessing' stamp: 'ar 11/17/1999 19:55'!
module
	^module! !

!ExternalLibrary class methodsFor: 'accessing' stamp: 'ar 11/17/1999 19:33'!
                               moduleName
	"Return the name of the module for this library"
	^nil! !

!ExternalFunction methodsFor: 'accessing' stamp: 'ar 11/17/1999 17:06'!
                 name
	^nil! !

!ExternalLibrary methodsFor: 'accessing' stamp: 'ar 11/17/1999 19:35'!
          name
	^name! !

!ExternalLibraryFunction methodsFor: 'accessing' stamp: 'ar 11/17/1999 17:06'!
 name
	^name! !

!ExternalLibraryFunction class methodsFor: 'instance creation' stamp: 'ar 11/17/1999 14:52'!
                   name: aName module: aModule callType: callType returnType: retType argumentTypes: argTypes
	^self new
		name: aName
		module: aModule
		flags: callType
		argTypes: (Array with: retType), argTypes! !

!ExternalLibraryFunction methodsFor: 'private' stamp: 'ar 11/19/1999 19:12'!
           name: aName module: aModule flags: anInteger argTypes: argTypeArray

	name := aName.
	module := aModule.
	flags := anInteger.
	argTypes := argTypeArray.! !

!ExternalAddress class methodsFor: 'instance creation' stamp: 'ar 11/21/1999 15:44'!
              new
	"External addresses are always 4 bytes long"
	^super new: 4! !

!ExternalData class methodsFor: 'instance creation' stamp: 'ar 11/22/1999 04:28'!
         new
	"You better not..."
	^self shouldNotImplement! !

!ExternalStructure class methodsFor: 'instance creation' stamp: 'ar 12/1/1999 15:58'!
                   new
	^self fromHandle: (ByteArray new: self byteSize)! !

!ExternalType class methodsFor: 'instance creation' stamp: 'ar 1/26/2000 14:58'!
                     new
	"Use either the type constants or #externalType for creating external types"
	^self shouldNotImplement! !

!ExternalAddress class methodsFor: 'instance creation' stamp: 'ar 11/21/1999 15:44'!
                           new: n
	"You better don't try this..."
	^self shouldNotImplement! !

!ExternalType methodsFor: 'private' stamp: 'ar 12/2/1999 20:30'!
                          newReferentClass: aClass
	"The class I'm referencing has changed. Update my spec."
	referentClass := aClass.
	self isPointerType ifTrue:[^self]. "for pointers only the referentClass changed"
	referentClass == nil ifTrue:[
		"my class has been removed - make me 'struct { void }'"
		compiledSpec := WordArray with: (FFIFlagStructure).
	] ifFalse:[
		"my class has been changed - update my compiledSpec"
		compiledSpec := referentClass compiledSpec.
	].! !

!ExternalType class methodsFor: 'private' stamp: 'ar 1/26/2000 21:41'!
                 newTypeNamed: aString force: aBool
	| sym type referentClass pointerType |
	sym := aString asSymbol.
	type := StructTypes at: aString ifAbsent:[nil].
	type == nil ifFalse:[^type].
	referentClass := Smalltalk at: sym ifAbsent:[nil].
	(referentClass isBehavior and:[referentClass includesBehavior: ExternalStructure])
		ifFalse:[referentClass := nil].
	"If we don't have a referent class and are not forced to create a type get out"
	(referentClass == nil and:[aBool not]) ifTrue:[^nil].
	type := self basicNew compiledSpec: 
		(WordArray with: self structureSpec).
	pointerType := self basicNew compiledSpec: 
		(WordArray with: self pointerSpec).
	type setReferencedType: pointerType.
	pointerType setReferencedType: type.
	type newReferentClass: referentClass.
	pointerType newReferentClass: referentClass.
	StructTypes at: sym put: type.
	^type! !

!ExternalType class methodsFor: 'housekeeping' stamp: 'ar 12/2/1999 17:58'!
 noticeModificationOf: aClass
	"A subclass of ExternalStructure has been redefined.
	Clean out any obsolete references to its type."
	| type |
	aClass isBehavior ifFalse:[^nil]. "how could this happen?"
	aClass withAllSubclassesDo:[:cls|
		type := StructTypes at: cls name ifAbsent:[nil].
		type == nil ifFalse:[
			type newReferentClass: cls.
			type asPointerType newReferentClass: cls].
	].! !

!ExternalType class methodsFor: 'housekeeping' stamp: 'ar 12/2/1999 17:59'!
       noticeRemovalOf: aClass
	"A subclass of ExternalStructure is being removed.
	Clean out any obsolete references to its type."
	| type |
	type := StructTypes at: aClass name ifAbsent:[nil].
	type == nil ifFalse:[
		type newReferentClass: nil.
		type asPointerType newReferentClass: nil].
! !

!ExternalType class methodsFor: 'housekeeping' stamp: 'ar 12/2/1999 16:14'!
                 noticeRenamingOf: aClass from: oldName to: newName
	"An ExternalStructure has been renamed from oldName to newName.
	Keep our type names in sync."
	| type |
	type := StructTypes at: oldName ifAbsent:[nil].
	type == nil ifFalse:[StructTypes at: newName put: type].
	StructTypes removeKey: oldName ifAbsent:[].! !

!ExternalStructure class methodsFor: 'class management' stamp: 'sma 6/16/2000 22:12'!
                 obsolete
	"The receiver is becoming obsolete. 
	NOTE: You if you remove the whole class category at once, you cannot
	assume that the ExternalType class is still present."

	Smalltalk at: #ExternalType ifPresent: [:class | class noticeRemovalOf: self].
	^ super obsolete! !

!ExternalForm methodsFor: 'accessing' stamp: 'jcg 2/16/2010 00:01'!
         pointer
	^pointer! !

!ByteArray methodsFor: '*FFI-Kernel' stamp: 'ar 11/28/1999 23:15'!
       pointerAt: byteOffset
	"Return a pointer object stored at the given byte address"
	| addr |
	addr := ExternalAddress new.
	1 to: 4 do:[:i|
		addr basicAt: i put: (self unsignedByteAt: byteOffset+i-1)].
	^addr! !

!ByteArray methodsFor: '*FFI' stamp: 'jmv 3/24/2009 14:57'!
               pointerAt: byteOffset put: value
	"Store a pointer object at the given byte address"
	
	value isExternalAddress ifFalse:[ ^self error:'Only external addresses can be stored' ].
	1 to: 4 do: [ :i |
		self unsignedByteAt: byteOffset+i-1 put: (value basicAt: i)].
	^value! !

!ExternalType class methodsFor: 'private' stamp: 'ar 12/2/1999 20:33'!
        pointerSpec
	^(4 bitOr: FFIFlagPointer)! !

!ExternalForm methodsFor: 'primitives' stamp: 'jcg 1/30/2010 02:52'!
               primCreateManualSurfaceWidth: width height: height rowPitch: rowPitch depth: depth isMSB: isMSB
	<primitive: 'primitiveCreateManualSurface' module: 'SqueakFFIPrims'>
	self primitiveFailed
! !

!ExternalForm methodsFor: 'primitives' stamp: 'jcg 1/30/2010 02:52'!
                          primDestroyManualSurface: surfaceID
	<primitive: 'primitiveDestroyManualSurface' module: 'SqueakFFIPrims'>
	self primitiveFailed
! !

!ExternalForm methodsFor: 'primitives' stamp: 'jcg 1/30/2010 02:52'!
                     primManualSurface: surfaceID setPointer: pointer
	"The 'surfaceID' is a handle returned by #primitiveCreateManualSurface from SurfacePlugin. The pointer is a 32-bit unsigned integer that SurfacePlugin casts to a void*."
	<primitive: 'primitiveSetManualSurfacePointer' module: 'SqueakFFIPrims'>
	self primitiveFailed
! !

!ExternalAddress methodsFor: 'printing' stamp: 'laza 3/29/2004 18:33'!
                        printOn: aStream
	"print this as a hex address ('@ 16rFFFFFFFF') to distinguish it from ByteArrays"

	aStream nextPutAll: '@ '; nextPutAll: (self asInteger storeStringBase: 16 length: 11 padded: true)! !

!ExternalFunction methodsFor: 'printing' stamp: 'ar 11/19/1999 19:12'!
            printOn: aStream
	aStream
		nextPut:$<;
		nextPutAll: self callingConventionString; nextPutAll:': ';
		print: argTypes first; space.
	self name == nil
		ifTrue:[aStream nextPutAll:'(*) ']
		ifFalse:[aStream print: self name asString; space].
	aStream nextPut:$(.
	2 to: argTypes size do:[:i|
		aStream print: (argTypes at: i).
		i < argTypes size ifTrue:[aStream space]].
	aStream nextPut:$).
	self module == nil ifFalse:[
		aStream space; nextPutAll:'module: '; print: self module asString.
	].
	aStream nextPut:$>! !

!ExternalType methodsFor: 'printing' stamp: 'ar 12/2/1999 17:02'!
                      printOn: aStream
	referentClass == nil
		ifTrue:[aStream nextPutAll: (AtomicTypeNames at: self atomicType)]
		ifFalse:[aStream nextPutAll: referentClass name].
	self isPointerType ifTrue:[aStream nextPut: $*].! !

!ExternalType methodsFor: 'private' stamp: 'ar 12/2/1999 18:13'!
         readFieldAt: byteOffset
	"Return a string defining the accessor to an entity of the receiver type starting at the given byte offset. 
	Private. Used for field definition only."
	self isPointerType ifTrue:[
		referentClass == nil ifTrue:[
			^String streamContents:[:s|
				s nextPutAll:'^ExternalData fromHandle: (handle pointerAt: ';
					print: byteOffset;
					nextPutAll:') type: ExternalType ';
					nextPutAll: (AtomicTypeNames at: self atomicType);
					nextPutAll: ' asPointerType']].
		^String streamContents:[:s|
			s nextPutAll:'^';
				print: referentClass;
				nextPutAll:' fromHandle: (handle pointerAt: ';
				print: byteOffset;
				nextPutAll:')']].

	(self isAtomic) ifFalse:["structure type"
		^String streamContents:[:s|
			s nextPutAll:'^';
				print: referentClass;
				nextPutAll:' fromHandle: (handle structAt: ';
				print: byteOffset;
				nextPutAll:' length: ';
				print: self byteSize;
				nextPutAll:')']].

	"Atomic non-pointer types"
	^String streamContents:[:s|
		s nextPutAll:'^handle ';
			nextPutAll: (AtomicSelectors at: self atomicType);
			space; print: byteOffset].! !

!ExternalType methodsFor: 'accessing' stamp: 'ar 12/2/1999 14:11'!
        referentClass
	"Return the class specifying the receiver"
	^referentClass! !

!ExternalStructure class methodsFor: 'class management' stamp: 'ar 11/22/1999 04:12'!
                            rename: aString
	| oldName |
	oldName := name.
	super rename: aString.
	oldName = name ifFalse:[ExternalType noticeRenamingOf: self from: oldName to: name].! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 11/28/1999 23:43'!
                sbyte
	^self signedByte! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 11/28/1999 23:43'!
                     schar
	^self signedChar! !

!ExternalForm methodsFor: 'initialize' stamp: 'jcg 1/26/2010 02:00'!
                               setExtent: extent depth: bitsPerPixel
	bits ifNotNil: [self error: 'bits are already set'].
	bitsPerPixel == 32 ifFalse: [self error: 'only 32 bits for now'.  "see 'rowPitch' below"].
	width := extent x asInteger.
	width < 0 ifTrue: [width := 0].
	height := extent y asInteger.
	height < 0 ifTrue: [height := 0].
	depth := bitsPerPixel.
	bits := self 
		primCreateManualSurfaceWidth: width 
		height: height 
		rowPitch: width * 4
		depth: bitsPerPixel
		isMSB: true.! !

!ExternalForm methodsFor: 'initialize' stamp: 'jcg 1/29/2010 01:31'!
   setExtent: extent depth: bitsPerPixel bits: pointer
	self setExtent: extent depth: bitsPerPixel.
	self setManualSurfacePointer: pointer.! !

!ExternalObject methodsFor: 'private' stamp: 'ar 11/16/1999 20:26'!
               setHandle: anObject
	"Private. Set the handle used to represent the external entity."
	handle := anObject! !

!ExternalData methodsFor: 'private' stamp: 'ar 11/21/1999 14:23'!
                setHandle: aHandle type: aType
	handle := aHandle.
	type := aType.! !

!ExternalForm methodsFor: 'initialize' stamp: 'jmv 1/13/2011 10:57'!
                    setManualSurfacePointer: newPointer "ExternalStructure, ExternalAddress, or nil"
	"Set the memory-location of the image data.  It is OK to set a NULL pointer; in this case, any attempt to BitBlt to or from the form will result in a primitive-failure."
	| integer |
	pointer := newPointer.
	pointer ifNil: [^self primManualSurface: bits setPointer: 0].
	pointer isExternalAddress
		ifFalse: ["must already be ExternalStructure, so nothing to do"]
		ifTrue: [pointer := ExternalData 
							fromHandle: newPointer 
							type: ExternalType void asPointerType].
	"The primitive expects an unsigned integer arg, not an ExternalAddress."
	"NOTE: it used to be acceptable for 'newPointer' to be an Integer... 
	 if you get a MNU for #getHandle here, you should update your code 
	 to pass in either an ExternalStructure or an ExternalAddress."
	integer := pointer getHandle 
				unsignedLongAt: 1 
				bigEndian: Smalltalk isBigEndian.
	self primManualSurface: bits setPointer: integer.! !

!ExternalLibraryFunction methodsFor: 'accessing' stamp: 'das 5/23/2005 10:50'!
                       setModule: aString
	"Private. Hack the module"
	module := aString.! !

!ExternalType methodsFor: 'private' stamp: 'ar 12/2/1999 16:41'!
                        setReferencedType: aType
	referencedType := aType! !

!ExternalAddress methodsFor: 'copying' stamp: 'ar 5/23/2006 13:09'!
      shallowCopy
	"Re-implemented to avoid superclass call to #new:"
	^self clone! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 11/20/1999 17:26'!
short
	^self signedShort! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:57'!
                     signedByte
	^AtomicTypes at: 'sbyte'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 01:39'!
                           signedByteAt: byteOffset
	"Return a 8bit signed integer starting at the given byte offset"
	^self integerAt: byteOffset size: 1 signed: true! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 01:39'!
                   signedByteAt: byteOffset put: value
	"Store a 8bit signed integer starting at the given byte offset"
	^self integerAt: byteOffset put: value size: 1 signed: true! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:57'!
            signedChar
	^AtomicTypes at: 'schar'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/28/1999 23:53'!
                           signedCharAt: byteOffset
	^(self unsignedByteAt: byteOffset) asCharacter! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/28/1999 23:54'!
                       signedCharAt: byteOffset put: aCharacter
	^self unsignedByteAt: byteOffset put: aCharacter asciiValue! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:57'!
        signedLong
	^AtomicTypes at: 'long'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 15:54'!
                            signedLongAt: byteOffset
	"Return a 32bit signed integer starting at the given byte offset"
	^self integerAt: byteOffset size: 4 signed: true! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 15:54'!
                  signedLongAt: byteOffset put: value
	"Store a 32bit signed integer starting at the given byte offset"
	^self integerAt: byteOffset put: value size: 4 signed: true! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:57'!
           signedLongLong
	^AtomicTypes at: 'longlong'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:16'!
                    signedLongLongAt: byteOffset
	"This is not yet supported"
	^self notYetImplemented! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:17'!
             signedLongLongAt: byteOffset put: value
	"This is not yet supported"
	^self notYetImplemented! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:57'!
                signedShort
	^AtomicTypes at: 'short'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 15:54'!
                          signedShortAt: byteOffset
	"Return a 16bit signed integer starting at the given byte offset"
	^self integerAt: byteOffset size: 2 signed: true! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 15:54'!
                 signedShortAt: byteOffset put: value
	"Store a 16bit signed integer starting at the given byte offset"
	^self integerAt: byteOffset put: value size: 2 signed: true! !

!ExternalAddress class methodsFor: 'class initialization' stamp: 'ar 11/28/1999 23:32'!
startUp: resuming
	resuming ifTrue:[self allInstancesDo:[:addr| addr beNull]].! !

!ExternalObject class methodsFor: 'system startup' stamp: 'ar 11/28/1999 23:36'!
                            startUp: resuming
	"The system is coming up. If it is on a new platform, clear out the existing handles."
	ExternalAddress startUp: resuming. "Make sure handles are invalid"
	resuming ifTrue:[self installSubclasses].
! !

!ExternalType methodsFor: 'printing' stamp: 'nice 5/21/2006 21:40'!
                              storeOn: aStream
	referentClass == nil
		ifTrue:[aStream nextPutAll: ExternalType name; space; nextPutAll: (AtomicTypeNames at: self atomicType)]
		ifFalse:[aStream nextPut: $(; nextPutAll: ExternalType name; space; nextPutAll: #structTypeNamed:; space;  store: referentClass name; nextPut: $)].
	self isPointerType ifTrue: [aStream space; nextPutAll: #asPointer].! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:57'!
 string
	^(AtomicTypes at: 'char') asPointerType! !

!ByteArray methodsFor: '*FFI' stamp: 'jmv 3/24/2009 14:57'!
                structAt: byteOffset length: length
	"Return a structure of the given length starting at the indicated byte offset."
	
	| value |
	value _ ByteArray new: length.
	1 to: length do: [:i |
		value unsignedByteAt: i put: (self unsignedByteAt: byteOffset+i-1)].
	^value! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/28/1999 21:11'!
                       structAt: byteOffset put: value length: length
	"Store a structure of the given length starting at the indicated byte offset."
	1 to: length do:[:i|
		self unsignedByteAt: byteOffset+i-1 put: (value unsignedByteAt: i)].
	^value! !

!ExternalFunction class methodsFor: 'compiler support' stamp: 'ar 12/2/1999 16:21'!
    structTypeNamed: aString
	^ExternalType structTypeNamed: aString! !

!ExternalType class methodsFor: 'private' stamp: 'ar 12/2/1999 16:48'!
                    structTypeNamed: aSymbol
	aSymbol == nil ifTrue:[^nil].
	^self newTypeNamed: aSymbol force: false! !

!ExternalType class methodsFor: 'private' stamp: 'ar 12/2/1999 20:34'!
                   structureSpec
	^FFIFlagStructure! !

!ExternalFunction methodsFor: 'invoking' stamp: 'ar 8/2/2009 10:49'!
                      tryInvokeWithArguments: argArray
	"Sent from the debugger to simulate an FFI call."
	<primitive: 'primitiveCalloutWithArgs' module:'SqueakFFIPrims'>
	^ContextPart primitiveFailToken! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 11/28/1999 23:44'!
                       ulong
	^self unsignedLong! !

!ExternalFunction class methodsFor: 'class initialization' stamp: 'ar 3/9/2010 21:45'!
           unload
	"Clean out the splObj array"
	Smalltalk specialObjectsArray from: 44 to: 48 put: nil.
! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:57'!
               unsignedByte
	^AtomicTypes at: 'byte'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 01:40'!
                          unsignedByteAt: byteOffset
	"Return a 8bit unsigned integer starting at the given byte offset"
	^self integerAt: byteOffset size: 1 signed: false! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 01:40'!
              unsignedByteAt: byteOffset put: value
	"Store a 8bit unsigned integer starting at the given byte offset"
	^self integerAt: byteOffset put: value size: 1 signed: false! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:58'!
       unsignedChar
	^AtomicTypes at: 'char'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/28/1999 23:53'!
                          unsignedCharAt: byteOffset
	^(self unsignedByteAt: byteOffset) asCharacter! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/28/1999 23:54'!
                     unsignedCharAt: byteOffset put: aCharacter
	^self unsignedByteAt: byteOffset put: aCharacter asciiValue! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:58'!
      unsignedLong
	^AtomicTypes at: 'ulong'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 01:23'!
                         unsignedLongAt: byteOffset
	"Return a 32bit unsigned integer starting at the given byte offset"
	^self integerAt: byteOffset size: 4 signed: false! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 01:23'!
             unsignedLongAt: byteOffset put: value
	"Store a 32bit signed integer starting at the given byte offset"
	^self integerAt: byteOffset put: value size: 4 signed: false! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:58'!
        unsignedLongLong
	^AtomicTypes at: 'ulonglong'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:17'!
                 unsignedLongLongAt: byteOffset
	"This is not yet supported"
	^self notYetImplemented! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:17'!
           unsignedLongLongAt: byteOffset put: value
	"This is not yet supported"
	^self notYetImplemented! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:58'!
              unsignedShort
	^AtomicTypes at: 'ushort'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 00:55'!
                       unsignedShortAt: byteOffset
	"Return a 16bit unsigned integer starting at the given byte offset"
	^self integerAt: byteOffset size: 2 signed: false! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/21/1999 00:56'!
            unsignedShortAt: byteOffset put: value
	"Store a 16bit unsigned integer starting at the given byte offset"
	^self integerAt: byteOffset put: value size: 2 signed: false! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 11/28/1999 23:44'!
    ushort
	^self unsignedShort! !

!ExternalType class methodsFor: 'type constants' stamp: 'ar 12/2/1999 16:58'!
                  void
	^AtomicTypes at: 'void'! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:16'!
  voidAt: byteOffset
	"no accessors for void"
	^self shouldNotImplement! !

!ByteArray methodsFor: '*FFI' stamp: 'ar 11/29/1999 00:16'!
                          voidAt: byteOffset put: value
	"no accessors for void"
	^self shouldNotImplement! !

!ExternalType methodsFor: 'private' stamp: 'ar 12/2/1999 14:53'!
          writeFieldAt: byteOffset with: valueName
	"Return a string defining the accessor to an entity 
	of the receiver type starting at the given byte offset. 
	Private. Used for field definition only."

	self isPointerType ifTrue:[
		^String streamContents:[:s|
			s nextPutAll:'handle pointerAt: ';
				print: byteOffset;
				nextPutAll:' put: ';
				nextPutAll: valueName;
				nextPutAll:' getHandle.']].

	self isAtomic ifFalse:[
		^String streamContents:[:s|
			s nextPutAll:'handle structAt: ';
				print: byteOffset;
				nextPutAll:' put: ';
				nextPutAll: valueName;
				nextPutAll:' getHandle';
				nextPutAll:' length: ';
				print: self byteSize;
				nextPutAll:'.']].

	^String streamContents:[:s|
		s nextPutAll:'handle ';
			nextPutAll: (AtomicSelectors at: self atomicType);
			space; print: byteOffset;
			nextPutAll:' put: ';
			nextPutAll: valueName].! !
ExternalFunction initialize!
ExternalObject initialize!
ExternalType initialize!
FFIConstants initialize!

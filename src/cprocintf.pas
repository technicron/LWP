// Ingemar's partial clib.// Many of these functions also exist in the FPC library, as FpPipe etc.// See rtl/unix/oscdeclh.inc// But I redeclare them with original names to keep it cleaner (IMHO).// This is only a partial solution! Many important calls are missing.// Version 2.0// Improved version 080328, adding several calls and many constants// including fcntl constants, pthreads and signals// Version 2.1, 080402// Corrected errno.// Version 2.2, 090121.// Added time() and time_t.// Version... whatever 151009// Added file I/O, fopen etc.unit cprocintf;interfaceuses SysUtils, unixutil;const  FIONREAD          = $4004667f; // finns i TermIO// int = Longint? cinttype	cint = Longint;	pid_t = Longint;	size_t = Longint;	culong  =cardinal;	TSize    = size_t;	TsSize = Longint;	time_t = Longint;	TFilDes = Array [0..1] of cInt;	PFILE = Pointer; // P_IO_FILE;const   _IOFBF = 0;   _IOLBF = 1;   _IONBF = 2;function pipe(var fildes : TFilDes): cint;cdecl; external 'clib' name 'pipe';//function execl(const char *, const char *, ...): Longint;function execl(__path:Pchar; __arg:Pchar; args: PChar):longint; cdecl; external 'clib' name 'execl';//function execle(const char *, const char *, ...): Longint;//function execlp(const char *, const char *, ...): Longint;function execv(path: PChar; argv: PPChar): cint;cdecl;  external 'clib' name 'execv'; // argv �r pekare till array//function execve(const char *, char * const *, char * const *): Longint;cdecl;function execvp({filename,} search_path: PChar; argv: PPChar): cint;cdecl; external 'clib' name 'execvp';function dup(oldd: cint): cint;cdecl; external 'clib' name 'dup';function dup2(oldd, newd: cint): cint;cdecl; external 'clib' name 'dup2';function fork(): Longint;cdecl; external 'clib' name 'fork';function setvbuf(stream: PFILE; buf: PChar; mode: cint; theSize: size_t): cint; cdecl; external 'clib' name 'setvbuf';function sleep(time: cint): cint; cdecl; external 'clib' name 'sleep';function usleep(time: cint): cint; cdecl; external 'clib' name 'usleep';function time(p: Pointer): time_t; cdecl; external 'clib' name 'time';function memcpy(dest, source: Pointer; count: size_t): Pointer; cdecl; external 'clib' name 'memcpy';function malloc(amnt: Longint): Pointer;cdecl; external 'clib' name 'malloc';//    function  fpNice       (N:cint):cint; cdecl; external clib name 'nice';//    Function  FpFcntl      (fildes : cInt; cmd : cInt): cInt; cdecl; external clib name 'fcntl';//    Function  FpFcntl      (fildes : cInt; cmd : cInt; arg :cInt): cInt; cdecl; external clib name 'fcntl';//    Function  FpFcntl      (fildes : cInt; cmd : cInt; var arg : flock): cInt; cdecl external clib name 'fcntl';//int	fcntl(int, int, ...);// Fr�n libc.pp://function fcntl(fildes:longint; cmd:longint):longint;cdecl;external 'clib' name 'fcntl';function fcntl(fildes : cInt; cmd : cInt; arg :cInt): cInt; cdecl; external 'clib' name 'fcntl';//function fcntl(fildes:longint; cmd:longint; args:array of const):longint;cdecl;external libc_nlm name 'fcntl';const {/usr/include/sys/fcntl.h}	O_NONBLOCK = $0004;		// no delay// fcntl constants:const	F_DUPFD	=	0;		// duplicate file descriptor */	F_GETFD	=	1;		// get file descriptor flags */	F_SETFD	=	2;		// set file descriptor flags */	F_GETFL	=	3;		// get file status flags */	F_SETFL	=	4;		// set file status flags */	F_GETOWN =	5;		// get SIGIO/SIGURG proc/pgrp */ F_SETOWN =	6;		// set SIGIO/SIGURG proc/pgrp */	F_GETLK	=	7;		// get record locking information */	F_SETLK	=	8;		// set record locking information */	F_SETLKW	=9;		// F_SETLK; wait if blocked */ F_CHKCLEAN   =   41;		// Used for regression test */ F_PREALLOCATE =  42;		// Preallocate storage */ F_SETSIZE    =   43;		// Truncate a file without zeroing space */	 F_RDADVISE   =   44;		// Issue an advisory read async with no copy to user */ F_RDAHEAD    =   45;		// turn read ahead off/on for this fd */ F_READBOOTSTRAP = 46;		// Read bootstrap from disk */ F_WRITEBOOTSTRAP = 47;             // Write bootstrap on disk */ F_NOCACHE   =    48;		// turn data caching off/on for this fd */ F_LOG2PHYS	= 49;		// file offset to device offset */ F_GETPATH     =  50;		// return the full path of the fd */ F_FULLFSYNC   =  51;		// fsync + ask the drive to flush to the media */ F_PATHPKG_CHECK = 52;		// find which component (if any) is a package */ F_FREEZE_FS   =  53;		// "freeze" all fs operations */ F_THAW_FS     =  54;		// "thaw" all fs operations */	F_GLOBAL_NOCACHE = 55;		// turn data caching off/on (globally) for this file */ F_ADDSIGS	=59;		// add detached signatures */ F_MARKDEPENDENCY =60;           // this process hosts the device supporting the fs backing this fd */// FS-specific fcntl()'s numbers begin at 0x00010000 and go up FCNTL_FS_SPECIFIC_BASE = $00010000;// file descriptor flags (F_GETFD, F_SETFD) */	FD_CLOEXEC	=1;		// close-on-exec flag */// record locking flags (F_GETLK, F_SETLK, F_SETLKW) */	F_RDLCK	=	1;		// shared or read lock */	F_UNLCK	=	2;		// unlock */	F_WRLCK	=	3;		// exclusive or write lock */	F_WAIT	=	$010;		// Wait until lock is granted */	F_FLOCK	=	$020;		// Use flock(2) semantics for lock */	F_POSIX	=	$040;		// Use POSIX semantics for lock */	F_PROV	=	$080;		// Non-coelesced provisional lock */	O_APPEND	=$0008;		// set append mode */	O_SYNC		=$0080;		// synchronous writes */	O_SHLOCK	=$0010;		// open with shared file lock */	O_EXLOCK	=$0020;		// open with exclusive file lock */	O_ASYNC		=$0040;		// signal pgrp when data ready */function getpid():cint; cdecl; external 'clib' name 'getpid';function  kill(pid : Longint{TPid}; sig: cInt): cInt; cdecl; external 'clib' name 'kill';function  ioctl(Handle:cint;Ndx: culong; Data: Pointer):cint; cdecl; external 'clib' name 'ioctl';function  read(fd: cint; buf: PChar; nbytes : TSize): TSSize; cdecl; external 'clib' name 'read';function  write(fd: cint;buf: PChar; nbytes : TSize): TSSize; cdecl; external 'clib' name 'write';function  close(fd : cint): cint; cdecl; external 'clib' name 'close';//		err := fpioctl(aProcess.Output.Handle, FIONREAD, @bytesAvailable);// fpioctl finns allts� - men �r den en ren ommappnig?//    function  FpIOCtl   (Handle:cint;Ndx: culong;Data: Pointer):cint; cdecl; external clib name 'ioctl';//int	 fflush(FILE *);function	fflush(stream: PFILE): cint; cdecl; external 'clib' name 'fflush';//pid_t	wait(int *);function wait(var res: cint): Longint; cdecl; external 'clib' name 'wait';function waitpid(pid: Longint; var res: cint; opt: cint): Longint; cdecl; external 'clib' name 'waitpid';//function Fpwaitpid(pid:pid_t; stat_loc:Plongint; options:longint):pid_t;cdecl;external libc_nlm name 'waitpid';//function Fpwaitpid(pid:pid_t; var stat_loc:longint; options:longint):pid_t;cdecl;external libc_nlm name 'waitpid';const	WNOHANG = 1; {Arg to waitpid}{Hur fixar jag konstanterna/globalerna sttdin/stdout/stderr?Kanske med fdopen? Om den nu g�r vad jag hoppas.#if __DARWIN_UNIX03#define	stdin	__stdinp#define	stdout	__stdoutp#define	stderr	__stderrp#else /* !__DARWIN_UNIX03 */#define stdin	(&__sF[0])#define stdout	(&__sF[1])#define stderr	(&__sF[2])#endif /* __DARWIN_UNIX03 */}{fd till FILE}function fdopen(_para1:longint; __restrict:Pchar):PFILE;cdecl;external 'clib' name 'fdopen';{FILE till fd}function fileno(_para1:PFILE):longint;cdecl;external 'clib' name 'fileno';//const// fcntl.h://	F_GETFD = 1;		// get file descriptor flags *///	F_SETFD = 2;		// set file descriptor flags */// libc.pp:// F_GETFD      = 4;        // get file descriptor flags// F_SETFD      = 5;        // set file descriptor flags//function forkpty(var amaster: cint; name: PChar; termp: Pointer; winp: Pointer): pid_t;external 'clib' name 'forkpty';// Fr�n packages/base/libc/ptyh.incfunction forkpty(__amaster:Plongint; __name:Pchar; __termp: Pointer; __winp: Pointer):longint;cdecl;external 'clib' name 'forkpty';function setenv(_para1:Pchar; _para2:Pchar; _para3:longint):longint;cdecl;external 'clib' name 'setenv';type	CIntPtr = ^cint;function errno():CIntPtr;cdecl;external 'clib' name '__error';function strerror(errnum: Longint): PChar;external 'clib' name '_strerror';// errno error constants:const	EPERM	=	1; // Operation not permitted *)	ENOENT	=	2; // No such file or directory *)	ESRCH	=	3; // No such process *)	EINTR	=	4; // Interrupted system call *)	EIO	=	5; // Input/output error *)	ENXIO	=	6; // Device not configured *)	E2BIG	=	7; // Argument list too long *)	ENOEXEC	=	8; // Exec format error *)	EBADF	=	9; // Bad file descriptor *)	ECHILD	=	10; // No child processes *)	EDEADLK	=	11; // Resource deadlock avoided *)					// 11 was EAGAIN *)	ENOMEM	=	12; // Cannot allocate memory *)	EACCES	=	13; // Permission denied *)	EFAULT	=	14; // Bad address *)	ENOTBLK	=	15; // Block device required *)	EBUSY	=	16; // Device busy *)	EEXIST	=	17; // File exists *)	EXDEV	=	18; // Cross-device link *)	ENODEV	=	19; // Operation not supported by device *)	ENOTDIR	=	20; // Not a directory *)	EISDIR	=	21; // Is a directory *)	EINVAL	=	22; // Invalid argument *)	ENFILE	=	23; // Too many open files in system *)	EMFILE	=	24; // Too many open files *)	ENOTTY	=	25; // Inappropriate ioctl for device *)	ETXTBSY	=	26; // Text file busy *)	EFBIG	=	27; // File too large *)	ENOSPC	=	28; // No space left on device *)	ESPIPE	=	29; // Illegal seek *)	EROFS	=	30; // Read-only file system *)	EMLINK	=	31; // Too many links *)	EPIPE	=	32; // Broken pipe *)(* math software *)	EDOM	=	33; // Numerical argument out of domain *)	ERANGE	=	34; // Result too large *)(* non-blocking and interrupt i/o *)	EAGAIN	=	35; // Resource temporarily unavailable *)	EWOULDBLOCK	=EAGAIN; // Operation would block *)	EINPROGRESS=	36; // Operation now in progress *)	EALREADY=	37; // Operation already in progress *)(* ipc/network software -- argument errors *)	ENOTSOCK=	38; // Socket operation on non-socket *)	EDESTADDRREQ=	39; // Destination address required *)	EMSGSIZE=	40; // Message too long *)	EPROTOTYPE=	41; // Protocol wrong type for socket *)	ENOPROTOOPT=	42; // Protocol not available *)	EPROTONOSUPPORT=	43; // Protocol not supported *)	ESOCKTNOSUPPORT=	44; // Socket type not supported *)	ENOTSUP	=	45; // Operation not supported *)(* * This is the same for binary and source copmpatability, unless compiling * the kernel itself, or compiling __DARWIN_UNIX03; if compiling for the * kernel, the correct value will be returned.  If compiling non-POSIX * source, the kernel return value will be converted by a stub in libc, and * if compiling source with __DARWIN_UNIX03, the conversion in libc is not * done, and the caller gets the expected (discrete) value. *)	EOPNOTSUPP=	 ENOTSUP; // Operation not supported on socket *)	EPFNOSUPPORT=	46; // Protocol family not supported *)	EAFNOSUPPORT=	47; // Address family not supported by protocol family *)	EADDRINUSE=	48; // Address already in use *)	EADDRNOTAVAIL=	49; // Can't assign requested address *)(* ipc/network software -- operational errors *)	ENETDOWN=	50; // Network is down *)	ENETUNREACH=	51; // Network is unreachable *)	ENETRESET=	52; // Network dropped connection on reset *)	ECONNABORTED=	53; // Software caused connection abort *)	ECONNRESET=	54; // Connection reset by peer *)	ENOBUFS	=	55; // No buffer space available *)	EISCONN	=	56; // Socket is already connected *)	ENOTCONN=	57; // Socket is not connected *)	ESHUTDOWN=	58; // Can't send after socket shutdown *)	ETOOMANYREFS=	59; // Too many references: can't splice *)	ETIMEDOUT=	60; // Operation timed out *)	ECONNREFUSED=	61; // Connection refused *)	ELOOP	=	62; // Too many levels of symbolic links *)	ENAMETOOLONG=	63; // File name too long *)(* should be rearranged *)	EHOSTDOWN=	64; // Host is down *)	EHOSTUNREACH=	65; // No route to host *)	ENOTEMPTY=	66; // Directory not empty *)(* quotas & mush *)	EPROCLIM	=67; // Too many processes *)	EUSERS	=	68; // Too many users *)	EDQUOT	=	69; // Disc quota exceeded *)(* Network File System *)	ESTALE	=	70; // Stale NFS file handle *)	EREMOTE	=	71; // Too many levels of remote in path *)	EBADRPC	=	72; // RPC struct is bad *)	ERPCMISMATCH=	73; // RPC version wrong *)	EPROGUNAVAIL=	74; // RPC prog. not avail *)	EPROGMISMATCH=	75; // Program version wrong *)	EPROCUNAVAIL=	76; // Bad procedure for program *)	ENOLCK	=	77; // No locks available *)	ENOSYS	=	78; // Function not implemented *)	EFTYPE	=	79; // Inappropriate file type or format *)	EAUTH	=	80; // Authentication error *)	ENEEDAUTH=	81; // Need authenticator *)(* Intelligent device errors *)	EPWROFF	=	82; // Device power is off *)	EDEVERR	=	83; // Device error, e.g. paper out *)	EOVERFLOW=	84; // Value too large to be stored in data type *)(* Program loading errors *)	EBADEXEC=	85; // Bad executable *)	EBADARCH=	86; // Bad CPU type in executable *)	ESHLIBVERS=	87; // Shared library version mismatch *)	EBADMACHO=	88; // Malformed Macho file *)	ECANCELED=	89; // Operation canceled *)	EIDRM	=	90; // Identifier removed *)	ENOMSG	=	91; // No message of desired type *)   	EILSEQ	=	92; // Illegal byte sequence *)	ENOATTR	=	93; // Attribute not found *)	EBADMSG	=	94; // Bad message *)	EMULTIHOP=	95; // Reserved *)	ENODATA	=	96; // No message available on STREAM *)	ENOLINK	=	97; // Reserved *)	ENOSR	=	98; // No STREAM resources *)	ENOSTR	=	99; // Not a STREAM *)	EPROTO	=	100; // Protocol error *)	ETIME	=	101; // STREAM ioctl timeout *)// pthreadstype	pthread_t = Longint; // ???	PTFuncType = function(arg: Pointer): Pointer;	function pthread_create(var thread: pthread_t;                          attr: Pointer; {pthread_attr_t}                         start_routine: PTFuncType;                         arg: Pointer): Longint;cdecl;external 'clib' name 'pthread_create';function pthread_detach(thread: pthread_t): Longint; cdecl;external 'clib' name 'pthread_detach';function pthread_equal(t1, t2: pthread_t): Longint; cdecl;external 'clib' name 'pthread_equal';//procedure pthread_exit(value_ptr: Pointer); // __dead2 ???cdecl;external 'clib' name 'pthread_exit';// signalstype	SignalFunc = procedure (al: Longint);function signal(sig: Longint; func: SignalFunc): SignalFunc; external 'clib' name '_signal';// signal constantsconst	SIGHUP	=	1;	// hangup */	SIGINT	=	2;	// interrupt */	SIGQUIT	=	3;	// quit */	SIGILL	=	4;	// illegal instruction (not reset when caught) */	SIGTRAP	=	5;	// trace trap (not reset when caught) */	SIGABRT	=	6;	// abort() */	SIGIOT	=	SIGABRT;	// compatibility */	SIGEMT	=	7;	// EMT instruction */	SIGFPE	=	8;	// floating point exception */	SIGKILL	=	9;	// kill (cannot be caught or ignored) */	SIGBUS	=	10;	// bus error */	SIGSEGV	=	11;	// segmentation violation */	SIGSYS	=	12;	// bad argument to system call */	SIGPIPE	=	13;	// write on a pipe with no one to read it */	SIGALRM	=	14;	// alarm clock */	SIGTERM	=	15;	// software termination signal from kill */	SIGURG	=	16;	// urgent condition on IO channel */	SIGSTOP	=	17;	// sendable stop signal not from tty */	SIGTSTP	=	18;	// stop signal from tty */	SIGCONT	=	19;	// continue a stopped process */	SIGCHLD	=	20;	// to parent on child stop or exit */	SIGTTIN	=	21;	// to readers pgrp upon background tty read */	SIGTTOU	=	22;	// like TTIN for output if (tp->t_local&LTOSTOP) */	SIGIO	=	23;	// input/output possible signal */	SIGXCPU	=	24;	// exceeded CPU time limit */	SIGXFSZ	=	25;	// exceeded file size limit */	SIGVTALRM	=	26;	// virtual time alarm */	SIGPROF	=	27;	// profiling time alarm */	SIGWINCH= 28;	// window size changes */	SIGINFO	=	29;	// information request */	SIGUSR1= 30;	// user defined signal 1 */	SIGUSR2= 31;	//; user defined signal 2 */// File I/O, added 151009const	BUFSIZ		=	512;	EOF			=	-1;	FOPEN_MAX	=	15;	FILENAME_MAX=	256;	L_tmpnam	=	20;	TMP_MAX		=	9999;	SEEK_SET	=	0;	SEEK_CUR	=	1;	SEEK_END	=	2;type	fpos_t = UInt32; // 64?function fclose(f: PFILE): cint; cdecl; external 'clib' name 'fclose';//function fflush(f: PFILE): cint; cdecl; external 'clib' name 'fflush';function fopen(fileName, mode: PCHAR): PFILE; cdecl; external 'clib' name 'fopen';function fread(p: Pointer; blocksize, count: size_t; f: PFILE): size_t; cdecl; external 'clib' name 'fread';function fwrite(p: Pointer; blocksize, count: size_t; f: PFILE): size_t; cdecl; external 'clib' name 'fwrite';function fgetpos(f: PFILE; var pos: fpos_t): cint; cdecl; external 'clib' name 'fgetpos';function fseek(f: PFILE; offset: Longint; origin: cint): cint; cdecl; external 'clib' name 'fseek';function fsetpos(f: PFILE; const pos: fpos_t): cint; cdecl; external 'clib' name 'fsetpos';function ftell(f: PFILE): Longint; cdecl; external 'clib' name 'ftell';procedure rewind(f: PFILE); cdecl; external 'clib' name 'rewind';implementationend.
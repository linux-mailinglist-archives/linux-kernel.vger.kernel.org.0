Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99AD9F4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 23:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfH0VMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 17:12:53 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:47334 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0VMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:12:53 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 9886F786050; Tue, 27 Aug 2019 23:12:48 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Enrico@kleine-koenig.org, Weigelt@kleine-koenig.org,
        metux IT consult <lkml@metux.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] vsprintf: introduce %dE for error constants
Date:   Tue, 27 Aug 2019 23:12:44 +0200
Message-Id: <20190827211244.7210-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new format specifier %dE introduced with this patch pretty-prints
the typical negative error values. So

	pr_info("probing failed (%dE)\n", ret);

yields

	probing failed (EIO)

if ret holds -EIO. This is easier to understand than the for now common

	probing failed (-5)

(which used %d instead of %dE) for kernel developers who don't know the
numbers by heart, The error names are also known and understood by
userspace coders as they match the values the errno variable can have.
Also to debug the sitation that resulted in the above message very
probably involves EIO, so the message already gives the string to look
out for.

glibc (and other libc variants)'s printf have a similar feature: %m
expands to strerror(errno). I preferred using %dE however because %m in
userspace doesn't consume an argument (which is however necessary in the
kernel as there is no global errno variable). Also this is handled
correctly by the compiler's format string checker as there is a matching
int variable for the %d the compiler notices.

There are quite some code locations that could be adapted to benefit
from this:

	$ git grep -E '^\s*(printk|(kv?as|sn?|vs(c?n)?)printf|(kvm|dev|pr)_(emerg|alert|crit|err|warn(ing)?|notice|info|cont|devel|debug|dbg))\(.*(\(%d\)|: %d)\\n' v5.3-rc5 | wc -l
	9141

I expect there are some false negatives where the match is distributed
over two or more lines and so isn't found.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

in v1 I handled both positive and negative errors which was challenged.
I decided to drop that and only handle the (common) negative values.
Readding handling of positive values later is easier than dropping it.

Sergey Senozhatsky and Enrico Weigelt suggested to use strerror as name
for the function that I called errno2errstr. (In v1 it was not a
separate function). I didn't pick this up because the semantic of
strerror in userspace is different. It returns something like
"Interrupted system call" while errno2errstr only yields "EINTR".

I dropped EWOULDBLOCK from the list of codes as it is on all Linux archs
identical to EAGAIN and the way the lookup works now breaks otherwise.
(And having it wasn't useful already in v1.)

Rasmus Villemoes pointed out that the way I wrote the resulting string
to the buffer was broken. This is fixed according to his suggestion by
using string_nocheck(). I also added a test to lib/test_printf.c as he
requested.

Petr Mladek had some concerns:
> The array is long, created by cpu&paste, the index of each code
> is not obvious.

Yeah right, the array is long. This cannot really be changed because we
have that many error codes. I don't understand your concern about the
index not being obvious. The array was just a list of (number, string)
pairs where the position in the array didn't have any semantic.

I agree it would be nice to have only one place that has a collection of
error codes. I thought about reorganizing how the error constants are
defined, i.e. doing something like:

        DEFINE_ERROR(EIO, 5, "I/O error")

but I don't see a possibility to let this expand to

        #define EIO 5

without resorting to another macro language. If that were possible the
list of DEFINE_ERRORs could be reused to help generating the code for
errno2errstr. So if you have a good idea, please speak up.

> There are ideas to make the code even more tricky to reduce
> the size, keep it fast.

I think Enrico Weigelt's suggestion to use a case is the best
performance-wise so that's what I picked up. Also I hope that
performance isn't that important because the need to print an error
should not be so common that it really hurts in production.

> Both, %dE modifier and the output format (ECODE) is non-standard.

Yeah, obviously right. The problem is that the new modifier does
something that wasn't implemented before, so it cannot match any
standard. %pI is only known on Linux either, so I think being
non-standard is a weak argument. For user consumption it would be nice
if we'd get

        probing failed (I/O Error)

from pr_info("probing failed (%dE)\n", -EIO); but that would be still
more expensive because the collection of string constants would become
bigger that it is already now and "EIO" is the right one to search for
when debugging the underlaying problem. So I think "EIO" is even more
useful than "I/O Error".

> Upper letters gain a lot of attention. But the error code is
> only helper information. Also many error codes are misleading because
> they are used either wrongly or there was no better available.

This isn't really an argument against the patch I think. Sure, if a
function returned (say) EIO while ETIMEOUT would be better, my patch
doesn't improve that detail. Still

        mydev: Failed to initialize blablub: EIO

is more expressive than

        mydev: Failed to initialize blablub: -5

. With "EIO" in the message it is not worse than with "-5" independant of the
question if EIO is the right error code used.

> There is no proof that this approach would be widely acceptable for
> subsystem maintainers. Some might not like mass and "blind" code
> changes. Some might not like the output at all.

I don't intend to mass convert existing code. I would restrict myself to
updating the documentation and then maybe send a patch per subsystem as an
example to let maintainers know and judge for themselves if they like it or
not. And if it doesn't get picked up, we can just remove the feature again next
year (or so).

I dropped the example conversion, I think the idea should be clear now
even without an explicit example.

Best regards
Uwe

---
 Documentation/core-api/printk-formats.rst |   3 +
 lib/test_printf.c                         |   1 +
 lib/vsprintf.c                            | 188 +++++++++++++++++++++-
 3 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index c6224d039bcb..81002414f956 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -35,6 +35,9 @@ Integer types
 		u64			%llu or %llx
 
 
+To print the name that corresponds to an integer error constant, use %dE and
+pass the int.
+
 If <type> is dependent on a config option for its size (e.g., sector_t,
 blkcnt_t) or is architecture-dependent for its size (e.g., tcflag_t), use a
 format specifier of its largest possible type and explicitly cast to it.
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 944eb50f3862..9b0687928717 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -174,6 +174,7 @@ test_number(void)
 		test("0xfffffff0|0xf0|0xf0", "%#02x|%#02x|%#02x", val, val & 0xff, (u8)val);
 	}
 #endif
+	test("EIO", "%dE", -EIO);
 }
 
 static void __init
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b0967cf17137..8fed03610402 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -682,6 +682,187 @@ static char *pointer_string(char *buf, char *end,
 	return number(buf, end, (unsigned long int)ptr, spec);
 }
 
+#define ERRORCODES \
+	ERRORCODE(EPERM) \
+	ERRORCODE(ENOENT) \
+	ERRORCODE(ESRCH) \
+	ERRORCODE(EINTR) \
+	ERRORCODE(EIO) \
+	ERRORCODE(ENXIO) \
+	ERRORCODE(E2BIG) \
+	ERRORCODE(ENOEXEC) \
+	ERRORCODE(EBADF) \
+	ERRORCODE(ECHILD) \
+	ERRORCODE(EAGAIN) \
+	ERRORCODE(ENOMEM) \
+	ERRORCODE(EACCES) \
+	ERRORCODE(EFAULT) \
+	ERRORCODE(ENOTBLK) \
+	ERRORCODE(EBUSY) \
+	ERRORCODE(EEXIST) \
+	ERRORCODE(EXDEV) \
+	ERRORCODE(ENODEV) \
+	ERRORCODE(ENOTDIR) \
+	ERRORCODE(EISDIR) \
+	ERRORCODE(EINVAL) \
+	ERRORCODE(ENFILE) \
+	ERRORCODE(EMFILE) \
+	ERRORCODE(ENOTTY) \
+	ERRORCODE(ETXTBSY) \
+	ERRORCODE(EFBIG) \
+	ERRORCODE(ENOSPC) \
+	ERRORCODE(ESPIPE) \
+	ERRORCODE(EROFS) \
+	ERRORCODE(EMLINK) \
+	ERRORCODE(EPIPE) \
+	ERRORCODE(EDOM) \
+	ERRORCODE(ERANGE) \
+	ERRORCODE(EDEADLK) \
+	ERRORCODE(ENAMETOOLONG) \
+	ERRORCODE(ENOLCK) \
+	ERRORCODE(ENOSYS) \
+	ERRORCODE(ENOTEMPTY) \
+	ERRORCODE(ELOOP) \
+	ERRORCODE(ENOMSG) \
+	ERRORCODE(EIDRM) \
+	ERRORCODE(ECHRNG) \
+	ERRORCODE(EL2NSYNC) \
+	ERRORCODE(EL3HLT) \
+	ERRORCODE(EL3RST) \
+	ERRORCODE(ELNRNG) \
+	ERRORCODE(EUNATCH) \
+	ERRORCODE(ENOCSI) \
+	ERRORCODE(EL2HLT) \
+	ERRORCODE(EBADE) \
+	ERRORCODE(EBADR) \
+	ERRORCODE(EXFULL) \
+	ERRORCODE(ENOANO) \
+	ERRORCODE(EBADRQC) \
+	ERRORCODE(EBADSLT) \
+	ERRORCODE(EBFONT) \
+	ERRORCODE(ENOSTR) \
+	ERRORCODE(ENODATA) \
+	ERRORCODE(ETIME) \
+	ERRORCODE(ENOSR) \
+	ERRORCODE(ENONET) \
+	ERRORCODE(ENOPKG) \
+	ERRORCODE(EREMOTE) \
+	ERRORCODE(ENOLINK) \
+	ERRORCODE(EADV) \
+	ERRORCODE(ESRMNT) \
+	ERRORCODE(ECOMM) \
+	ERRORCODE(EPROTO) \
+	ERRORCODE(EMULTIHOP) \
+	ERRORCODE(EDOTDOT) \
+	ERRORCODE(EBADMSG) \
+	ERRORCODE(EOVERFLOW) \
+	ERRORCODE(ENOTUNIQ) \
+	ERRORCODE(EBADFD) \
+	ERRORCODE(EREMCHG) \
+	ERRORCODE(ELIBACC) \
+	ERRORCODE(ELIBBAD) \
+	ERRORCODE(ELIBSCN) \
+	ERRORCODE(ELIBMAX) \
+	ERRORCODE(ELIBEXEC) \
+	ERRORCODE(EILSEQ) \
+	ERRORCODE(ERESTART) \
+	ERRORCODE(ESTRPIPE) \
+	ERRORCODE(EUSERS) \
+	ERRORCODE(ENOTSOCK) \
+	ERRORCODE(EDESTADDRREQ) \
+	ERRORCODE(EMSGSIZE) \
+	ERRORCODE(EPROTOTYPE) \
+	ERRORCODE(ENOPROTOOPT) \
+	ERRORCODE(EPROTONOSUPPORT) \
+	ERRORCODE(ESOCKTNOSUPPORT) \
+	ERRORCODE(EOPNOTSUPP) \
+	ERRORCODE(EPFNOSUPPORT) \
+	ERRORCODE(EAFNOSUPPORT) \
+	ERRORCODE(EADDRINUSE) \
+	ERRORCODE(EADDRNOTAVAIL) \
+	ERRORCODE(ENETDOWN) \
+	ERRORCODE(ENETUNREACH) \
+	ERRORCODE(ENETRESET) \
+	ERRORCODE(ECONNABORTED) \
+	ERRORCODE(ECONNRESET) \
+	ERRORCODE(ENOBUFS) \
+	ERRORCODE(EISCONN) \
+	ERRORCODE(ENOTCONN) \
+	ERRORCODE(ESHUTDOWN) \
+	ERRORCODE(ETOOMANYREFS) \
+	ERRORCODE(ETIMEDOUT) \
+	ERRORCODE(ECONNREFUSED) \
+	ERRORCODE(EHOSTDOWN) \
+	ERRORCODE(EHOSTUNREACH) \
+	ERRORCODE(EALREADY) \
+	ERRORCODE(EINPROGRESS) \
+	ERRORCODE(ESTALE) \
+	ERRORCODE(EUCLEAN) \
+	ERRORCODE(ENOTNAM) \
+	ERRORCODE(ENAVAIL) \
+	ERRORCODE(EISNAM) \
+	ERRORCODE(EREMOTEIO) \
+	ERRORCODE(EDQUOT) \
+	ERRORCODE(ENOMEDIUM) \
+	ERRORCODE(EMEDIUMTYPE) \
+	ERRORCODE(ECANCELED) \
+	ERRORCODE(ENOKEY) \
+	ERRORCODE(EKEYEXPIRED) \
+	ERRORCODE(EKEYREVOKED) \
+	ERRORCODE(EKEYREJECTED) \
+	ERRORCODE(EOWNERDEAD) \
+	ERRORCODE(ENOTRECOVERABLE) \
+	ERRORCODE(ERFKILL) \
+	ERRORCODE(EHWPOISON) \
+	ERRORCODE(ERESTARTSYS) \
+	ERRORCODE(ERESTARTNOINTR) \
+	ERRORCODE(ERESTARTNOHAND) \
+	ERRORCODE(ENOIOCTLCMD) \
+	ERRORCODE(ERESTART_RESTARTBLOCK) \
+	ERRORCODE(EPROBE_DEFER) \
+	ERRORCODE(EOPENSTALE) \
+	ERRORCODE(ENOPARAM) \
+	ERRORCODE(EBADHANDLE) \
+	ERRORCODE(ENOTSYNC) \
+	ERRORCODE(EBADCOOKIE) \
+	ERRORCODE(ENOTSUPP) \
+	ERRORCODE(ETOOSMALL) \
+	ERRORCODE(ESERVERFAULT) \
+	ERRORCODE(EBADTYPE) \
+	ERRORCODE(EJUKEBOX) \
+	ERRORCODE(EIOCBQUEUED) \
+	ERRORCODE(ERECALLCONFLICT)
+
+#define ERRORCODE(x) 	case x: return #x;
+
+static const char *errint2errstr(int err)
+{
+	switch(-err) {
+	ERRORCODES
+	}
+	return NULL;
+}
+#undef ERRORCODE
+
+static noinline_for_stack
+char *errstr(char *buf, char *end, unsigned long long num,
+	     struct printf_spec spec)
+{
+	const char *errstr = errint2errstr(num);
+	static const struct printf_spec strspec = {
+		.field_width = -1,
+		.precision = 10,
+		.flags = LEFT,
+	};
+
+	if (!errstr) {
+		/* fall back to ordinary number */
+		return number(buf, end, num, spec);
+	}
+
+	return string_nocheck(buf, end, errstr, strspec);
+}
+
 /* Make pointers available for printing early in the boot sequence. */
 static int debug_boot_weak_hash __ro_after_init;
 
@@ -2566,7 +2747,12 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 				num = va_arg(args, unsigned int);
 			}
 
-			str = number(str, end, num, spec);
+			if (spec.type == FORMAT_TYPE_INT && *fmt == 'E') {
+				fmt++;
+				str = errstr(str, end, num, spec);
+			} else {
+				str = number(str, end, num, spec);
+			}
 		}
 	}
 
-- 
2.23.0


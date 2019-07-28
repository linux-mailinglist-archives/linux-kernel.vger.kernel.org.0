Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F9F77F93
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfG1NVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 09:21:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfG1NUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:20:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hrj6S-0003pu-2n; Sun, 28 Jul 2019 15:20:44 +0200
Message-Id: <20190728131648.587523358@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 28 Jul 2019 15:12:52 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Subject: [patch 1/5] lib/vdso/32: Remove inconsistent NULL pointer checks
References: <20190728131251.622415456@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32bit variants of vdso_clock_gettime()/getres() have a NULL pointer
check for the timespec pointer. That's inconsistent vs. 64bit.

But the vdso implementation will never be consistent versus the syscall
because the only case which it can handle is NULL. Any other invalid
pointer will cause a segfault. So special casing NULL is not really useful.

Remove it along with the superflouos syscall fallback invocation as that
will return -EFAULT anyway. That also gets rid of the dubious typecast
which only works because the pointer is NULL.

Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/vdso/gettimeofday.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -115,9 +115,6 @@ static __maybe_unused int
 	struct __kernel_timespec ts;
 	int ret;
 
-	if (res == NULL)
-		goto fallback;
-
 	ret = __cvdso_clock_gettime(clock, &ts);
 
 	if (ret == 0) {
@@ -126,9 +123,6 @@ static __maybe_unused int
 	}
 
 	return ret;
-
-fallback:
-	return clock_gettime_fallback(clock, (struct __kernel_timespec *)res);
 }
 
 static __maybe_unused int
@@ -204,10 +198,8 @@ int __cvdso_clock_getres(clockid_t clock
 		goto fallback;
 	}
 
-	if (res) {
-		res->tv_sec = 0;
-		res->tv_nsec = ns;
-	}
+	res->tv_sec = 0;
+	res->tv_nsec = ns;
 
 	return 0;
 
@@ -221,9 +213,6 @@ static __maybe_unused int
 	struct __kernel_timespec ts;
 	int ret;
 
-	if (res == NULL)
-		goto fallback;
-
 	ret = __cvdso_clock_getres(clock, &ts);
 
 	if (ret == 0) {
@@ -232,8 +221,5 @@ static __maybe_unused int
 	}
 
 	return ret;
-
-fallback:
-	return clock_getres_fallback(clock, (struct __kernel_timespec *)res);
 }
 #endif /* VDSO_HAS_CLOCK_GETRES */



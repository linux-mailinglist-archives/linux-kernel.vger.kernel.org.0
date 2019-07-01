Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66290358BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 10:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFEIjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 04:39:02 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:50326 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfFEIjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gr0mTLl4nOcKmmGmRaPugNKoyguVPVCtWK6FvFJMIDc=; b=JaDIpeKkwP3iHXf85k6Jj2eVYA
        GsmSeDJ1uXjAeXLPNo17+wrNx0n8fczLXrDSm0lbQXrzoj2B5LqShyGmWtIXp0lC6VaswNBDGH7vQ
        bXCMvpkOd/43S5edGhOsjya95zRSULvRY3AwY6TCPoZwchG44FhZWdq8Jpe7dPvoDRedl1XGUQIPc
        q7acxe0Al+H5O/1LLnM6kpemch2IyncabaJIPZMPZRaUijEEHA7L5oU8xdKudt9Ed0R8yiBlTM2l1
        GRyOvmuVF+IKKaJEnCjI2JGR3DrFDiVYfbMylGPQsVL0o55Asm0+4JzU5m4FS1Lj5+DdxcT+kIg64
        9LmAKhog==;
Received: from [37.204.119.143] (port=55354 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hYR9J-0008s7-Sj; Wed, 05 Jun 2019 11:20:00 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Vladimir D . Seleznev" <vseleznv@altlinux.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Date:   Wed,  5 Jun 2019 11:19:00 +0300
Message-Id: <20190605081906.28938-2-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605081906.28938-1-ar@cs.msu.ru>
References: <20190605081906.28938-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 1/7] signal.h: Define SIGINFO on all architectures
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This complementary patch defines SIGINFO as a synonym for SIGPWR
on every architecture supported by the kernel.
The particular signal number chosen does not really matter and is only
required for the related tty functionality to work properly,
so if it does not suite expectations, any suggestions are warmly
welcome.

SIGPWR looks like a nice candidate for this role, because it is
defined on every supported arch; it is currently only used to inform
PID 1 of power failures, and daemons that care about low-level
events do not tend to have a controlling terminal.

However, on sparcs SIGPWR is a synonym for SIGLOST, a signal unique
to that architecture, with a narrow set of intended uses that do not
combine well with interactively requesting status.
SIGLOST is not used by any kernel code at the moment.
I'm not sure there is a more reasonable alternative right now.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/arm/include/uapi/asm/signal.h     | 1 +
 arch/h8300/include/uapi/asm/signal.h   | 1 +
 arch/ia64/include/uapi/asm/signal.h    | 1 +
 arch/m68k/include/uapi/asm/signal.h    | 1 +
 arch/mips/include/uapi/asm/signal.h    | 1 +
 arch/parisc/include/uapi/asm/signal.h  | 1 +
 arch/powerpc/include/uapi/asm/signal.h | 1 +
 arch/s390/include/uapi/asm/signal.h    | 1 +
 arch/sparc/include/uapi/asm/signal.h   | 2 ++
 arch/x86/include/uapi/asm/signal.h     | 1 +
 arch/xtensa/include/uapi/asm/signal.h  | 1 +
 include/uapi/asm-generic/signal.h      | 1 +
 12 files changed, 13 insertions(+)

diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index 9b4185ba4f8a..b80b53a17267 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
index e15521037348..7a2b783af22b 100644
--- a/arch/h8300/include/uapi/asm/signal.h
+++ b/arch/h8300/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
index aa98ff1b9e22..b4c98cb17165 100644
--- a/arch/ia64/include/uapi/asm/signal.h
+++ b/arch/ia64/include/uapi/asm/signal.h
@@ -45,6 +45,7 @@
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 /* signal 31 is no longer "unused", but the SIGUNUSED macro remains for backwards compatibility */
 #define	SIGUNUSED	31
diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
index 915cc755a184..a0b4e4108cb8 100644
--- a/arch/m68k/include/uapi/asm/signal.h
+++ b/arch/m68k/include/uapi/asm/signal.h
@@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index 53104b10aae2..975a6f0d3b0b 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -43,6 +43,7 @@ typedef unsigned long old_sigset_t;		/* at least 32 bits */
 #define SIGCHLD		18	/* Child status has changed (POSIX).  */
 #define SIGCLD		SIGCHLD /* Same as SIGCHLD (System V).	*/
 #define SIGPWR		19	/* Power failure restart (System V).  */
+#define SIGINFO		SIGPWR	/* Keyboard status request (4.2 BSD). */
 #define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
 #define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
 #define SIGIO		22	/* I/O now possible (4.2 BSD).	*/
diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index d38563a394f2..fe2e00d590ac 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -22,6 +22,7 @@
 #define SIGUSR2		17
 #define SIGCHLD		18
 #define SIGPWR		19
+#define SIGINFO		SIGPWR
 #define SIGVTALRM	20
 #define SIGPROF		21
 #define SIGIO		22
diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
index 85b0a7aa43e7..e7f3885905b4 100644
--- a/arch/powerpc/include/uapi/asm/signal.h
+++ b/arch/powerpc/include/uapi/asm/signal.h
@@ -53,6 +53,7 @@ typedef struct {
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
index 9a14a611ed82..12ee62987971 100644
--- a/arch/s390/include/uapi/asm/signal.h
+++ b/arch/s390/include/uapi/asm/signal.h
@@ -58,6 +58,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST         29
 */
 #define SIGPWR          30
+#define SIGINFO         SIGPWR
 #define SIGSYS		31
 #define SIGUNUSED       31
 
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index ff9505923b9a..b655163198bb 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -71,6 +71,8 @@
 #define SIGWINCH	28
 #define SIGLOST		29
 #define SIGPWR		SIGLOST
+/* XXX: is it OK for SIGINFO to collide with LOST? */
+#define SIGINFO		SIGPWR
 #define SIGUSR1		30
 #define SIGUSR2		31
 
diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
index e5745d593dc7..1539bb28826c 100644
--- a/arch/x86/include/uapi/asm/signal.h
+++ b/arch/x86/include/uapi/asm/signal.h
@@ -55,6 +55,7 @@ typedef unsigned long sigset_t;
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
index 005dec5bfde4..d644234305de 100644
--- a/arch/xtensa/include/uapi/asm/signal.h
+++ b/arch/xtensa/include/uapi/asm/signal.h
@@ -65,6 +65,7 @@ typedef struct {
 #define SIGPOLL		SIGIO
 /* #define SIGLOST		29 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 5c716a952cbe..9f9a1db0d43c 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -43,6 +43,7 @@
 #define SIGLOST		29
 */
 #define SIGPWR		30
+#define SIGINFO		SIGPWR
 #define SIGSYS		31
 #define	SIGUNUSED	31
 
-- 
2.20.1


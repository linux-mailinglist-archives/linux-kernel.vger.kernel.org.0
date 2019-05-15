Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92541E7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEOFiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 01:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOFiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:38:13 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C959E21473;
        Wed, 15 May 2019 05:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557898692;
        bh=VdgeS7LfnGpSS71DN+m5uT3nq2DbFueMnKgesOh1s1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uW1MlsIatY9pUomqsOsHJPwKNMxkbMCpjlUk/JHjmQRLQ+bhGcru8KBVpsLc9gIsX
         zPbVRDG82kBXAjf+/Ja+s0DUPWqzFRnbQhFJy3PnQgfhV4hePYu7flLaHMhAqCysfx
         N4gg8ovEhU65ZNJgetBQLQMUlE0b/G8uWyVAHRrg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [PATCH -tip v9 1/6] x86/uaccess: Allow access_ok() in irq context if pagefault_disabled
Date:   Wed, 15 May 2019 14:38:06 +0900
Message-Id: <155789868664.26965.7932665824135793317.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155789866428.26965.8344923934342528416.stgit@devnote2>
References: <155789866428.26965.8344923934342528416.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON_IN_IRQ() assumes that the access_ok() and following
user memory access can sleep. But this assumption is not
always correct; when the pagefault is disabled, following
memory access will just returns -EFAULT and never sleep.

Add pagefault_disabled() check in WARN_ON_ONCE() so that
it can ignore the case we call it with disabling pagefault.
For this purpose, this modified pagefault_disabled() as
an inline function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/uaccess.h |    4 +++-
 include/linux/uaccess.h        |    5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c82abd6e4ca3..9c4435307ff8 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -66,7 +66,9 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
 })
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-# define WARN_ON_IN_IRQ()	WARN_ON_ONCE(!in_task())
+static inline bool pagefault_disabled(void);
+# define WARN_ON_IN_IRQ()	\
+	WARN_ON_ONCE(!in_task() && !pagefault_disabled())
 #else
 # define WARN_ON_IN_IRQ()
 #endif
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 2b70130af585..5a43ef7db492 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -203,7 +203,10 @@ static inline void pagefault_enable(void)
 /*
  * Is the pagefault handler disabled? If so, user access methods will not sleep.
  */
-#define pagefault_disabled() (current->pagefault_disabled != 0)
+static inline bool pagefault_disabled(void)
+{
+	return current->pagefault_disabled != 0;
+}
 
 /*
  * The pagefault handler is in general disabled by pagefault_disable() or


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D94B6F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 00:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfIRWqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 18:46:25 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41692 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbfIRWqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:46:24 -0400
Received: by mail-qt1-f202.google.com with SMTP id n59so1824422qtd.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 15:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KbvL7l+c1s682f7jr6TZbZ71SRUkJ1VVKqvAaUIQiu0=;
        b=svlO88+iju0v54CNB7bY6nY8aXzhIs1miGWOL2Ne0z7vsMnPWbjVuqzJ+VTz+je1ON
         MQtu1WgCtq/W7u1eUzN1z97PK8P1eYz8RQKVU48o922a4Ferfcc4WCMvDJt8qaVAt35d
         kMQCCyLbdzJxsNZxB9cv1DvbO8hYUAsaLkh2s9mU4iVroMBXLQa71YktMSyNOUZXgpkt
         zjK97fz5/FtIU7OY13UHInaS+KNLoJM2ko+DPGxjURFeMShFA8PfGfFntbRd47zYa73C
         XE/znhR3xgsi/QHxqIrsTzDWkMqFsHyYGc5LQ63bq5dyrxVaX1UJy8FtznpneJWyfCIY
         vajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KbvL7l+c1s682f7jr6TZbZ71SRUkJ1VVKqvAaUIQiu0=;
        b=T6XVMKTDUXGiDOX1w4k5hO8cd9rwXCdsqEUYYAVDyG0wi2aQi+75JBEaQzQPP/ZSyL
         hEP6d1IkWsbQ1AoIB/z5xZwdFV02Mt7ucVdLgeV9JK3llge+fy6r+RxYoCSod2dHjI7J
         GRg/Fa5qjhBWA71TH+f5G6YHVCR8BViQ5SzoawC4Yffxgm4d+KaOCp49nMyhGYIA5dDo
         QQw5miiSX85++qkzjavQDmigzupM94dCmEiXDDh0iFkL1BUqSPZ9gL/zBGOQrqNNHOgE
         17DXQseWl9Md8pXqGn+XIQeuTqHoHpR3kyWOkhokO/g8z7a6mrszocHLBprrSt7aFkxI
         4Fpg==
X-Gm-Message-State: APjAAAXPnHYb51g5YueOf4/NKQ8AtG1vp5YF+W9dINZ5nswkp1lHYAh+
        ypRqKhKoYEvgjBsX3oPraR6s763SlOTnx73ctvw=
X-Google-Smtp-Source: APXvYqyKnSbw1qnfOiERMpy1WWWl0uh7F682jX0Fo5ThA9S+3jrR9oA31/Xl7hubEO89l29NkV0dZqxjfb4Tqs1XVHE=
X-Received: by 2002:a37:a849:: with SMTP id r70mr6578139qke.37.1568846783650;
 Wed, 18 Sep 2019 15:46:23 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:46:05 -0700
In-Reply-To: <20190918224608.77973-1-samitolvanen@google.com>
Message-Id: <20190918224608.77973-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190918224608.77973-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v2 2/5] x86/syscalls: Wire up COMPAT_SYSCALL_DEFINE0
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

x86 has special handling for COMPAT_SYSCALL_DEFINEx, but there was
no override for COMPAT_SYSCALL_DEFINE0.  Wire it up so that we can
use it for rt_sigreturn.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 90eb70df0b18..3dab04841494 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -28,13 +28,21 @@
  * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
  * case as well.
  */
+#define __IA32_COMPAT_SYS_STUB0(x, name)				\
+	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs);\
+	ALLOW_ERROR_INJECTION(__ia32_compat_sys_##name, ERRNO);		\
+	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs)\
+	{								\
+		return __se_compat_sys_##name();			\
+	}
+
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
 	{								\
 		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	}
 
 #define __IA32_SYS_STUBx(x, name, ...)					\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
@@ -76,15 +84,24 @@
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
  * with x86_64 obviously do not need such care.
  */
+#define __X32_COMPAT_SYS_STUB0(x, name, ...)				\
+	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs);\
+	ALLOW_ERROR_INJECTION(__x32_compat_sys_##name, ERRNO);		\
+	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs)\
+	{								\
+		return __se_compat_sys_##name();\
+	}
+
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
 	{								\
 		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	}
 
 #else /* CONFIG_X86_X32 */
+#define __X32_COMPAT_SYS_STUB0(x, name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_X86_X32 */
 
@@ -95,6 +112,17 @@
  * mapping of registers to parameters, we need to generate stubs for each
  * of them.
  */
+#define COMPAT_SYSCALL_DEFINE0(name)					\
+	static long __se_compat_sys_##name(void);			\
+	static inline long __do_compat_sys_##name(void);		\
+	__IA32_COMPAT_SYS_STUB0(x, name)				\
+	__X32_COMPAT_SYS_STUB0(x, name)					\
+	static long __se_compat_sys_##name(void)			\
+	{								\
+		return __do_compat_sys_##name();			\
+	}								\
+	static inline long __do_compat_sys_##name(void)
+
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-- 
2.23.0.351.gc4317032e6-goog


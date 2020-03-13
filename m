Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC81184F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 20:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCMTwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 15:52:18 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46862 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgCMTwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:15 -0400
Received: by mail-qv1-f66.google.com with SMTP id m2so5272892qvu.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+7J1ZutoH8TClHG4l9Z5aijsYYlnsgx6kyLeMxUFXM=;
        b=TDTGGWpIpgpzRyrgxX4t1prLpYPM/SZw5txPVEoweM1xEBd502uUh400wWN40wPGR2
         6+GKfKdyco/T3UnIrT5o+WkxOH+cqT9Fi1daFBqinboSHulPBLtWDQ7RmdVqmU0dTcFh
         ulKSHb8IoF+NNT5FEnp4cYDQNOJnKihuo0APHb12ToiQIyC+9g2e4bMPRwPd7EIEiCyc
         cwqb/9uJw4sb6WN97+NSj3AkUk8bI6lyzfcII7Ik06F5gnAcgQ+VHgjQRTeaF9CALJOj
         xFvcybyoZ+mN+I9RI1IhCjihkjHfhg/ZBhhX/QY7kX795DlG3bVS+faG0vx2yBqcDZTF
         mZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+7J1ZutoH8TClHG4l9Z5aijsYYlnsgx6kyLeMxUFXM=;
        b=SYy9+bH+ZB9aS8LHew6V4ybgXhs18c/GannZDTqT9E1rh9F46xP3Q4RTrJ0bZ+LFKB
         JDrDp/84222rV/C1m7iaTgs4AEzsEF595HClJtZlrF5YwWhjvypHbUjvR7hD19khqS/F
         P8amUcHq9Xp/5ur4o6ayZJWn1v4xaGGzxIuCPJFsOfDd67l9gFi1rLSRAVFTU8UauRMk
         YwqOfMhuqRW7AUj12nBBcgiNu4fV4etR2gXeIGqVI8gxqzxAQOd3rppbrQPc1wOFRk4v
         jmJxkwabSqcHypE7oPiIlpR0/IymadyLi8DOs1qKjvWgRCX0HdOr6MPMIpLW941z7PlR
         +sNQ==
X-Gm-Message-State: ANhLgQ0unpWsYBbYo4bTgF9+tFMQrGequBfmGcw9Q3em0aH4qwiIyu7J
        bAGz2jF2fDUm9/ebauBqPHoGB7I=
X-Google-Smtp-Source: ADFU+vu+0zQNGV1wOJ3qbT/SjLCw4DmQCdnoxhjTxgF50u552CtqMugEK/lo57zC0iotZShOhNOHxQ==
X-Received: by 2002:ad4:4b24:: with SMTP id s4mr14378469qvw.219.1584129133319;
        Fri, 13 Mar 2020 12:52:13 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:12 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 03/18] x86, syscalls: Refactor COND_SYSCALL macros
Date:   Fri, 13 Mar 2020 15:51:29 -0400
Message-Id: <20200313195144.164260-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313195144.164260-1-brgerst@gmail.com>
References: <20200313195144.164260-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull the common code out from the COND_SYSCALL macros into a new
__COND_SYSCALL macro.  Also conditionalize the X64 version in preparation
for enabling syscall wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/syscall_wrapper.h | 44 +++++++++++++++-----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 45ad60571166..0117b25e6753 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -35,6 +35,13 @@ struct pt_regs;
 		return __se_##name(__VA_ARGS__);			\
 	}
 
+#define __COND_SYSCALL(abi, name)					\
+	asmlinkage __weak long						\
+	__##abi##_##name(const struct pt_regs *__unused)		\
+	{								\
+		return sys_ni_syscall();				\
+	}
+
 #ifdef CONFIG_X86_64
 #define __X64_SYS_STUB0(name)						\
 	__SYS_STUB0(x64, sys_##name)
@@ -42,9 +49,13 @@ struct pt_regs;
 #define __X64_SYS_STUBx(x, name, ...)					\
 	__SYS_STUBx(x64, sys##name,					\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+
+#define __X64_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x64, sys_##name)
 #else /* CONFIG_X86_64 */
 #define __X64_SYS_STUB0(name)
 #define __X64_SYS_STUBx(x, name, ...)
+#define __X64_COND_SYSCALL(name)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_IA32_EMULATION
@@ -63,6 +74,9 @@ struct pt_regs;
 	__SYS_STUBx(ia32, compat_sys##name,				\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __IA32_COMPAT_COND_SYSCALL(name)				\
+	__COND_SYSCALL(ia32, compat_sys_##name)
+
 #define __IA32_SYS_STUB0(name)						\
 	__SYS_STUB0(ia32, sys_##name)
 
@@ -70,15 +84,8 @@ struct pt_regs;
 	__SYS_STUBx(ia32, sys##name,					\
 		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
-#define COND_SYSCALL(name)							\
-	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
-	{									\
-		return sys_ni_syscall();					\
-	}									\
-	asmlinkage __weak long __ia32_sys_##name(const struct pt_regs *__unused)\
-	{									\
-		return sys_ni_syscall();					\
-	}
+#define __IA32_COND_SYSCALL(name)					\
+	__COND_SYSCALL(ia32, sys_##name)
 
 #define SYS_NI(name)							\
 	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
@@ -87,8 +94,10 @@ struct pt_regs;
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUB0(name)
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_COMPAT_COND_SYSCALL(name)
 #define __IA32_SYS_STUB0(name)
 #define __IA32_SYS_STUBx(x, name, ...)
+#define __IA32_COND_SYSCALL(name)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -105,9 +114,12 @@ struct pt_regs;
 	__SYS_STUBx(x32, compat_sys##name,				\
 		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
+#define __X32_COMPAT_COND_SYSCALL(name)					\
+	__COND_SYSCALL(x32, compat_sys_##name)
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
+#define __X32_COMPAT_COND_SYSCALL(name)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -142,8 +154,8 @@ struct pt_regs;
  * kernel/time/posix-stubs.c to cover this case as well.
  */
 #define COND_SYSCALL_COMPAT(name) 					\
-	cond_syscall(__ia32_compat_sys_##name);				\
-	cond_syscall(__x32_compat_sys_##name)
+	__IA32_COMPAT_COND_SYSCALL(name)				\
+	__X32_COMPAT_COND_SYSCALL(name)
 
 #define COMPAT_SYS_NI(name)						\
 	SYSCALL_ALIAS(__ia32_compat_sys_##name, sys_ni_posix_timers);	\
@@ -215,13 +227,9 @@ struct pt_regs;
 	static asmlinkage long						\
 	__do_sys_##sname(const struct pt_regs *__unused)
 
-#ifndef COND_SYSCALL
-#define COND_SYSCALL(name) 							\
-	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
-	{									\
-		return sys_ni_syscall();					\
-	}
-#endif
+#define COND_SYSCALL(name)						\
+	__X64_COND_SYSCALL(name)					\
+	__IA32_COND_SYSCALL(name)
 
 #ifndef SYS_NI
 #define SYS_NI(name) SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);
-- 
2.24.1


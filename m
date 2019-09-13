Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28528B26F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 23:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfIMVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 17:00:37 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:37503 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMVAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:00:36 -0400
Received: by mail-qt1-f202.google.com with SMTP id s14so780844qtn.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v4Cua1E8F5eqeL2m3mcDw+ghn/aZUZbABVDxiLkYxm0=;
        b=CXWHfS0MHZL2f3WzGf4neYJjyN10ieyQMBD0UZ/14ufAQeNeZlZYl7FQFSsptXGALI
         UHHcDJGfn7MbJXfwDwy4O4IeT3d+JvwC6cnlnl+nTWCtGtz3hEAl7qRf1jqjvWplHvrz
         diCT2shA6tzXFj/wcB3E8dTmtDUSRBRKzV/R6C/8iQd8/7cNSmHL0UHf8ILtezVInUiA
         E8x8KKLHBCD6s+LSuCDPiM24scH4fPZRen4sONhSfrizn7HCAYBJsvkLfbsIxKSMA86U
         0ARxgfNPwj/QlBVABdyCYBuglVoWll9TP1ctq95k5ibTVn/v1A3mHFPEEt0fEks5paED
         pohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v4Cua1E8F5eqeL2m3mcDw+ghn/aZUZbABVDxiLkYxm0=;
        b=gIzML++dGcvorKGkD4pa/OLN6ygMQMqKDIDdV/XbOTrpiQ4lBnYhoeYWvlxXZ2X04s
         /FFKZ0xs5wDCgoEhucoqaPzMIoX/SGAFZDs/okBYBdTRHFiePasa4PIUUAI8DyRgvm3L
         7JtHJkbJnvVolqd+kY0zQNsEIzcBLfe2XinY/qPQB8ahWtt85ij6kES2czWSgp/2ldZJ
         k9G6rvDgLn60op0sdD54DA/CYYMUh9qVp0hkCaUO7THqmffqFlAhndigUyQ124G8LUii
         ZZrKCJuslxTjaT7ozyg5CClFAgWYMn8wUtSlE6pKwcUIP+iNkdARjAuKCsbN9n8YYh+p
         2kkQ==
X-Gm-Message-State: APjAAAWAVCw+tRVM64pxrddU5nd4fq09MQ3fBOuh/Fho2HdKhC0RbDEh
        N/gJ7bufcg7zQ6orH4AfRg5SHat8ZIe8mjeyXdI=
X-Google-Smtp-Source: APXvYqxvzaMhKyEsBhCioAXFWF+C0QtQXvOwRHrZlG5RmCHeH7O9Czninuzpj5iyuO31NwBTQNBfk35XOphdrCQuZTc=
X-Received: by 2002:a05:6214:1591:: with SMTP id m17mr24411892qvw.222.1568408433526;
 Fri, 13 Sep 2019 14:00:33 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:00:18 -0700
In-Reply-To: <20190913210018.125266-1-samitolvanen@google.com>
Message-Id: <20190913210018.125266-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH 4/4] x86: fix function types in COND_SYSCALL
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

Define a weak function in COND_SYSCALL instead of a weak alias to
sys_ni_syscall, which has an incompatible type. This fixes indirect
call mismatches with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 90eb70df0b18..9a595a544017 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_X86_SYSCALL_WRAPPER_H
 #define _ASM_X86_SYSCALL_WRAPPER_H
 
+struct pt_regs;
+
 /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
 #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
 	__MAP(x,__SC_ARGS						\
@@ -56,9 +58,15 @@
 	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);		\
 	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
 
-#define COND_SYSCALL(name)						\
-	cond_syscall(__x64_sys_##name);					\
-	cond_syscall(__ia32_sys_##name)
+#define COND_SYSCALL(name)							\
+	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
+	{									\
+		return sys_ni_syscall();					\
+	}									\
+	asmlinkage __weak long __ia32_sys_##name(const struct pt_regs *__unused)\
+	{									\
+		return sys_ni_syscall();					\
+	}
 
 #define SYS_NI(name)							\
 	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
@@ -190,7 +198,11 @@
 #endif
 
 #ifndef COND_SYSCALL
-#define COND_SYSCALL(name) cond_syscall(__x64_sys_##name)
+#define COND_SYSCALL(name) 							\
+	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
+	{									\
+		return sys_ni_syscall();					\
+	}
 #endif
 
 #ifndef SYS_NI
@@ -202,7 +214,6 @@
  * For VSYSCALLS, we need to declare these three syscalls with the new
  * pt_regs-based calling convention for in-kernel use.
  */
-struct pt_regs;
 asmlinkage long __x64_sys_getcpu(const struct pt_regs *regs);
 asmlinkage long __x64_sys_gettimeofday(const struct pt_regs *regs);
 asmlinkage long __x64_sys_time(const struct pt_regs *regs);
-- 
2.23.0.237.gc6a4ce50a0-goog


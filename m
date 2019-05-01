Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9110DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 22:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEAUFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 16:05:09 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48022 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfEAUFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:05:08 -0400
Received: by mail-pf1-f202.google.com with SMTP id c15so7082905pfc.14
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MlQndH9JHFu7S8ddgNAyiZUD6B/g+xVzIb+RnIGAaWs=;
        b=fnHCAaSHp7jm7BX0qFctNdwaGrY7oLfabmSkvoB4dtQBJxSdCKtEx2jxC7FIC3GCxO
         YlgBkWApyHsNLL6q2+7r2CJg2KnpX2OwDbqGgxNeA53OCgvKuTcxuVB48/S3RpXYbdDY
         xQI022cfV27rAtSh9fzNB5ly9uYCGubQ/ylCHl9zpyxnc+YN2gOllzLs4Xjgd9TiL++l
         kMDg+NtQ5Q8uH53COQDUocIYQW0e30MTDPCh60KDEcJ33zjTNRHn9njPDqkCGujG/mVs
         xQ7iK4l6ssYko9wzto0NLq97Khegf/K37bxoKrlRFtekyZwm6Khlvp/QHuQOSfA9pGKn
         uedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MlQndH9JHFu7S8ddgNAyiZUD6B/g+xVzIb+RnIGAaWs=;
        b=Dvj+nstUczFl8Kvwtl5K9SoTAEc6my6EWg99BeP+/lygJdPwMnKTM+q6HHRWYbC70y
         BMnPqkN1Qx90gtJWRhdI/JVbQGusD8wdja16kgXCCHX2tYpdzFWqH33xCTE3yIWuL6VV
         GV5K40QXSEOFZUEGIO7lFFRShclyxtrGeBFTq7i/WSXuhGGPmC8r459pl0ZMRexlNt9U
         r6WivOnDZcWUxzm03hHpIeRWBlueKqwU6WcGhyKoXKT/bkHLsUudqXITBeVgv5mPvgey
         UFfEwPsXqeW2HxzsXG+KI+cMVi5pn+f07zkuiEonQXru3/LwzZThlq1ZzNVCCq3d0AGx
         GuGA==
X-Gm-Message-State: APjAAAXhUmDORcRV7V55LEj38KNczal14Ezp/CvG3Qy5rpaxtYg5Gh/2
        5f/vO8ZiGZ9yFDI+A0RXGuDPQwVBrKs/ic6n5Zc=
X-Google-Smtp-Source: APXvYqwBclqb9p4MTO0VP/jDbcmcoD0wl/ivARDRHYgzxLNfoOJhYoTrwu/lUR7tBPdfO3m6nARfIKPs1tbACW0AiWU=
X-Received: by 2002:a63:da51:: with SMTP id l17mr34321605pgj.115.1556741107820;
 Wed, 01 May 2019 13:05:07 -0700 (PDT)
Date:   Wed,  1 May 2019 13:04:51 -0700
In-Reply-To: <20190501200451.255615-1-samitolvanen@google.com>
Message-Id: <20190501200451.255615-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190501200451.255615-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 2/2] arm64: use the correct function type in SYSCALL_DEFINE0
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although a syscall defined using SYSCALL_DEFINE0 doesn't accept
parameters, use the correct function type to avoid indirect call
type mismatches with Control-Flow Integrity checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/syscall_wrapper.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
index a4477e515b798..507d0ee6bc690 100644
--- a/arch/arm64/include/asm/syscall_wrapper.h
+++ b/arch/arm64/include/asm/syscall_wrapper.h
@@ -30,10 +30,10 @@
 	}										\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
-#define COMPAT_SYSCALL_DEFINE0(sname)					\
-	asmlinkage long __arm64_compat_sys_##sname(void);		\
-	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);	\
-	asmlinkage long __arm64_compat_sys_##sname(void)
+#define COMPAT_SYSCALL_DEFINE0(sname)							\
+	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused);	\
+	ALLOW_ERROR_INJECTION(__arm64_compat_sys_##sname, ERRNO);			\
+	asmlinkage long __arm64_compat_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL_COMPAT(name) \
 	cond_syscall(__arm64_compat_sys_##name);
@@ -62,11 +62,11 @@
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 
 #ifndef SYSCALL_DEFINE0
-#define SYSCALL_DEFINE0(sname)					\
-	SYSCALL_METADATA(_##sname, 0);				\
-	asmlinkage long __arm64_sys_##sname(void);		\
-	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);	\
-	asmlinkage long __arm64_sys_##sname(void)
+#define SYSCALL_DEFINE0(sname)							\
+	SYSCALL_METADATA(_##sname, 0);						\
+	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
+	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);			\
+	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused)
 #endif
 
 #ifndef COND_SYSCALL
-- 
2.21.0.593.g511ec345e18-goog


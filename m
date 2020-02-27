Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609791718A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 14:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgB0N2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 08:28:39 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33296 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgB0N2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:28:38 -0500
Received: by mail-yw1-f67.google.com with SMTP id j186so949069ywe.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Krp6+uhvlPJHHWTf3n43qIU4rZgJERDPytXH4UCiSes=;
        b=JF7eSpT3q/OmZlutOJl4hVPO/gx5TGHwVrRSvmxohzY5LQSTvVDxlDEZF1CuyzEYXD
         ryNYPC+OHhPt4s5ayz5iJN1QO0Ljzi+4KQpBSSQAVYLFLCDydOdl8nG45x6ZC5LoCnmE
         2FZ8ZQpGpJy7hQLK1ZrwSHBFcKFXVdhKF1wIHOiWziKLCjmROqaiBDGPRMIgNIXBEOvv
         vIXoFxwvMe7+8d4FB5wtzm1x0vQSFkE6S2UdnkgShlMXfIos+B03dhrIIoRWCQwK5x26
         7Wm3Rn0Wpx2oGNGHElwTFkonPuUKFsw3PcjznRofuzhTVbG2RrL9qJzoQLzahOCrXXWV
         XEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Krp6+uhvlPJHHWTf3n43qIU4rZgJERDPytXH4UCiSes=;
        b=Rr24Osewv5Otvkp6YFbcBPpy2mMGWji4cikWk8URGzcug02bUohCjMGKO/JtOo6HM9
         g99SZUKbFLavWeqKuMxjFVjD8I+TsOFOt+JtjXBUl5LjvfilHeyJdVmKzXQyfJqpKhrY
         AGbU08l06IQlJq/LXWUKNxum6w0rrRMEnlJRIUPUwOBfVNPhofODp0eoZo7HSbTGVOkB
         UMDgW9unLAReif1AwiIgYnbLNI6uSjwdrec3rltodTKUez/TcONPEH1tGYgEYKZO4K8j
         PWEp1c4fimzQomskw4mcZzWn2hcVahLb5DAvsIYS4P0zRL2i6Dn3ahSNbfY+fDNj67lh
         D8Fw==
X-Gm-Message-State: APjAAAWpYYAKYyIDSk+IlgeruD2NXwxPwvackDDBUdkEnLdn84u1nuN0
        slRWFEClXYrAMLMAULdJ2/GOpEM=
X-Google-Smtp-Source: APXvYqzaKY2POl0rcdhfZa7LQ043UmK2X/iJsdemc8of26Co1NdHM0VYcLwqYUNKxCaqulzcn+EWNg==
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr4116758ybt.91.1582810116296;
        Thu, 27 Feb 2020 05:28:36 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j23sm2442759ywb.93.2020.02.27.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:28:35 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 1/8] x86, syscalls: Refactor SYSCALL_DEFINEx macros
Date:   Thu, 27 Feb 2020 08:28:19 -0500
Message-Id: <20200227132826.195669-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227132826.195669-1-brgerst@gmail.com>
References: <20200227132826.195669-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull the common code out from the SYSCALL_DEFINEx macros into a new
__SYS_STUBx macro.  Also conditionalize the X64 version in preparation for
enabling syscall wrappers on 32-bit native kernels.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 74 ++++++++++++++------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e2389ce9bf58..7a4c2aff52c6 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -21,6 +21,22 @@ struct pt_regs;
 	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
 	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
 
+#define __SYS_STUBx(abi, name, ...)					\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);			\
+	asmlinkage long __##abi##_##name(const struct pt_regs *regs)	\
+	{								\
+		return __se_##name(__VA_ARGS__);			\
+	}
+
+#ifdef CONFIG_X86_64
+#define __X64_SYS_STUBx(x, name, ...)					\
+	__SYS_STUBx(x64, sys##name,					\
+		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
+#else /* CONFIG_X86_64 */
+#define __X64_SYS_STUBx(x, name, ...)
+#endif /* CONFIG_X86_64 */
+
 #ifdef CONFIG_IA32_EMULATION
 /*
  * For IA32 emulation, we need to handle "compat" syscalls *and* create
@@ -39,20 +55,12 @@ struct pt_regs;
 	}
 
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
-	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
-	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+	__SYS_STUBx(ia32, compat_sys##name,				\
+		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #define __IA32_SYS_STUBx(x, name, ...)					\
-	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
-	ALLOW_ERROR_INJECTION(__ia32_sys##name, ERRNO);			\
-	asmlinkage long __ia32_sys##name(const struct pt_regs *regs)	\
-	{								\
-		return __se_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+	__SYS_STUBx(ia32, sys##name,					\
+		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))
 
 /*
  * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
@@ -82,7 +90,7 @@ struct pt_regs;
 
 #else /* CONFIG_IA32_EMULATION */
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)
-#define __IA32_SYS_STUBx(x, fullname, name, ...)
+#define __IA32_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -101,12 +109,8 @@ struct pt_regs;
 	}
 
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
-	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
-	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
-	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
-	{								\
-		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}
+	__SYS_STUBx(x32, compat_sys##name,				\
+		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
 
 #else /* CONFIG_X86_X32 */
 #define __X32_COMPAT_SYS_STUB0(x, name)
@@ -131,16 +135,21 @@ struct pt_regs;
 	}								\
 	static inline long __do_compat_sys_##name(void)
 
-#define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
-	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
-	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
-	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
-	{									\
-		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
-	}									\
-	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
+	static long							\
+	__se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__));	\
+	static inline long						\
+	__do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__));	\
+	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)			\
+	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)			\
+	static long							\
+	__se_compat_sys##name(__MAP(x, __SC_LONG, __VA_ARGS__))		\
+	{								\
+		return __do_compat_sys##name(				\
+			__MAP(x, __SC_DELOUSE, __VA_ARGS__));		\
+	}								\
+	static inline long						\
+	__do_compat_sys##name(__MAP(x, __SC_DECL, __VA_ARGS__))
 
 /*
  * As some compat syscalls may not be implemented, we need to expand
@@ -192,14 +201,9 @@ struct pt_regs;
  * to the i386 calling convention (bx, cx, dx, si, di, bp).
  */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
-	asmlinkage long __x64_sys##name(const struct pt_regs *regs);	\
-	ALLOW_ERROR_INJECTION(__x64_sys##name, ERRNO);			\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	asmlinkage long __x64_sys##name(const struct pt_regs *regs)	\
-	{								\
-		return __se_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	__X64_SYS_STUBx(x, name, __VA_ARGS__)				\
 	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{								\
-- 
2.24.1


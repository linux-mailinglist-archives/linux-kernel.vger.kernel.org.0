Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1232CEB543
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 17:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfJaQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 12:47:20 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49272 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfJaQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:19 -0400
Received: by mail-pf1-f202.google.com with SMTP id r187so4988920pfc.16
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3L2fKWe0mnTKbOXtDJWS5MdWfgbISjm7SM0mf8jhMMs=;
        b=M2bQgEs0bbsNq8MNMFthK/YaXaNa7lsVfAcQUrIhxB6WHow3p7zT6DMI2hPzQ12JyE
         dBDu7tLmmK0EEcTfQyug+zjuDgAcD7mKPl6tI6HWHtIIlglIWBDrRvtighs9FmRdTeuA
         Utjfp/h/JCLg0sI4eJJnpaaKwajzXzqbouGFFnbQW8bF3vHks01IkHDwLbusJqIJbbtz
         HjJPj0I7fONVzT+V+kvjMVqj2r1bUa9I2Mu1YNcXlrszcM7cVDBp5tO3PZ8B+1C1keZf
         wVg7wmq11bbXPEPFRcmQQMxy7vNpqsJV3Tc3WBhABGzYCzx8tPiXjJJoVrXeY98hn2vr
         fLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3L2fKWe0mnTKbOXtDJWS5MdWfgbISjm7SM0mf8jhMMs=;
        b=i+pKbqV124kjvahc4O+Xb6itl0fVaSNEVxd/bewMCej5xDNc5QjYdZVn08m0oUrMGh
         PhgFIE4Fiy6KmY0HO4/bA0G/exFLGBRONt2N2nlt3ArmQI5YXWBveJek/ODFaYrfPKOn
         8V3wdec1RV9tj2W4hFOa1B55q1kcrVnqTlmmkvQKXz4NE9TV/lgO343Nbys1eaLoxXgo
         QPxVV3ampSKh5PJoc6dFkK0pFaJVIxiwgrt7sCgSKmKWZ9krs2EEtnDgVDHLuNwuIJWM
         947rgn56aepsvu9ErdLmixEmymYmUXPPmhSBskEYP5sVtUQ7DXc0hlwqkKwmVrWDWlaM
         b7uQ==
X-Gm-Message-State: APjAAAWRA1NVqdT5O0+bNGiD64Yrka5ePESOpl/4LV8XzH7JTCoyKgpW
        6b8CUTZJtvbZQEoANcHV1o+wHrOZs3JNptPMeMA=
X-Google-Smtp-Source: APXvYqydEhVHkKqut2+3OaRd8Srg3EG2C5xvERxBciOyTLScaCHzKIIF3dA+VkAqRL7gbd3nEjDN/XqnvRbx9STn/rY=
X-Received: by 2002:a63:d0d:: with SMTP id c13mr7797535pgl.138.1572540438115;
 Thu, 31 Oct 2019 09:47:18 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:33 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 13/17] arm64: preserve x18 when CPU is suspended
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't lose the current task's shadow stack when the CPU is suspended.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/mm/proc.S             | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 8939c87c4dce..0cde2f473971 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 12
+#define NR_CTX_REGS 13
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index fdabf40a83c8..0e7c353c9dfd 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -49,6 +49,8 @@
  * cpu_do_suspend - save CPU registers context
  *
  * x0: virtual address of context pointer
+ *
+ * This must be kept in sync with struct cpu_suspend_ctx in <asm/suspend.h>.
  */
 ENTRY(cpu_do_suspend)
 	mrs	x2, tpidr_el0
@@ -73,6 +75,9 @@ alternative_endif
 	stp	x8, x9, [x0, #48]
 	stp	x10, x11, [x0, #64]
 	stp	x12, x13, [x0, #80]
+#ifdef CONFIG_SHADOW_CALL_STACK
+	str	x18, [x0, #96]
+#endif
 	ret
 ENDPROC(cpu_do_suspend)
 
@@ -89,6 +94,10 @@ ENTRY(cpu_do_resume)
 	ldp	x9, x10, [x0, #48]
 	ldp	x11, x12, [x0, #64]
 	ldp	x13, x14, [x0, #80]
+#ifdef CONFIG_SHADOW_CALL_STACK
+	ldr	x18, [x0, #96]
+	str	xzr, [x0, #96]
+#endif
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
-- 
2.24.0.rc0.303.g954a862665-goog


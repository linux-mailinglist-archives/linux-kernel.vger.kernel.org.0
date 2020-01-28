Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 739FF14C03C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 19:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgA1St4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 13:49:56 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48811 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgA1Stz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:49:55 -0500
Received: by mail-qk1-f202.google.com with SMTP id z1so9010513qkl.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7qZDsX8PGWVYt4iEMt/hEQ+wAm1UsjKf1d+2vHZ6hPI=;
        b=KS9unC98BEN8reSNsSatSdGOyj9rhjRIhLpWA4Oym2iRcIbRcgujukrAJVafuptIVG
         4EooaqgtRT4z7P+gwfQEa6aLMk1SNJwyZKwX2crlZuGyjCIlB019qhZdYW5KDGB7SEtd
         0PuR+pszsgeqyBZrTkpSnRyXr+6t67faREc4ZftAuETIwNEYKpHUPeqa0nonCQaAHyP2
         wD25AjVMJD2kosLIy8FOnX8wGleJoEeAginjYdtC6nC2di6uwR2ExHm37hyKDxKy72du
         p8OwOQ+2vYq84iwfEx6zX7e/LJhw9x1StdJnITGBGfd8VptfiMqFNL8peyNZv1qVoP+e
         +6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7qZDsX8PGWVYt4iEMt/hEQ+wAm1UsjKf1d+2vHZ6hPI=;
        b=jEd3iIjwyrq4jID7jLmE9EfkSwe/GIyyu2a9ww8P+XP98AzP/xCJYZW3JC8bUJ3iJB
         N8veVGkrU+Hgr1Yz6y0BaCu99Oodq6tjwUrl526c5fCjZY3jouWWdpEYTm6uymOBY1da
         kYVWlUnqlaK/A3DR4Yf1OP+iW268Xn9bTlqTYpxVBhdWcD3FnGVpJPM2bI3MGBsXakkT
         P7vj5Pc8us5tGIQqS5c8gpMvVCsMbELl8vroE+JQ8qf9qdc0+SwZohkhy59q6Zxkp7xX
         R8GwH6t2xMzA1KblVJ8YLfF8cjLCKxkMGsBWcZE2FA/YjYVCksmASGGzRyO0KCW2pMI8
         kSYA==
X-Gm-Message-State: APjAAAVPqRDZ9tiTc9kyh201490ehrDejIDwjGhrA7+fWIdL1NGHoDhU
        GUN+HqxKkoPvmIHtiR4uw/oANmw0qjcN/QvQWD4=
X-Google-Smtp-Source: APXvYqz1ANohbb/5vvdBoYWBYp5QONjn2Th3Usy5pRDWtLh7ROCJORzEP/CMHwmepkxfOG/b7sXyq/Vz+8AN5R27oWY=
X-Received: by 2002:a05:6214:965:: with SMTP id do5mr23635758qvb.202.1580237393882;
 Tue, 28 Jan 2020 10:49:53 -0800 (PST)
Date:   Tue, 28 Jan 2020 10:49:29 -0800
In-Reply-To: <20200128184934.77625-1-samitolvanen@google.com>
Message-Id: <20200128184934.77625-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200128184934.77625-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 06/11] arm64: preserve x18 when CPU is suspended
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/mm/proc.S             | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index aafed6902411..7d37e3c70ff5 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -56,6 +56,8 @@
  * cpu_do_suspend - save CPU registers context
  *
  * x0: virtual address of context pointer
+ *
+ * This must be kept in sync with struct cpu_suspend_ctx in <asm/suspend.h>.
  */
 SYM_FUNC_START(cpu_do_suspend)
 	mrs	x2, tpidr_el0
@@ -80,6 +82,11 @@ alternative_endif
 	stp	x8, x9, [x0, #48]
 	stp	x10, x11, [x0, #64]
 	stp	x12, x13, [x0, #80]
+	/*
+	 * Save x18 as it may be used as a platform register, e.g. by shadow
+	 * call stack.
+	 */
+	str	x18, [x0, #96]
 	ret
 SYM_FUNC_END(cpu_do_suspend)
 
@@ -96,6 +103,13 @@ SYM_FUNC_START(cpu_do_resume)
 	ldp	x9, x10, [x0, #48]
 	ldp	x11, x12, [x0, #64]
 	ldp	x13, x14, [x0, #80]
+	/*
+	 * Restore x18, as it may be used as a platform register, and clear
+	 * the buffer to minimize the risk of exposure when used for shadow
+	 * call stack.
+	 */
+	ldr	x18, [x0, #96]
+	str	xzr, [x0, #96]
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
-- 
2.25.0.341.g760bfbb309-goog


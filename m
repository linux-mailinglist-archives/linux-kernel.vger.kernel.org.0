Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC23EB544
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 17:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfJaQrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 12:47:21 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43554 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfJaQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:16 -0400
Received: by mail-pf1-f201.google.com with SMTP id i187so5002931pfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P4MEC/JNWY+R+03CT6BMcXkN4eq/H40mvA6s8gty/0o=;
        b=FyBd2DZREBGldSQmdAl4ctWmHh0W3zmoUaOrqpBjG9EgJjGFba3+Gk8Ux29MjmAeBe
         sicne4I37jGUHXgzNedjLIMvsWVJI0ltGloZSO14XUHh9UTS3ARo7k97sP37e/Sb7gOS
         DkHrE6/vOZ1GtiQPangd/sumad9YQICceEEnhyVa//W66pwrVwkXh36b+vmOtbBKreKQ
         Cj7tQe1j/bGJXIWzMcMzK/I2qD4i61lE8pjYfsfIy6BaWm8QzTnAU3MchHhGnejhk8Hg
         PI+E7X6+lVUF1d6bWAow+VePWBv3sp0SROOStKCkYLe92oec5OgOSb4SSowmvPYz6/dp
         uItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P4MEC/JNWY+R+03CT6BMcXkN4eq/H40mvA6s8gty/0o=;
        b=WUMsoLpg9l04MLoxvBf0ei509Fr+wBcTW7JPjF5w4qPr2LIVZNJmcP8Dwthm7+rpTf
         ejhIC1/c9mjTICCLdGuNUoMdrvsL4aYSJAGfiXKt/FGu/93yckwdg/5VFFN7JtFbYtEK
         meYmEO/Gk5z6Ke5ekbepkeuPj7e1ARSqo/vKlDDIFkuNjrQaLvSt1L1JV+a+0ceJn02G
         rSVAv9Wja0emYGZ5MmLcOFkM4wgA+tCpvpKnPlQ+Azid7AH3Pjh345p4l1SFVC53Rh9a
         J7P4BC0SRoRZegNROBDkraABLF5T93HH49/YqvwtkzWtrBZJbWyNBhBxYqXtU2n83tEw
         tzmg==
X-Gm-Message-State: APjAAAWZ8V08mSbKzW/0D2mdBIxbtxrcguYjNcfF7q/xzFXOrW3xtYxo
        i2rvYjWEHRHGp8gOtYOWB/bsbsNJccFc8+ZEjmo=
X-Google-Smtp-Source: APXvYqyE0l4dMPPmCmPFvy8Hsugb5xtiMU18+Uv3gR8RxmoCWwbgYDkks7ERiHhw5CjwrT6msMO6tlilVlKLUvoeCVQ=
X-Received: by 2002:a63:6cf:: with SMTP id 198mr7655687pgg.259.1572540435556;
 Thu, 31 Oct 2019 09:47:15 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:32 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 12/17] arm64: reserve x18 from general allocation with SCS
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

Reserve the x18 register from general allocation when SCS is enabled,
because the compiler uses the register to store the current task's
shadow stack pointer. Note that all external kernel modules must also be
compiled with -ffixed-x18 if the kernel has SCS enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2c0238ce0551..ef76101201b2 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -72,6 +72,10 @@ stack_protector_prepare: prepare0
 					include/generated/asm-offsets.h))
 endif
 
+ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
+KBUILD_CFLAGS	+= -ffixed-x18
+endif
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
-- 
2.24.0.rc0.303.g954a862665-goog


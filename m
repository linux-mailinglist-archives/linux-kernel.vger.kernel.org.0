Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A7316ECBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 18:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgBYRkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 12:40:12 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47598 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgBYRkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:40:07 -0500
Received: by mail-pf1-f202.google.com with SMTP id e62so9725669pfh.14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QniVckAJWtqLmmFgAWqtQvDUqGmhiEDDkK5Atd0uI+w=;
        b=B7ASfSbr6PJI1PNYuMw4AeQl2rfrBE18p50aZHmoTWWjcghaevDSqsyUvYLaGuvGEV
         wwBpIUOA2JHt7hx+G+Ornny4GKtz9v4Eypp4NgPZ3xEK3rgMRBRBuNUqNS+ox6ACh+ZC
         6cWbkc8+i4jYfG+umapz9k/Bm3qSztOLHJyMg8JMXVQHlKA9VuWwhJw3cIfwhzFXI03b
         UEh9pcFUZQVWnOG6NbIAR+vAckRKiK94vNJZQ4ldnB79ldCEHyc60gKr6pHwkSc3vVOl
         SlY8HCGuRiNp4u0S5QuDxi4DnFctp1zaF1wh2WUSCaV9cRZWkMvslEfisyUwfEbN9k+G
         Kagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QniVckAJWtqLmmFgAWqtQvDUqGmhiEDDkK5Atd0uI+w=;
        b=kyMNMhztwbU6mou846cQkqQneRsNkC88ndzfRqxJojkN++EUuxnZTVBDQZyk0oiIMI
         C/iMesNPkgvWejY4QpevrRfX2cT93kJvwwE/IOte3/UVYH9awGPrQd+pXoQ4eqKnh4oR
         LzUtAT9ByCwtHT7MMwIfVo8DfSpTRgRWe2AsSpti4VwzH/w/sU9KgVvIPQULUgg+jqts
         fQjEaxGAI0Lg5pbMMN4VpvHdTj3cRB4oCsMJCMaWBRTSHpM4ClSiNTJQBhui1be4TDtP
         ZlvL9ZTcwvBbwqS+fHha1xcn2cE1c1cGyF1orx7YbzL1g2lBSrm3+AH4AsUiJXL0/lUZ
         212A==
X-Gm-Message-State: APjAAAXo6Dbwq029BInsFEbnJB3aYnQXOJ85VNNYWQPd+gzzsJpAMh57
        EkmLHnzxIcuSFT4ucgMJzCzosfUI3KMnbwvUDpg=
X-Google-Smtp-Source: APXvYqw22kkM3bH9wLjSIFkgjo4U46Ik1liYbPY7ppLoTBG5p4rEwIGlGJAnCM7FSLJOm8bUadpuV5p12hkwZ3bHzak=
X-Received: by 2002:a63:d244:: with SMTP id t4mr15492036pgi.241.1582652406574;
 Tue, 25 Feb 2020 09:40:06 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:39:28 -0800
In-Reply-To: <20200225173933.74818-1-samitolvanen@google.com>
Message-Id: <20200225173933.74818-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200225173933.74818-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 07/12] arm64: efi: restore x18 if it was corrupted
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
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

If we detect a corrupted x18, restore the register before jumping back
to potentially SCS instrumented code. This is safe, because the wrapper
is called with preemption disabled and a separate shadow stack is used
for interrupt handling.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/efi-rt-wrapper.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/efi-rt-wrapper.S b/arch/arm64/kernel/efi-rt-wrapper.S
index 3fc71106cb2b..6ca6c0dc11a1 100644
--- a/arch/arm64/kernel/efi-rt-wrapper.S
+++ b/arch/arm64/kernel/efi-rt-wrapper.S
@@ -34,5 +34,14 @@ ENTRY(__efi_rt_asm_wrapper)
 	ldp	x29, x30, [sp], #32
 	b.ne	0f
 	ret
-0:	b	efi_handle_corrupted_x18	// tail call
+0:
+	/*
+	 * With CONFIG_SHADOW_CALL_STACK, the kernel uses x18 to store a
+	 * shadow stack pointer, which we need to restore before returning to
+	 * potentially instrumented code. This is safe because the wrapper is
+	 * called with preemption disabled and a separate shadow stack is used
+	 * for interrupts.
+	 */
+	mov	x18, x2
+	b	efi_handle_corrupted_x18	// tail call
 ENDPROC(__efi_rt_asm_wrapper)
-- 
2.25.0.265.gbab2e86ba0-goog


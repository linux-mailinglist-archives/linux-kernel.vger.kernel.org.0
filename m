Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441C0DCA8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442974AbfJRQLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 12:11:34 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53451 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502695AbfJRQLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:32 -0400
Received: by mail-pg1-f202.google.com with SMTP id r25so4569870pga.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=21PQYFGMSyR0vWwlJoWUR0F8CwzgoNMVM1L0Pe6MFrQ=;
        b=XTGR5ysVCvFcDPfDZ2uRa4LSCFJbZwlyniF9TrCYGMBPbkIf0K085EjiQt4ffVYZbT
         yaiGK3y6faisAh6U9/CxmFlLU76VW2yJBLJXrJA65l2MTuNELcBcEAKKoaa0/ytobYt1
         fHBOBarOVqcb9kanEUVa8Ddgrfl9iIQEWkgSVtgsKdKE18WzVjzt/JiQzP1DlMT6n4jU
         kAXZNvTi8r9G3/D4MyaIAco80dTDl8K/TpV2nIA1UUazOM41jXMV5YIAb/W//1YPMnKI
         Y+DGVHPZ9eY1T49HNVfdlWN6taf0ZPGpl8IGYtJKJPC8pDOBJ6EMgatwO8Hvvq48VXqN
         DmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=21PQYFGMSyR0vWwlJoWUR0F8CwzgoNMVM1L0Pe6MFrQ=;
        b=O9o5bGSbUCvvU2xowPeUcXlt8pCAuaFGsX1XExQxVSwD6Q9QAHquKrVjJ4fM2rbQNh
         9Z3/dA/7svuC4oI++p01KKaNMDVI/p0Dj6P0rU8r0uaMDoFcQbu8IMblaiDT6IVso0wb
         PGSYwP44ubgyaznkfP2FZ0UzJV7nuyvyc2ynHRSFuIpWZVXiFWdCiWN4LHFYM/x1qyEV
         OeQV9NTrks7UIEtFX6cVOFaNex8lwUnnXROwiUwBFkjlEXLde3hECzlBxdaHrTMLBGh7
         aNS7yKOuwEQpY+MsdBwTulZbjaEbpS/LnjG6dGXwTzUI9m2y6KOmtjVUPLH6+mVMJ3iB
         0m1A==
X-Gm-Message-State: APjAAAXSjL8H6uYuqW4cqxPt+8vox8NHmEBBJG9eNjjMUzq4BrgF1EMY
        eBG/pj68+W2Wd8vgCVd//q2JSj9NLxMm5qcjVZI=
X-Google-Smtp-Source: APXvYqz2h3FK6fOLNjeif4Cg24fCITnU5ZQBquMxea8azTfQWEvOTaNE9xdQyiziN7s60FAxuGyTh4t3prrtUVRlSk8=
X-Received: by 2002:a63:1250:: with SMTP id 16mr10784356pgs.331.1571415090313;
 Fri, 18 Oct 2019 09:11:30 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:31 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 16/18] arm64: kprobes: fix kprobes without CONFIG_KRETPROBES
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows CONFIG_KRETPROBES to be disabled without disabling
kprobes entirely.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/probes/kprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index c4452827419b..98230ae979ca 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -551,6 +551,7 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 	return (void *)orig_ret_address;
 }
 
+#ifdef CONFIG_KRETPROBES
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
@@ -564,6 +565,7 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
 }
+#endif
 
 int __init arch_init_kprobes(void)
 {
-- 
2.23.0.866.gb869b98d4c-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE4EECB13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 23:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKAWMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 18:12:20 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50321 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfKAWMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:17 -0400
Received: by mail-pf1-f201.google.com with SMTP id e13so1781142pff.17
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lxookr95uMT9sOw8S1HRxQFBJ0wSUMPDNTYBScBbdzA=;
        b=VqPASQjKWMJdAAeJVcDeaVBQprxOwcKwHm7RWTEH9a4e15mPmrxMbW1NmgWy95nCCG
         gTOzFuhp1ly0goL38Kzph/3B6Z/grLfH43Q8d/pdkZ/OzdVRcdb/FYfbWEa2y3Z36z+b
         aTHaRyLhmFGkSCynkV7G0QI+cwcWnjK1qpx31PYhN1zT7bAET6McDo/Y5fThXHdO9Ek7
         zYHqR539+PQJrPPLRkOE7jflC+yHuXbTJUVLQrKHrysQdsbsiJzOBJ0HDbVrb0s28p6t
         kflfPrlWaRQdM1RMKSTS9mn+78aoixWKDx0joRXcRCUOTMxiomPR6k+4etm9NwgxSA31
         215g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lxookr95uMT9sOw8S1HRxQFBJ0wSUMPDNTYBScBbdzA=;
        b=ked09v/9vuJmUUGaqiDDZkk72ivCt8H+QvuF0FOOKeUtMzc1l0oefQ1TD1+hejQh8v
         tmsqFxnHudP9dfeLfQfDYuFppk/2w2yutdN0l3D31W38NjC//np7wodnyUYcugLbeWL0
         Cx/aIW7u3ytYps4p/prRY+3z0dmQkeTTHlf/+prOlomy+v2iyP/D1fYHfdTt5hoRuSHq
         ilRPIJ0fG3cyb/scnHYDq846hn2guvG+c0DPhdohyvEUS+ZeTInYf7cEqPnLlMYeaDY7
         7TTJtpPcKEt4NbaLHakOsLEvIJfwEWlkNosALVGKPYNOUMJURCmxVaPzjVrRRfmnTSz1
         V6hA==
X-Gm-Message-State: APjAAAVSC8XNO9lltKP8WBE7rEOQaBqlFVRj5YZMzLwX4AxIgddG/ewY
        96KgQPt/xyO/b3xi/bqHkK514Npm63BrAG8UJ5M=
X-Google-Smtp-Source: APXvYqy5WQVZIH4BmgA2vfXXE0nLc6aKF5v7DRRaYQ9YrQPB5qUQFSJiOmM2MmnfKMB9bJuYwXz6LVby2vjMPQ9mbfI=
X-Received: by 2002:a63:d306:: with SMTP id b6mr15679209pgg.338.1572646336234;
 Fri, 01 Nov 2019 15:12:16 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:41 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 08/17] kprobes: fix compilation without CONFIG_KRETPROBES
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

kprobe_on_func_entry and arch_kprobe_on_func_entry need to be available
even if CONFIG_KRETPROBES is not selected.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/kprobes.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 53534aa258a6..b5e20a4669b8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1829,6 +1829,25 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 	return (unsigned long)entry;
 }
 
+bool __weak arch_kprobe_on_func_entry(unsigned long offset)
+{
+	return !offset;
+}
+
+bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
+{
+	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
+
+	if (IS_ERR(kp_addr))
+		return false;
+
+	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
+						!arch_kprobe_on_func_entry(offset))
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_KRETPROBES
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
@@ -1885,25 +1904,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
 
-bool __weak arch_kprobe_on_func_entry(unsigned long offset)
-{
-	return !offset;
-}
-
-bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
-{
-	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
-
-	if (IS_ERR(kp_addr))
-		return false;
-
-	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
-						!arch_kprobe_on_func_entry(offset))
-		return false;
-
-	return true;
-}
-
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret = 0;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog


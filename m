Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7572F0A94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 00:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbfKEX4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 18:56:37 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48287 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbfKEX4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:36 -0500
Received: by mail-pl1-f201.google.com with SMTP id t5so12057883plz.15
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rtGYhrlT+v4glRCgBr5KwA8OmlbDFJXwY4ztX1r8N4Y=;
        b=TKd2so4t7KdR/7IGrMM7dl1XICyaB7Ep2xb2K+L1YFpFhAdGCuA+QVKoOX+2nBhRS1
         PbhJFwrDkZsuR4g7Ll5jibhYYSoSbj6Qsk2MbBrD3K/3RVFYn3Ze4sq2kV7P6t82dOWN
         zANq01dIUJjLIJAHUFq7xMVXaYxiN41idA7UoNEeJpkXFp/ZWlp+zSbMC4BIJqBb48KR
         4Yz6i7rx8RTibsrTijP0CrOXXl43bw03Swi1hDDM7ENVWaU1ch5tyPwrarZdzghv3p22
         6EIfdhBRrf+kmU4AHHY+5aG/aq0yLasD+4SyCQWE2lPdStxSTwo8liAyHr/FcLSygxFM
         ArVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rtGYhrlT+v4glRCgBr5KwA8OmlbDFJXwY4ztX1r8N4Y=;
        b=VrjQ1NVEivxoHUvL3U2siRplFWC1kB7YOWRQkhk4bCQ+3tsdxSGwU70NbXyzW0GeD/
         qtK1O4BZZwxMQjpmv3A7nj4Pqxs8mbTBI9PLvkkwc9laXxZD8r1CHRiMiEA1+j/IgFK9
         ghzSTWfMwxMhlDCHPU67xU9Gt4ziz2sggKivBq7hneGORukKwVnKu0Os5tWZGKb2lqTF
         Bm8XFk/WMy6PJLEp1pPCAo0zhUP7r0uNEzzIlp9/ixBaGsNUF9CRPMNybxRv8OB/p6yN
         JsWkuOeI0Jrqdcg8i/PSe/H0IAcHDMi6SgaCkQY14RT8GCfOvri+/WbvfhGOhV2Hhuym
         UrhA==
X-Gm-Message-State: APjAAAWR/9nYcEcgrk/szmnUlKMtL24nLxnYsP9bW4vNJucSH2gnCDEe
        hi8RNa6txZVd6sHMrz9nR6p/xEouVNvwnkAY1LM=
X-Google-Smtp-Source: APXvYqyeiXNhg0SMmYGCzlPE1MJNPVlZmSKCnBjsXssOcDuiJaeCfp0JdeBqZLhwpNQMgciNZVJzMgpXUPeRRsEDFOQ=
X-Received: by 2002:a65:6149:: with SMTP id o9mr5335991pgv.228.1572998195111;
 Tue, 05 Nov 2019 15:56:35 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:56:01 -0800
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191105235608.107702-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 07/14] scs: add support for stack usage debugging
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

Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks. When enabled,
also prints out the highest shadow stack usage per process.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index 4f5774b6f27d..a47fae33efdc 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -184,6 +184,44 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static inline unsigned long scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = __scs_base(tsk);
+	unsigned long *end = scs_magic(p);
+	unsigned long s = (unsigned long)p;
+
+	while (p < end && READ_ONCE_NOCHECK(*p))
+		p++;
+
+	return (unsigned long)p - s;
+}
+
+static void scs_check_usage(struct task_struct *tsk)
+{
+	static DEFINE_SPINLOCK(lock);
+	static unsigned long highest;
+	unsigned long used = scs_used(tsk);
+
+	if (used <= highest)
+		return;
+
+	spin_lock(&lock);
+
+	if (used > highest) {
+		pr_info("%s (%d): highest shadow stack usage: %lu bytes\n",
+			tsk->comm, task_pid_nr(tsk), used);
+		highest = used;
+	}
+
+	spin_unlock(&lock);
+}
+#else
+static inline void scs_check_usage(struct task_struct *tsk)
+{
+}
+#endif
+
 bool scs_corrupted(struct task_struct *tsk)
 {
 	unsigned long *magic = scs_magic(__scs_base(tsk));
@@ -200,6 +238,7 @@ void scs_release(struct task_struct *tsk)
 		return;
 
 	WARN_ON(scs_corrupted(tsk));
+	scs_check_usage(tsk);
 
 	scs_account(tsk, -1);
 	task_set_scs(tsk, NULL);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog


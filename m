Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A606CDCA87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502540AbfJRQLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 12:11:16 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51607 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfJRQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:13 -0400
Received: by mail-pf1-f202.google.com with SMTP id s137so4952508pfs.18
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+oBtFp6IQZ5946CFExp5BXllfwypP5AUtOYhvu+6eDg=;
        b=uErhWC3lFP8THQ9YjycpXkAl85COCd6lh+RqxQAfdCNUSVTiEfspc2alvbCgArV2fu
         ls4p2vGwJ3M8+8dC+pxUbBcocxnmbIOx1oZI7haycpR/idqzr0yRfNB9QU0r3L0Ad+LB
         AODIdu+bBRBco2jvuX999sV5JPTfKSeK6DQgqagm1V48qwgIQ9QQo3kPVBNgSxrwUzDc
         J7z1g1ZIddJjuwZ9NXT+KTuZuEnEru2YIfSdVRPO6N1MNFiWgJDAJs9A6AicwQY5z5mf
         Ozj1xQ9RCTG/l6zakh/4DEHsBfg5zP3zC8lFWduaZXJzlKOfJV8siLAxWkKPzGoNNYpY
         BIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+oBtFp6IQZ5946CFExp5BXllfwypP5AUtOYhvu+6eDg=;
        b=as3hmCfz7S7byGXcozV+VI4gbB53mhJGEX9v4Dg2vuIpZmfRTSu32ELcmx3b80cbVm
         SqjE6NfyuVFXV0nnBWVpAv4ynMLJaShPug7ZVrC83BiNekvAMBgbTplARoXEWwQpgj5R
         7oZRyBLM4NKO221y6Dj4ZC3ZTcalpfGF9/0lEso+rmDNqz4VCUpYtFSn+HyosxOOoXcT
         iSXmZrdSip57fuxnAp8oYT+Mm4edGYxFjMMvc8PeSOWANW2XW9BKX4j5iQTTW7jlhNMf
         ckejVkCDgTgbtFoB4e+0u/QaeyhzJCv3FS4AYQv7WIaCZvlcV/vSxHtSs6IFHUpvluFJ
         2pRg==
X-Gm-Message-State: APjAAAVlNyaV/aBrqRuKmJz1ASUcZDRT2CxifykRLURqjVgGsGBmdzTu
        ryDaajylh8UhfkjjU2lwl/1jy0JlNFKxL3N13Q0=
X-Google-Smtp-Source: APXvYqxHqmmpD11MJRO6yuoyBvltYKFWJkQq7UxJVT4qvc6swUR9mDIPTvziXaDvcDGhe+mECq8Qr7PX0sGP/3daZE0=
X-Received: by 2002:a63:7845:: with SMTP id t66mr10836733pgc.31.1571415070584;
 Fri, 18 Oct 2019 09:11:10 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:23 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 08/18] scs: add support for stack usage debugging
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

Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/scs.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/scs.c b/kernel/scs.c
index 0e3cba49ea1a..1ec5c5a8dfae 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -161,6 +161,44 @@ int scs_prepare(struct task_struct *tsk, int node)
 	return 0;
 }
 
+#ifdef CONFIG_DEBUG_STACK_USAGE
+static inline unsigned long scs_used(struct task_struct *tsk)
+{
+	unsigned long *p = __scs_base(tsk);
+	unsigned long *end = scs_magic(tsk);
+	uintptr_t s = (uintptr_t)p;
+
+	while (p < end && *p)
+		p++;
+
+	return (uintptr_t)p - s;
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
+		pr_info("%s: highest shadow stack usage %lu bytes\n",
+			__func__, used);
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
 	return *scs_magic(tsk) != SCS_END_MAGIC;
@@ -175,6 +213,7 @@ void scs_release(struct task_struct *tsk)
 		return;
 
 	WARN_ON(scs_corrupted(tsk));
+	scs_check_usage(tsk);
 
 	scs_account(tsk, -1);
 	scs_task_init(tsk);
-- 
2.23.0.866.gb869b98d4c-goog


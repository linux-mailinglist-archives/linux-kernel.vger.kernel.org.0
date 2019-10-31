Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB1EB547
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 17:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfJaQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 12:47:29 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:32907 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbfJaQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:27 -0400
Received: by mail-pf1-f201.google.com with SMTP id g20so5019987pfo.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J83AV+8pmxy6MQ8Uszleewce6gVoMir4DYxUv0MBtSY=;
        b=JwFwWyNMv/RSq1lmIG7yeu7XzK5N0yGFebd9HD0oWd+L64cVHCjNrLKXvpd31A8m+o
         zacFSlAh7/S3GrsWYw8wOsz2riJzwAmUFphK9R3y/YJdaVSd/jkXF/Q3qSE7wm8QON6m
         8mWRne5R6DOJ3KZmWMsv6rx2Y/vxcHDIQsZfg/5fmf+Zp5HlVd7VP1G5fKtX4FB8a3Bm
         8RVCvD6+cudu/Eg1HxbSqa7xROHq/x3T25smtETOf5KVnSr4x5SBcV1jFg774W893DEo
         G58Q3hgq+5V0/nL/ilZ23sMkgZGieLq55EJ/1/61Mg1lGY8hcPLmSpXvq/AV5DgETbO1
         ZBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J83AV+8pmxy6MQ8Uszleewce6gVoMir4DYxUv0MBtSY=;
        b=Z0EMCNRuN+uQtQHak0sBGa1tkrjYYOTF/OY4ch+jZaqt8lwBNbx7Wr+uR8l7s1+s0m
         XvpevgDZDZpr/2/gS1ml26DK05H4VwB0k9caPro/ddoeZNAzsHoczBxQXlHx4XFHXuxe
         VKxqZF59stDp1PxYbiPNtLq40+ILcyiFSaFAbonnAjMo/uOEK7TWdZ75rarTUopKnPEe
         pSLNhRS4h3OuiLR4hqW1oDRt+0I2biGdwYfUrBKlAHXavUPdP808UXdeulnkYjHBWD4h
         xC/1hRh3LBP6wPAAQJP5x+wDZnFVRdzcQEgZFM199PS418tnE2WCjqETfSijsenJceO3
         XCIQ==
X-Gm-Message-State: APjAAAVqDuY/+5H17ZpPlV0BwBtNPG2vB4a2IixWT+NARixwNzXGYP7i
        JZtCm5V7TdMAPj1rWa592Tuza76HVa13b/dztCI=
X-Google-Smtp-Source: APXvYqz5tyIdUbH5XenlPdO5u18Bp097Z3l5i1ng81ta9dMEULM4omVmWKyeE1529Bf0daIn3cRdGv4Ho7NXy7c+5zY=
X-Received: by 2002:a63:e056:: with SMTP id n22mr7564302pgj.73.1572540445818;
 Thu, 31 Oct 2019 09:47:25 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:36 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 16/17] arm64: disable SCS for hypervisor code
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

Filter out CC_FLAGS_SCS for code that runs at a different exception
level.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index ea710f674cb6..17ea3da325e9 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -28,3 +28,6 @@ GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
+
+# remove the SCS flags from all objects in this directory
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
-- 
2.24.0.rc0.303.g954a862665-goog


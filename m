Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B97163828
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 01:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBSAJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 19:09:02 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39300 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgBSAI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:08:58 -0500
Received: by mail-pl1-f202.google.com with SMTP id q24so11076722pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VaL1LZE8ycQeC44ksYepx5tOKr2VfyNgExyF+AnjA94=;
        b=cePll/TraKAUtAJ9SZ2Ia3LSLdgIxY1+FH9CeJe/Js8mU6ZMYsSLXkd7mkxW/sP5DZ
         KJT+Ei4X/Kieg25Nl3ijU9ilrBU19coqFUri04BfLyqK5EuVRfmB30gu2bmvAalUS6LN
         IMbhUPvGvYnYBxafAZ3iZSnwZoQLD7C4koK0IuRjhEPW0oZ2TaiJ9hz4upmRG6/Ns0dh
         UTADf0Yy7wZKSoYV844RlPmV80QoHhyiDwRwibkak3UTghfYE1JKAvnv9As5XVJ0WJ7a
         4rEss8BdwPK/XsciPHFcrXzGvsX8Q30c1NJSo5SBc2z3lUGDDitPI+TJwEDkMrNctWZh
         TcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VaL1LZE8ycQeC44ksYepx5tOKr2VfyNgExyF+AnjA94=;
        b=t5KcFr0xHR39vj9KdSrn/u6iSpDZToQOCdbkqvRR3+bmjfEHUAi+5VybNO+PEQMcBa
         0LSfN0HxtmD2jDenoMtkJ0pI2MPgBxEzSSm2tc/+pLDEUcBLR9Rjkd0U7Qfs0Cwfp6xb
         CxwkjV6k1cy5CqQU+HbfdcgBvFgTG1xiNVcG6auq2GM+X8iS28ST68K7xRuc2ttagUeu
         l4JlcoVjR+HPGadcKO66gfP02ysRHSOkdHtGzPquJDVjGJABd/VDLdEjVHxIyQ//DY7O
         CvHhYrhclc46nEJypbz7LojIFt/4roaDYWNIIIPeYx1UjDm06IOe6qgpEL68wCKzhrW+
         sdjg==
X-Gm-Message-State: APjAAAXoK1iS38lcWjNgSF/tPmc/hWEea0cMmiitGgefsfoIXaAhAIMR
        Y8niwiOaQczfTV5o/OiIgM5t6fdR8+Q318Cdq18=
X-Google-Smtp-Source: APXvYqzYgoNmANIZrWEkIv02R5SWh6hiOCKzMRDH3zyUcr6xB+/h3Rs6ymsqIKfuYLDLk6+SeJ73cy3XJLHa4n8oA1M=
X-Received: by 2002:a63:c846:: with SMTP id l6mr25182558pgi.144.1582070936327;
 Tue, 18 Feb 2020 16:08:56 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:08:14 -0800
In-Reply-To: <20200219000817.195049-1-samitolvanen@google.com>
Message-Id: <20200219000817.195049-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200219000817.195049-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 09/12] arm64: disable SCS for hypervisor code
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

Disable SCS for code that runs at a different exception level by
adding __noscs to __hyp_text.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/kvm_hyp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index a3a6a2ba9a63..0f0603f55ea0 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -13,7 +13,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/sysreg.h>
 
-#define __hyp_text __section(.hyp.text) notrace
+#define __hyp_text __section(.hyp.text) notrace __noscs
 
 #define read_sysreg_elx(r,nvh,vh)					\
 	({								\
-- 
2.25.0.265.gbab2e86ba0-goog


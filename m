Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1216F16ECBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 18:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgBYRkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 12:40:17 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50806 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731170AbgBYRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:40:12 -0500
Received: by mail-pl1-f202.google.com with SMTP id g5so7851828plq.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/9ynHIjebmTtgZE9DUTlwVjGdkmD9QfvZQiqhOExK9Y=;
        b=o7vwSCWzTZQYP7RYWcSjGD6CpDAB5oOvCiPmaDLzo25KnXRfX+NUrDok0q2y0mGfIa
         TDZrXM9faPShPRy4a6WiU0N5UIJawHlnPCJfHebtHrH5fvwpUKCDI+tLjTcvUoZXDeaB
         HCszEPkk37N+dLtmZiSu0APRUzakK7UtyMUDF5BWhTy6i22v7izEycfB2f+6f0SG52UX
         a6DuVXYMOkhGQurfoTI6OFw6fWv0lxkEhyIlwp/KPXUNbvGuN/nLmhBhm4IMlnyF0qei
         Qo7+V5ZpS5ueHVWgq55uxj/h3LF9pK5y+dwb8XA7OUhBm3/Bp2RIxaOxSVJIBZIb1iZV
         Wu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/9ynHIjebmTtgZE9DUTlwVjGdkmD9QfvZQiqhOExK9Y=;
        b=ci2qjDcBeMssE8QzFgTDwpoP9TS14zmN593bWB1IBCcSi6InI/k4wN2pB+N+wfUE4o
         mTAy6HMzHjQl+2SvhBJ32//Tz/n/vrN2kVjpBWiM7pHRcji8argJnPUcvZo0QZ3Geb6B
         3AND/dweZpQazvFeNHWEzpR52EZx1ViF8479I3TvIv4bFFkVe8Ae0YiERGcmSF29JycY
         dQJA3/irsxDl3f3F1zfMOzWB0aS8wsBoTVUct80ivXOPwDavyZcCsooZDZ6sgi5CdR1C
         nLFksLTE0yTttCFG68OMk3q1EagOBbVGdE3XxcNhUcPJvmd5s89S8ZdbbpIVgi3LYD9F
         oS2g==
X-Gm-Message-State: APjAAAV6drk6Dq2QeVE3I9dIgmGLWtXk4jvbrJrBNNw3PkVzS14MlV/8
        duiLiNVBqYMpJXK4r58f86Oy+jbHlDHwo3S2pQI=
X-Google-Smtp-Source: APXvYqxvXT5YFgJDX3OV+onXaZib4AkO6FSAZUIUlR7kvR8/LVLBi4op9vXOxKw+pDWwfIzeWhkA7GqRpKGKFMrVwjA=
X-Received: by 2002:a63:5a65:: with SMTP id k37mr60903965pgm.264.1582652411820;
 Tue, 25 Feb 2020 09:40:11 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:39:30 -0800
In-Reply-To: <20200225173933.74818-1-samitolvanen@google.com>
Message-Id: <20200225173933.74818-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200225173933.74818-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 09/12] arm64: disable SCS for hypervisor code
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

Disable SCS for code that runs at a different exception level by
adding __noscs to __hyp_text.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
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


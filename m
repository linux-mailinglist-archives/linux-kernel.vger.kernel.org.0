Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30C3ECB16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 23:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfKAWMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 18:12:24 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50323 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfKAWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:22 -0400
Received: by mail-pf1-f202.google.com with SMTP id e13so1781328pff.17
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TmDnfQN5KSEC3g/578TQjZ7QNjxfyUPcu+BQjF9Yuvo=;
        b=WX+ZlyX9au7TTis+HDd7Dbd6apXsSxGT4BjPuLcLwhq8XdU1hWXuu+jMmXXpmqn/ly
         JnciDuOZ2YKOinrTMYHNYjglGY6CBM9JRa6UwI5ny+82cASaJNLEYq03XkrGGMRD/45C
         080BYykDqPbpaWcEFlq6ukx4uUgLPbDYn8rQoXBjaKsPYUg8U6UVKNYt0gsSY+aCZh6t
         sDQ/hg4YUpFcnNlIJocP1LkLyLwN/E6CPVe3fwUCeFBsqzz656n40juIl8qkmBDC5VxV
         leO2fOlOj+kIu6XcB0vIjnzmxkmxh31gkv9F3DRvB4cNzr9altIj/aQ4Xeb30TvjIhYS
         CEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TmDnfQN5KSEC3g/578TQjZ7QNjxfyUPcu+BQjF9Yuvo=;
        b=FQyLpGdLr/quxmidkg6XyJaF2FW4wvOQzvDOdnJ18Bs9j7+OKZAcSXfefruZNHR+Xm
         DYOkQtvw9PulU/m0Vk0p+UoJvjblELBKA6/Z3Awy4mT2HjyrozJw2oDUFAH/phln1ssg
         akmb60mKhay3P0STrleFyxLe89o+/zccwybST6Z+z/4Ct4cnq5NDTFORSvoV5aavNUpm
         Im9B3ljipGgaMPnV1wVxMxTVmmvYhxgmq9xsusf6KUDtFxt/8gvIq5X1DYWtEVuIEScp
         3qQ1Txo4JTKlv6bLxUXEIMRRl3AmsrVVQL03AIn8ANLGEehIz3Vnp79aF54pdOhkCjrv
         N2EQ==
X-Gm-Message-State: APjAAAV1N+Px2FbldOvJy9F6sIjdlQrI+juvcdnCN1zyomtt4PscYcS+
        3bJ0SAsD+vmAhTVzqLXeYgGW9AnQ7kptBZY9BCs=
X-Google-Smtp-Source: APXvYqzVngOFcUfwiWQ8eDwuiV8sr1oY1W9Y7iX+20vU9uQZSIlJayld9jxLG7yCiTZmX5C4MT0to41bsvZhb6iCe1E=
X-Received: by 2002:a63:364d:: with SMTP id d74mr15884929pga.408.1572646341266;
 Fri, 01 Nov 2019 15:12:21 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:43 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 10/17] arm64: disable kretprobes with SCS
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

With CONFIG_KRETPROBES, function return addresses are modified to
redirect control flow to kretprobe_trampoline. This is incompatible
with SCS.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3f047afb982c..e7b57a8a5531 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -165,7 +165,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
-	select HAVE_KRETPROBES
+	select HAVE_KRETPROBES if !SHADOW_CALL_STACK
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog


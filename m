Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B7DCA88
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502562AbfJRQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 12:11:17 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36825 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbfJRQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:13 -0400
Received: by mail-pg1-f202.google.com with SMTP id q1so4602782pgj.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xX5gUTsoboVAmCrU5x0kxTyEAN1I1znyOrkoj+71V3E=;
        b=cCT9hs91spgek13wGsP9y0ttC9ve4IQ6YalGlMpwduvwu42Woqshf/GsDukku4Rd7z
         LzngBaQqis4pXbheJCLuLc/BuznaLuuhhZ0eQYxuqnnHcZIUFUvXDs57h723E1aVsqCN
         hDJ9NJVmzOzxHezv4iMvDqkeOoKw8JtHeSXKma4kAFNaEABY3mU6axzTP9w4Lq+UPCd3
         3Ot78e0aaFfEd1x8s4TQXDNAkM6/+cID/LMqGDex4NuLmCmij2J8d1teYJAiH7hir7mz
         bJcHXcpZNWl2UPJrt20n+Cj5d8KKW3//pqk3cC5O9Pz9D8EOb1EO2oSOjKTQQUWNt+am
         FQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xX5gUTsoboVAmCrU5x0kxTyEAN1I1znyOrkoj+71V3E=;
        b=RYAHHsfwFUrqU4Lwik5gVm3j/J5aFumFsN8GzqEyzVhuSnl+a4s3y2d7s3W3saudRp
         E2Ja26KWleP2R0Om9AHs+64WYiVFx2J3Z6VKCUB3UO57HAzFcp9w4+YhGkFJW7Hk4kbm
         h784wH7ZwDtkGkKh1Q0BoNUiFhVcfiqKqMgopGk0m1u3zvwJHVM15W0jU5A+fHJZsaxF
         /6hdCsZVDY5HCAYkOfKZOAlHhDyvh3rIxGhDgrq+lp31xStIcKFKCzHluONG/GU4Wpxb
         DS3js/cbi9HVk7v8G1tkSI6XedjCSwI64utiV8/n3moa6+zJejQHfbv2aAuS9pkq2TLx
         4ehg==
X-Gm-Message-State: APjAAAU2FRI7rUj2n1qZ8xs/HG2NM95v6bFRZOmxm1C0bioyoWtZy+JG
        /BEEqLqwWKw639zMQn6OOrquwEH1IRtOi8GGfiM=
X-Google-Smtp-Source: APXvYqxwiguloHdhaLpo4FBp0WjObBKG43Zxu/Qf9Jmum2rfBGkEmvxrlieIAShHEtrTW/4mJFtXISqp4bSzlzbpPKY=
X-Received: by 2002:a63:e148:: with SMTP id h8mr10684150pgk.297.1571415072880;
 Fri, 18 Oct 2019 09:11:12 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:24 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 09/18] trace: disable function graph tracing with SCS
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

With CONFIG_FUNCTION_GRAPH_TRACER, function return addresses are
modified in ftrace_graph_caller and prepare_ftrace_return to redirect
control flow to ftrace_return_to_handler. This is incompatible with
return address protection.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/trace/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e08527f50d2a..b7e5e3bfa0f4 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -161,6 +161,7 @@ config FUNCTION_GRAPH_TRACER
 	depends on HAVE_FUNCTION_GRAPH_TRACER
 	depends on FUNCTION_TRACER
 	depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
+	depends on ROP_PROTECTION_NONE
 	default y
 	help
 	  Enable the kernel to trace a function at both its return
-- 
2.23.0.866.gb869b98d4c-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA0ECB1C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 23:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfKAWMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 18:12:40 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36837 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfKAWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:36 -0400
Received: by mail-pg1-f201.google.com with SMTP id h12so8049832pgd.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oB4lIvjzdBiHgRAUphuiQVPgI+jp2K5bMoUCGUiH4hk=;
        b=mLcd5Ko+fJmhjxDMoBpGZ3EPC3b/VP/PBLdcmlypMJNdCOc5u9jhjSLWUNRMYr69hx
         U2P5JSWVYdV6u8EzfA94UAbX9w5Q1ZrloIyJVyjdf/ObF5XN+RiQraEntwZF84tiJw4A
         SKbzKEtQORywvZdxPhMYx0LHvfikuCCPY9XvjfKtjRiin1Jn0QFeomQACCaJo3jt8lCW
         KyuDz5lfuSMpAGWUw7ut45j+6bJefZga8POnR6VI0FVyWw/cL8vyvxBQD9C59E1UjFOA
         7acbvIVDECPMMh62wKUfHOE3f3OZYuymQJbmahdFgydr8nJ0p/3u8CSBUyJzVVefqNG+
         Z8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oB4lIvjzdBiHgRAUphuiQVPgI+jp2K5bMoUCGUiH4hk=;
        b=nS0W8iySoJXR3tyEUc1gWB72bj23LW7BoDqKjK9V2WtIhrFXA7iGjIegRJNIKzDct1
         VaYt5NttTXW94STInSDfFVhV2VQZIwcTlWc62/Bqq6aiEdaM6HBifNce7UlgPsu23LT4
         CbbWsfTyHb/zGT8fZqcq1wx94w4oRIzr1THvehd8BsyAsCCUzYPTQtfk2JQU+oivSlP6
         XUpolHyRtFhW8H2xXoZk1spWn0VANkDP/jBHuyg+fzRyyLqsD4QfdfGy/EGoih0smubG
         +PTN8CmS7TaaeZHBb71om00Hrv4qbU4dVRrdWOP8zKl69xt9ilD9TdR9u952JntsgCwr
         Awzw==
X-Gm-Message-State: APjAAAWqxWrH72nAl6FWwQvh8SPCYe7SmSLlVSBv0iXZjFYvxbuklDws
        ZRX4JaS8BsDZoNv0CvAj3G/sCx5B2dgVRuqqvNM=
X-Google-Smtp-Source: APXvYqxeW4tUSlj5Rjy/RV2utncaJwaQyF3tWO3lBVE2VevumOyR70VNIZ9Nj/gJhm+HF4+zxBXbctrnYgLnOQF1Wjw=
X-Received: by 2002:a63:d20c:: with SMTP id a12mr14724175pgg.402.1572646354642;
 Fri, 01 Nov 2019 15:12:34 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:48 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 15/17] arm64: vdso: disable Shadow Call Stack
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

Shadow stacks are only available in the kernel, so disable SCS
instrumentation for the vDSO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index dd2514bb1511..a87a4f11724e 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -25,7 +25,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 VDSO_LDFLAGS := -Bsymbolic
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
 KBUILD_CFLAGS			+= $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog


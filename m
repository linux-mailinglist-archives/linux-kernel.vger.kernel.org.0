Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9478F105946
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKUSPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 13:15:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37865 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfKUSPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id b10so2011009pgd.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JQs/4UxemMcGCjHZn4niB7nA1rMhXtjAz7kJK3AjL7E=;
        b=KrN4zpR8IEwpUQr4jn2KWwjZqUoeisnx3Am9Bp+lgiRIdx5345vx29iTTUFknjeFFQ
         Rj9A+pMLGH7kZeXTTYnjwo6xAzbqdCNRhagoYp/K8ogsyNX8Xx9jAt66FmI5COUA2UiY
         gHkW3zyflbmt4IHuKfJMdE/2YCaQqpLZhk71I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JQs/4UxemMcGCjHZn4niB7nA1rMhXtjAz7kJK3AjL7E=;
        b=jVp8LpNZjD+jVqj0oEgrmPUb7d8sSPQeX6ZVug9aF8FOCHuCcpW61VjGLtKkuma/rK
         mkLgFGsEcFzRBZDUwZl5pQShp35ky9oS4EXktD+Ii4RzxRKXtIzyiaS6t4dI4zsPbCs1
         TRlqIxYykXaGgUFSjowfliejb7O1XhitixyLjDW0CRcaZk21ca+rYAccPIgLMQnhVVtu
         7cOjrbwljf/IzC5DQxF8P7WlfO7Fgy1WV9hgD5/9Mg4RlqnQHBLTqPP9eqGZLEcA8YFx
         hII8Nus8kGhUxZpI0biBcnFREzugeSNCTds7MNYEtpXp/XYv0PpIcc8rYRH9Uw+60nWV
         TKpg==
X-Gm-Message-State: APjAAAVM+JArlmr6xFBMtqiFjqMqzQdbZqVukGYWPQx3gssipbmVcXNl
        j5nvNucJKJU4d6YKEac3ThtQNg==
X-Google-Smtp-Source: APXvYqwbG0mlD3ppkkL3k31yuwYGe/H5GA3+ceT+WKtRCMUFj+fEDoGxidbBeBr46DZ2WJ27O5jcgg==
X-Received: by 2002:a65:66c7:: with SMTP id c7mr10861530pgw.407.1574360130724;
        Thu, 21 Nov 2019 10:15:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s66sm4289099pfb.38.2019.11.21.10.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:15:28 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 2/3] ubsan: Split "bounds" checker from other options
Date:   Thu, 21 Nov 2019 10:15:18 -0800
Message-Id: <20191121181519.28637-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121181519.28637-1-keescook@chromium.org>
References: <20191121181519.28637-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to do kernel builds with the bounds checker individually
available, introduce CONFIG_UBSAN_BOUNDS, with the remaining options
under CONFIG_UBSAN_MISC.

For example, using this, we can start to expand the coverage syzkaller is
providing. Right now, all of UBSan is disabled for syzbot builds because
taken as a whole, it is too noisy. This will let us focus on one feature
at a time.

For the bounds checker specifically, this provides a mechanism to
eliminate an entire class of array overflows with close to zero
performance overhead (I cannot measure a difference). In my (mostly)
defconfig, enabling bounds checking adds ~4200 checks to the kernel.
Performance changes are in the noise, likely due to the branch predictors
optimizing for the non-fail path.

Some notes on the bounds checker:

- it does not instrument {mem,str}*()-family functions, it only
  instruments direct indexed accesses (e.g. "foo[i]"). Dealing with
  the {mem,str}*()-family functions is a work-in-progress around
  CONFIG_FORTIFY_SOURCE[1].

- it ignores flexible array members, including the very old single
  byte (e.g. "int foo[1];") declarations. (Note that GCC's
  implementation appears to ignore _all_ trailing arrays, but Clang only
  ignores empty, 0, and 1 byte arrays[2].)

[1] https://github.com/KSPP/linux/issues/6
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92589

Suggested-by: Elena Petrova <lenaptr@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 lib/Kconfig.ubsan      | 20 ++++++++++++++++++++
 scripts/Makefile.ubsan |  7 ++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 9deb655838b0..9b9f76d1a3f7 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -25,6 +25,26 @@ config UBSAN_TRAP
 	  the system. For some system builders this is an acceptable
 	  trade-off.
 
+config UBSAN_BOUNDS
+	bool "Perform array index bounds checking"
+	depends on UBSAN
+	default UBSAN
+	help
+	  This option enables detection of directly indexed out of bounds
+	  array accesses, where the array size is known at compile time.
+	  Note that this does not protect array overflows via bad calls
+	  to the {str,mem}*cpy() family of functions (that is addressed
+	  by CONFIG_FORTIFY_SOURCE).
+
+config UBSAN_MISC
+	bool "Enable all other Undefined Behavior sanity checks"
+	depends on UBSAN
+	default UBSAN
+	help
+	  This option enables all sanity checks that don't have their
+	  own Kconfig options. Disable this if you only want to have
+	  individually selected checks.
+
 config UBSAN_SANITIZE_ALL
 	bool "Enable instrumentation for the entire kernel"
 	depends on UBSAN
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 668a91510bfe..5b15bc425ec9 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -5,14 +5,19 @@ ifdef CONFIG_UBSAN_ALIGNMENT
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=alignment)
 endif
 
+ifdef CONFIG_UBSAN_BOUNDS
+      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
+endif
+
+ifdef CONFIG_UBSAN_MISC
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=shift)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=integer-divide-by-zero)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=unreachable)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=signed-integer-overflow)
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=bool)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=enum)
+endif
 
 ifdef CONFIG_UBSAN_TRAP
       CFLAGS_UBSAN += $(call cc-option, -fsanitize-undefined-trap-on-error)
-- 
2.17.1


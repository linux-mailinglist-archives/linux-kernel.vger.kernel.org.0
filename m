Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5118A2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 20:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCRTEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 15:04:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46741 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRTEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:04:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id r3so3541712pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9sJyPIS9MqiGD0DkB/0XejsZsmuSIXG8S6Q+9dvyB0E=;
        b=i146djn3/XFsXRqyCdh52CCACkJdrCMQ4DY2IU9cmSWFAg7wmi3yuFfQXSGy11xx63
         Ex7oICQ2hMFta1eTmsejUjSNbUEBlnpI8Fv2dvySf5tmBbCd/EzgdhcPVJFxPIlriQJd
         chXKEOzl1rzrZpwhPVz4zw9Va2rFqzlczu9/rVi2s0f8lFCDjIWtcfrey+SKHfrpHpDJ
         +fQroK0d4W6tEpmI2sccXQ0rXse1JQuzBHiwyOuDXcqOsUKkkDDguZj03PGYADTJJBrB
         rM55iVC55h9iLUNM+dgwgnpl1e5iaNnGlLIqU/4ScQeFPJnpZN3ajXrotLu659R/7Dkn
         VnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9sJyPIS9MqiGD0DkB/0XejsZsmuSIXG8S6Q+9dvyB0E=;
        b=LlqZFfW3UdNXwEcea8MeOFNNZTLF457ViTes1cY5C7i8kQXfwuPRMB39jBNE1/+0kZ
         5UhFphKzgnRm77yU2WrqRmZWpu+uTRxkJhVd3jjxSuyKsZw6DywCE5rVXFOtAg0f61Zy
         qaMDdRbGic9r2jHAAhlTSmnpl9jvFdh+MnQb7EDr3vz299U/i5ACNbzpXyHECRtsoRDT
         22z2l3RJq80oLszKLCHvFpP0L5d4bqSBr8BHvVKGydnCx1RHvCbFiv0UGv9Uk6gBdX3l
         /8sn9QAMzQCu2h6AXhPaKuBEe026ZilWMrqW2j1vVpsZKcfOYb2KznrpYG0q6ecgNhLQ
         dS2A==
X-Gm-Message-State: ANhLgQ3fKpe5pjdcrNpljLbhcO9BaMt6zu6dBj6j18gxYXh/qxB9ePSB
        FMLDqpjOMEyTyMugVuMOrkY=
X-Google-Smtp-Source: ADFU+vsHoAUXbycPZi4v06uuQqoaoVPe6Uvo02jHlgFXB3NOurpeZ+/f9VeTMFabv0G/mNEIyUHZEg==
X-Received: by 2002:a17:90b:f16:: with SMTP id br22mr5821444pjb.170.1584558254608;
        Wed, 18 Mar 2020 12:04:14 -0700 (PDT)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e126sm7267968pfa.122.2020.03.18.12.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Mar 2020 12:04:13 -0700 (PDT)
From:   Orson Zhai <orson.unisoc@gmail.com>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     orsonzhai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Orson Zhai <orson.unisoc@gmail.com>
Subject: [RFC PATCH] dynamic_debug: Add config option of DYNAMIC_DEBUG_CORE
Date:   Thu, 19 Mar 2020 03:03:06 +0800
Message-Id: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is the requirement from new Android that kernel image (GKI) and
kernel modules are supposed to be built at differnet places. Some people
want to enable dynamic debug for kernel modules only but not for kernel
image itself with the consideration of binary size increased or more
memory being used.

By this patch, dynamic debug is divided into core part (the defination of
functions) and macro replacement part. We can only have the core part to
be built-in and do not have to activate the debug output from kenrel image.

Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
---
 include/linux/dynamic_debug.h |  2 +-
 lib/Kconfig.debug             | 18 ++++++++++++++++--
 lib/Makefile                  |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4cf02ec..abcd5fd 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -48,7 +48,7 @@ struct _ddebug {
 
 
 
-#if defined(CONFIG_DYNAMIC_DEBUG)
+#if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a..78a7256 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -97,8 +97,7 @@ config BOOT_PRINTK_DELAY
 config DYNAMIC_DEBUG
 	bool "Enable dynamic printk() support"
 	default n
-	depends on PRINTK
-	depends on DEBUG_FS
+	select DYNAMIC_DEBUG_CORE
 	help
 
 	  Compiles debug level messages into the kernel, which would not
@@ -164,6 +163,21 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DYNAMIC_DEBUG_CORE
+	bool "Enable core functions of dynamic debug support"
+	depends on PRINTK
+	depends on DEBUG_FS
+	help
+	  Enable this option to build ddebug_* and __dynamic_* routines
+	  into kernel. If you want enable whole dynamic debug features,
+	  select CONFIG_DYNAMIC_DEBUG directly and this option will be
+	  automatically selected.
+
+	  This option is selected when you want to enable dynamic debug
+	  for kernel modules only but not for the kernel base. Especailly
+	  in the case that kernel modules are built out of the place where
+	  kernel base is built.
+
 config SYMBOLIC_ERRNAME
 	bool "Support symbolic error names in printf"
 	default y if PRINTK
diff --git a/lib/Makefile b/lib/Makefile
index 611872c..2096d83 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -183,7 +183,7 @@ lib-$(CONFIG_GENERIC_BUG) += bug.o
 
 obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 
-obj-$(CONFIG_DYNAMIC_DEBUG) += dynamic_debug.o
+obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
 
 obj-$(CONFIG_NLATTR) += nlattr.o
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 243BCA6BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfICOz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 10:55:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33929 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:55:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so8024315plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltnYvwXNt85pQWYuu3Woofu2pXYpHtCxsiErjju1VKA=;
        b=fYYdJo80f5W8wLCBsV9PXpH7FmOumHx81yzdzpAabJEIhstQ8OpGzWB9Tvl1BjtS9b
         sZ+W/qIQVUO23yK4AuvPlsv0K6/h4c4+PdEoaD/gP7ooZjMZbs0SkfJVPWfIixna5F7u
         9Dq9BLMKPic+DZfVetTR9ZdJrkIROlyat+W3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltnYvwXNt85pQWYuu3Woofu2pXYpHtCxsiErjju1VKA=;
        b=g7l48nyDcC1p5Hh9KveF4LywkqK+DWzfDqr1+EIvUBcVd2bTY4677QgzwkfI/9IdUZ
         3Gt7pLSdZWN59YrxHzy5jbCMx0v44dhusau7exgBFscjntfW/qgpHhfisUuc91u9MxcN
         aIC+9lv6BSgPoWLUZqkIUmSuZ9TWd+fl3U5+p6ErZOui5aJufDJo+TchUYtdTuCtc+vJ
         clvvVqJNsAVFEuSpBLtxWeJLKYsDqoJY8hygvlckwxXJN/b7wC3/XNveBvLYwAlRc+qQ
         YApsEEo1BKZLTecmOBi/9VXamBLwBwFqh0x/HyOEFt80tL1FYDrrn2fYnYuQrhKvJrYY
         qxbw==
X-Gm-Message-State: APjAAAX3lHTfmsDrQQNJci5m4DOjBSPej6VU9SaFkbjs4dSIpUAMrOn0
        /BCCDOz3iO61XSbO30f87NsvJf5pxPc=
X-Google-Smtp-Source: APXvYqwpR52IQD3jhAG2BrnEaKYsfUMiAuK8F0vrmrcIq0PHbZ3D4ZwgyS4ZycQr97O3MeYII234dA==
X-Received: by 2002:a17:902:720a:: with SMTP id ba10mr33715784plb.231.1567522557013;
        Tue, 03 Sep 2019 07:55:57 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id y8sm19975257pfe.146.2019.09.03.07.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:55:56 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v7 3/5] fork: support VMAP_STACK with KASAN_VMALLOC
Date:   Wed,  4 Sep 2019 00:55:34 +1000
Message-Id: <20190903145536.3390-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903145536.3390-1-dja@axtens.net>
References: <20190903145536.3390-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supporting VMAP_STACK with KASAN_VMALLOC is straightforward:

 - clear the shadow region of vmapped stacks when swapping them in
 - tweak Kconfig to allow VMAP_STACK to be turned on with KASAN

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/Kconfig  | 9 +++++----
 kernel/fork.c | 4 ++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6728c5fa057e..e15f1486682a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -843,16 +843,17 @@ config HAVE_ARCH_VMAP_STACK
 config VMAP_STACK
 	default y
 	bool "Use a virtually-mapped stack"
-	depends on HAVE_ARCH_VMAP_STACK && !KASAN
+	depends on HAVE_ARCH_VMAP_STACK
+	depends on !KASAN || KASAN_VMALLOC
 	---help---
 	  Enable this if you want the use virtually-mapped kernel stacks
 	  with guard pages.  This causes kernel stack overflows to be
 	  caught immediately rather than causing difficult-to-diagnose
 	  corruption.
 
-	  This is presently incompatible with KASAN because KASAN expects
-	  the stack to map directly to the KASAN shadow map using a formula
-	  that is incorrect if the stack is in vmalloc space.
+	  To use this with KASAN, the architecture must support backing
+	  virtual mappings with real shadow memory, and KASAN_VMALLOC must
+	  be enabled.
 
 config ARCH_OPTIONAL_KERNEL_RWX
 	def_bool n
diff --git a/kernel/fork.c b/kernel/fork.c
index f601168f6b21..52279fd5e72d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
+#include <linux/kasan.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -229,6 +230,9 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		if (!s)
 			continue;
 
+		/* Clear the KASAN shadow of the stack. */
+		kasan_unpoison_shadow(s->addr, THREAD_SIZE);
+
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
 
-- 
2.20.1


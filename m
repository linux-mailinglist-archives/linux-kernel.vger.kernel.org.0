Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9631A54BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfIBLV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 07:21:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33911 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbfIBLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:21:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so7358050pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltnYvwXNt85pQWYuu3Woofu2pXYpHtCxsiErjju1VKA=;
        b=KJvuFZFemq48CN49xAn0XMdT8Gd11s5/DG4skkXmljGh5sxOZA2vVU9YWSmBRnhQIL
         48lYVWauWM0mr3YZTZn7rzAK+6pv0ObxoAdYqOFfQjraVxpFE6Lg8loxKfokY2h64G7w
         8oCm1ItfZaVPvwLy8QfT9xV0gUudXmGUSN31o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltnYvwXNt85pQWYuu3Woofu2pXYpHtCxsiErjju1VKA=;
        b=CPfQTJoGwvJhBmVwYl8rpi0AvEdBkyjfU2SHAwM7DKpzEyNrPWevYWHXoHjOvVhitW
         Cb6WVk1dseNrDaG2uUwaErJqslfA3KqG7PYRo1YfWEgujLiDoDeI9wF9GtH7UaG2XphL
         z6w4Uvp2OIU15mOPrrVnojPoGlN8MeHkHLm1TneHlRng8VP52fJYjLQDWIHwaqY+UwfY
         uLqoYqfo6BtOR4ej44e/wOacoRnLuc65vED0TtGPTghTL5SdHoZDgwqA1XWNE4tEWKyO
         75/ajaG+n7KQFzzACmcqM2RxHyAbV4W6YJP8DxqfrC8aemF/0HLUvQqhTCWVlCnNbY0J
         j2Yw==
X-Gm-Message-State: APjAAAXtiVb/Eeu8kcHrq89Aa+DZe826VgFBJvMsIl6RBroPyjPLbDJy
        oYSG0by5h/81E//XVQXLx8KxFA==
X-Google-Smtp-Source: APXvYqzbeVQOO1H7u1MKLY3LMRh/FsOUkMLI8e9zPqbWR51nVUSncMQqE+hLYnWR4pTrqKchpQ9r7w==
X-Received: by 2002:a17:90a:30e8:: with SMTP id h95mr7353865pjb.44.1567423316484;
        Mon, 02 Sep 2019 04:21:56 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id k5sm21422793pfg.167.2019.09.02.04.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:21:55 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v6 3/5] fork: support VMAP_STACK with KASAN_VMALLOC
Date:   Mon,  2 Sep 2019 21:20:26 +1000
Message-Id: <20190902112028.23773-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902112028.23773-1-dja@axtens.net>
References: <20190902112028.23773-1-dja@axtens.net>
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


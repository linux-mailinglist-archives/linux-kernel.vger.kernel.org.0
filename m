Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E2A4703
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 05:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfIADzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 23:55:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46583 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfIADzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 23:55:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so5502465pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 20:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rM4/B5ti8MD5RWMkbfuov3t3TeAxvKUOwZsakQ31f/8=;
        b=GvbCWRi9bOpKxv2irCLvNtD3I+yrw0CRmQ4TtBQ56jkDMI20EhR/J03mc0cOfxMvYc
         O6slHWDdlrr3z2KZw7eG39++Dg/a0zbTpaxyZkofVcQzkvTIIvDVS0Pb5vFhyv49HNm6
         wEW2iJ2JDewdl7kR/j4iCa9V17iiVka4mtiOpQV5zS0CW2cBVADJ8Y3Vq8dXh83baKHR
         +pj/uR6kAKWNF94Je5JrWzQjHLbzI6YiVec0AuPvw3vvJc67DKVZwiYbxPAlps7nEvHG
         buNj/niT6Kb86D4HzwRnvrg7BHLKPrL+0HIPzqE+DRYSv9uV96utaP6Dz97o2+tgmrpR
         RfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rM4/B5ti8MD5RWMkbfuov3t3TeAxvKUOwZsakQ31f/8=;
        b=NrT2xcHsmKgwuuEiP+EVnRbAKg2zKlE50lrQSzo8FqoWAW1l471g3/UvetHwNJF7w0
         8CqOp+ZwORrjU4ZsFsGt6FqeZyK3GXm39GdcpYivc6AZU6ixWAi8pwSZIS84ILMfyiam
         9BHJkB8RpH2UOjWvShrIpKYt9dtURvH/FIEFo/U/ENTM5Ru2NDPwMA3RwJSHg/xoOvh/
         o3XX2NSpDZkH1J0c2mhVekKeqgkmtfvIXC83R3C6srnmyP8f8iENPTMEOXi7ET+beUII
         oaF/nc70Ciuse4z1sNg6wRrl6nHvHUcgVtoHbM7Hl68yWF6H1IG0Zvm134zs7kXDfaWB
         Ygew==
X-Gm-Message-State: APjAAAX9E8dO8s55/GSIQkol8fj99m4c9rTIKaJXT116xVVcFv8B46FH
        UI5OPv9OVvWtwjVGSfs+imU=
X-Google-Smtp-Source: APXvYqzg6PQVRQDwMAi/jtxI2KEEei5TgYAFXyWnF/TwlafkRnFvUtA6huTHRkxdJTo+F62RBeJxMw==
X-Received: by 2002:a17:90a:86c3:: with SMTP id y3mr5213630pjv.66.1567310148403;
        Sat, 31 Aug 2019 20:55:48 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id q33sm5988120pgb.79.2019.08.31.20.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 20:55:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] genirq: move debugfs option to kernel hacking
Date:   Sun,  1 Sep 2019 11:55:39 +0800
Message-Id: <20190901035539.2957-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like the other generic debug options, move the irq one to
'Kernel hacking' menu.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/irq/Kconfig | 12 ------------
 lib/Kconfig.debug  | 11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index f92d9a687372..4684c44e0390 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -123,18 +123,6 @@ config SPARSE_IRQ
 	    out the interrupt descriptors in a more NUMA-friendly way. )
 
 	  If you don't know what to do here, say N.
-
-config GENERIC_IRQ_DEBUGFS
-	bool "Expose irq internals in debugfs"
-	depends on DEBUG_FS
-	default n
-	---help---
-
-	  Exposes internal state information through debugfs. Mostly for
-	  developers and debugging of hard to diagnose interrupt problems.
-
-	  If you don't know what to do here, say N.
-
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..c2fb63b4263b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2142,6 +2142,17 @@ config IO_STRICT_DEVMEM
 
 	  If in doubt, say Y.
 
+config GENERIC_IRQ_DEBUGFS
+	bool "Expose irq internals to userspace via debugfs"
+	depends on DEBUG_FS
+	default n
+	---help---
+
+	  Exposes internal state information through debugfs. Mostly for
+	  developers and debugging of hard to diagnose interrupt problems.
+
+	  If you don't know what to do here, say N.
+
 source "arch/$(SRCARCH)/Kconfig.debug"
 
 endmenu # Kernel hacking
-- 
2.20.1


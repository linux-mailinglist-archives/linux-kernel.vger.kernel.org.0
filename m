Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED53E17D2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 12:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404274AbfJWKZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 06:25:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34563 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404042AbfJWKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:25:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id v3so5989152wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Az7GdSb+e6TdjHcHdIa3JCr0/3rrdnc/fgd5bd/3iww=;
        b=fI+o7jbYb3n+SZzHk/tq/7rzJV5liOoXtUp9W6GyQ26jncKxp1OonqYSGlf0yweLmt
         5aSk5KYE2mMm22/k7ecPb1ffZZ4ERARz3Saps9aFBKvQnJyKxgFmWVdmbdFEA0A8rxKd
         mk0QTMMsJnSgtUot7gDwK7xnHyrGR58tShsW5zlC+3jjkt7DmbNK1kQemkDH029g/Axj
         q9SOqdofyZcKgZAGCMmFSmSpB4yN6CMtT2UytG2xZpzB42fVAhSmLpYIecR+vvUwVqAy
         O5O3RG3xLi9E4ar9qulZ/nHOsmp5VOyDXRFI6HwCQDDq/YEghCeJV+L95g+SWG0+szl5
         SIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Az7GdSb+e6TdjHcHdIa3JCr0/3rrdnc/fgd5bd/3iww=;
        b=TpYIfNEm1zv9ZKzYcPvQBo5aqr+qi9j5aAbRmKAx/dTu3pwSlyjhE3Mojg5P9n60P/
         FjLmPXRggaEAz5canI/7PGE0UdvrakebxvH8PW4FHEvmPtNxF+w1V6++pOPPehDcO5J5
         0JNH3gBz1TILBrEXRlYKlmOn6uPMqfRVoE7Ss9I6xE4PZo/6CvAa13vuOl8QJJigj/x9
         EomywUrfBZYwR4Ef7QNZmpHAsbdeE/0ZkgJt+hciTtKpmIb7wy12lgNqJAbCFV05xpU+
         pGFwqrD11y3H/HtJi1/h1iP9u5ba4B3rbDKFTZ9gPQm7oJ2se98b5H+zT1Woe13Y+6qJ
         lZAQ==
X-Gm-Message-State: APjAAAUtydxYrFwUx0dIr9RsM4GjFUe0C9QUG0eciHP7HWCJlyh8DquQ
        tzeyd1/MxfyWPGXI/OtnS1RdHQ==
X-Google-Smtp-Source: APXvYqxVLWttQAwlsY3dG0DxuB8fZT0ysWMSuHeOsGPJ2uJL8m4ti8uBNdeioogb40RlvJR/K0Igqw==
X-Received: by 2002:a1c:1901:: with SMTP id 1mr7112162wmz.28.1571826356170;
        Wed, 23 Oct 2019 03:25:56 -0700 (PDT)
Received: from salem.gmr.ssr.upm.es (salem.gmr.ssr.upm.es. [138.4.36.7])
        by smtp.gmail.com with ESMTPSA id v20sm17424441wml.26.2019.10.23.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:25:55 -0700 (PDT)
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Michal Simek <monstr@monstr.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [PATCH v2] microblaze: add support for reserved memory defined by device tree
Date:   Wed, 23 Oct 2019 12:25:48 +0200
Message-Id: <20191023102548.15164-1-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows reserving regions of physical memory from the device tree.
See Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
for more details.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---
 arch/microblaze/mm/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index a015a951c8b7..b69362fbfdbd 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/export.h>
+#include <linux/of_fdt.h>
 
 #include <asm/page.h>
 #include <asm/mmu_context.h>
@@ -188,6 +189,9 @@ void __init setup_memory(void)
 
 void __init mem_init(void)
 {
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+
 	high_memory = (void *)__va(memory_start + lowmem_size - 1);
 
 	/* this will put all memory onto the freelists */
-- 
2.23.0


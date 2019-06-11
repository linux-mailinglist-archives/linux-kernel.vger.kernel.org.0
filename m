Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8853C3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 07:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403928AbfFKFu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 01:50:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40585 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403878AbfFKFux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:50:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so1380423wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=voAjz+VVGHYrojERg9drctVbrKhGApZsPWQIGZxxUR8=;
        b=QT/b+tOYBTC8Knk6JZUD7V6taByi75hY2htN6Dv7kfW8hEjB6QwKo7depSMP2rf5F6
         KltM1x2aEnX3uLydL4yak9JESjkB/jdK0qXNmRcHYjiYTtUOM9O3KBphm0EpDdUe8Nlx
         vSKYQYeZrz2Q4rK23FtzyVKtJgWLXp4RxlFeLxO6fRzXJ7XVuo/2PDJSEds6D0YsoHJZ
         rHQ87jPQgsMuYAYTMNqDYTyhl5SJpFUXhSkhQlhw5TYOMI6GJCSLQ7gPdJAQt16VOwfU
         a6u1sWb8GmgJPU28tP+7CmFuBa3PWPJ2T4VEJCUqkEffjdr853XsjrBYvgCJXilvVPf8
         dOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=voAjz+VVGHYrojERg9drctVbrKhGApZsPWQIGZxxUR8=;
        b=suf7Iyua/lib3cxPyjybG16EZYH9+JcWv2Pbu0K8nr9YbEdh0Pr0QRx30qWJL11Dl8
         wwdvyFLSyoZH8jxltOWaqfbdxzoOOmLr3QZa6QBT7Ke4xIyOjlQKqPpNjuslyFINWKFn
         dcpAk31bYvWCE5A3s8vd6e/NTvFai8G0frm9bkId/Edv8eURgNxsQ9A2P/N0qQhuyrfv
         n+Xp23rQ8M8P/XfYMOUnZMaNCPqObAiwTZKT5fGPa2GO1zzafyShANtF9bCr0GqAJ2Ec
         99pZZyq8JG//gGdmBwzPJd8K01lxYvoAG7+oNYkOxaOuoPBz3p/Cyh+PQrArCjELVi+4
         HrMQ==
X-Gm-Message-State: APjAAAV8s+MUrZCz5ZYus8f9CO8oYeAOzgGGQSZ/vvEC7v4NAzRk6Kj+
        OxXlYiIz8gsav+rZ1kiEpz9j2pjNe34=
X-Google-Smtp-Source: APXvYqzv3kvwrZH8uZquP054+VVxQrgw47bg1pSCJol/WXD8lwfLsussjhH862lGp5UTl7OSxY4YbQ==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr16086279wml.28.1560232251664;
        Mon, 10 Jun 2019 22:50:51 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:51 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/8] habanalabs: initialize MMU context for driver
Date:   Tue, 11 Jun 2019 08:50:40 +0300
Message-Id: <20190611055045.15945-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611055045.15945-1-oded.gabbay@gmail.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch initializes the MMU structures for the kernel context. This is
needed before we can configure mappings for the kernel context.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/context.c |  7 +++++++
 drivers/misc/habanalabs/mmu.c     | 10 ++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 280f4625e313..8682590e3f6e 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -36,6 +36,8 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
+	} else {
+		hl_mmu_ctx_fini(ctx);
 	}
 }
 
@@ -119,6 +121,11 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 
 	if (is_kernel_ctx) {
 		ctx->asid = HL_KERNEL_ASID_ID; /* KMD gets ASID 0 */
+		rc = hl_mmu_ctx_init(ctx);
+		if (rc) {
+			dev_err(hdev->dev, "Failed to init mmu ctx module\n");
+			goto mem_ctx_err;
+		}
 	} else {
 		ctx->asid = hl_asid_alloc(hdev);
 		if (!ctx->asid) {
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 87968f32e718..a80162c5c373 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -241,8 +241,9 @@ static int dram_default_mapping_init(struct hl_ctx *ctx)
 		hop2_pte_addr, hop3_pte_addr, pte_val;
 	int rc, i, j, hop3_allocated = 0;
 
-	if (!hdev->dram_supports_virtual_memory ||
-			!hdev->dram_default_page_mapping)
+	if ((!hdev->dram_supports_virtual_memory) ||
+			(!hdev->dram_default_page_mapping) ||
+			(ctx->asid == HL_KERNEL_ASID_ID))
 		return 0;
 
 	num_of_hop3 = prop->dram_size_for_default_page_mapping;
@@ -340,8 +341,9 @@ static void dram_default_mapping_fini(struct hl_ctx *ctx)
 		hop2_pte_addr, hop3_pte_addr;
 	int i, j;
 
-	if (!hdev->dram_supports_virtual_memory ||
-			!hdev->dram_default_page_mapping)
+	if ((!hdev->dram_supports_virtual_memory) ||
+			(!hdev->dram_default_page_mapping) ||
+			(ctx->asid == HL_KERNEL_ASID_ID))
 		return;
 
 	num_of_hop3 = prop->dram_size_for_default_page_mapping;
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6310C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEARou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 13:44:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45526 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfEARor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:44:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so25352609wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qMEs7vX+3X1edDsF2kNj23oAEMILKrj5zcafU4xXV/Q=;
        b=b8abEcoeaxNh+06jvWHuf4qjo12XFR7UH7BiV5HtAsIIjtlwl+hLFDATXfQCC+sN/x
         3nI51OwFEwhpaISHnO/VUnqEzwCzbTp5AF+74tTotajhXqqsZiB8bxM6ooDx+bxCEG/2
         Gva8rj3P5MZ5/PDWFguzYTShKNRqwt+I1xAkxmMsHefG610kaMJPMbAaoNNxIB5HP2o+
         2yz65aoJzhK63p1AnhucjFyQY4X3CXPVq/p15vuBAO6ES5nKHz0PBIHAZGI0kQ0IuPrc
         uTF9YXxSQIc2sJbUaRBVbuGLrc/wCVzalj2ABLWHRtCvkvE/EOuVeDIvjjNMCTUMAYID
         uvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qMEs7vX+3X1edDsF2kNj23oAEMILKrj5zcafU4xXV/Q=;
        b=g20bmYJcCsLRAO8tQSFarcpaGMJ6EtSL4lLdL7eG5oXry94a36GmEI9icLhjiI+BpJ
         +dbshjzyTyiCYgStwKzijSl54jaip0cQ9MlK37ahIQ8iEyTwpgHOSPkWylRK7rHcjoax
         Nd0v3ljImKEFIp91HudxOldItcS6BvHe9ocr8y6551+3vJ0RAXVIDhxUR+HQEt/VXGQq
         vYEfhxP5M99lNaWZsKP4WxwTb/hh63M1fEpLXZ7zSvZ/CzxWibiEsbSH4zBKbSYBz6cI
         p/yM9lqUbL97EVxe5sOdpB+zSXALBOTgvF7eWM6htijGZ6udTjem6802DSHSZEnHr8/H
         y8OQ==
X-Gm-Message-State: APjAAAViG4OD1r+dVvAO4L2eAGY4MtUFlcmOvlHSMuMgnj2xur+E2nwO
        z6T7C7dTmkCHm5xjJMl9wNzzX10u
X-Google-Smtp-Source: APXvYqyxETir/voH7mLPv2pRC+G1Y20oEMRyGqzMOzQXWe0R6Qz/O3G14bIX2xOrypmCgElb4zfYQg==
X-Received: by 2002:adf:b3d4:: with SMTP id x20mr53148173wrd.284.1556732685610;
        Wed, 01 May 2019 10:44:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h81sm9923329wmf.33.2019.05.01.10.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 10:44:45 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH 2/3] habanalabs: remove condition that is always true
Date:   Wed,  1 May 2019 20:44:39 +0300
Message-Id: <20190501174440.28557-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501174440.28557-1-oded.gabbay@gmail.com>
References: <20190501174440.28557-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalit Ben Zoor <dbenzoor@habana.ai>

After removing the parsing of the command submission
when doing memset of the device memory, goya_validate_dma_pkt_host
is never called by the kernel, so there is no need to check
context id.

Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 48 ++++++++++++++---------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ba6790f9ec6b..9bf572a2d292 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3213,31 +3213,29 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 		return -EFAULT;
 	}
 
-	if (parser->ctx_id != HL_KERNEL_ASID_ID) {
-		if (sram_addr) {
-			if (!hl_mem_area_inside_range(device_memory_addr,
-					le32_to_cpu(user_dma_pkt->tsize),
-					hdev->asic_prop.sram_user_base_address,
-					hdev->asic_prop.sram_end_address)) {
-
-				dev_err(hdev->dev,
-					"SRAM address 0x%llx + 0x%x is invalid\n",
-					device_memory_addr,
-					user_dma_pkt->tsize);
-				return -EFAULT;
-			}
-		} else {
-			if (!hl_mem_area_inside_range(device_memory_addr,
-					le32_to_cpu(user_dma_pkt->tsize),
-					hdev->asic_prop.dram_user_base_address,
-					hdev->asic_prop.dram_end_address)) {
-
-				dev_err(hdev->dev,
-					"DRAM address 0x%llx + 0x%x is invalid\n",
-					device_memory_addr,
-					user_dma_pkt->tsize);
-				return -EFAULT;
-			}
+	if (sram_addr) {
+		if (!hl_mem_area_inside_range(device_memory_addr,
+				le32_to_cpu(user_dma_pkt->tsize),
+				hdev->asic_prop.sram_user_base_address,
+				hdev->asic_prop.sram_end_address)) {
+
+			dev_err(hdev->dev,
+				"SRAM address 0x%llx + 0x%x is invalid\n",
+				device_memory_addr,
+				user_dma_pkt->tsize);
+			return -EFAULT;
+		}
+	} else {
+		if (!hl_mem_area_inside_range(device_memory_addr,
+				le32_to_cpu(user_dma_pkt->tsize),
+				hdev->asic_prop.dram_user_base_address,
+				hdev->asic_prop.dram_end_address)) {
+
+			dev_err(hdev->dev,
+				"DRAM address 0x%llx + 0x%x is invalid\n",
+				device_memory_addr,
+				user_dma_pkt->tsize);
+			return -EFAULT;
 		}
 	}
 
-- 
2.17.1


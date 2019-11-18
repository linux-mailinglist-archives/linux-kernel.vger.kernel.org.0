Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2231FFC70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 01:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfKRAVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 19:21:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44656 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfKRAVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:21:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id c19so12968002otr.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 16:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbZqwoJJVr0J94wPHgvVootKI8CLiTOgXk788wPqdIo=;
        b=ChA355kCEvy9kl1kcHhtWO1zZ9ZX+fpBIL2yVyOretNk1sfdTC2t9K/H6DdOaGB+s6
         iMJg1z4bePap3GqZpujJqXwkr1ll/ExGZUnr9o1XSg6ieQ1FdlwyVUGJms8tUWlcY35e
         kBsdPPQRiUlUpE3qlIkapnMeTqwhDNrsQgmlR386wJVQb7L5inZ7RFtIaTs4UQJdv2Oa
         dB7uhHVHnhKXNNkuXkTJ5fWuCsI9WqijOKhrml9/v/9ntHU23u/vLQ8zBzQ56lRu+tgQ
         wto2gvlsChHdMcHeIHWErLYwGs1K9PZg9JFBklzB9BwDTMB2njgeSRe4C/SByL+j4D9a
         MLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbZqwoJJVr0J94wPHgvVootKI8CLiTOgXk788wPqdIo=;
        b=UkbiwufQP+aKHB/YmrCWqoqIYT7YRKtCnugFsCExLk7wzbU1fR0WHiHnrdFmrVT8zy
         oMtEGGod+z98ZH8PjK1H8Z2+wC6Z4OEpjSKz9Ob238Y2meNUxmDoBvpUCyI8X2x/OFfS
         f0Xo1ix1N5qkom/D/VzIArMGlNVrWh3z1EwngUWJBmwdpuNL9ja58CvPhskZugHpxYMg
         mqskxj9WtcVjr6cez8Cw+ibz1DYNeCutxZCM/wXc+Zh5V/0ZnT/V1/LVyeGptJI6osWc
         nCG76CuWml1ZTxms85WQdov/XwwgorBN6v7TNPBGBfTV1kyAV3mR8gSnPhmYjeE9ZbDq
         Ub6Q==
X-Gm-Message-State: APjAAAUpxluxIk93pmet/Zovl7s+yOy0Xfb6Hdar2AbNufIfUGwXYcUV
        1SYMZhI9VkPngxWQq4emxcMHtQ==
X-Google-Smtp-Source: APXvYqxZuMW9sovrGVzyCi2WLjA0B35LlvQyFg5z3vXpEGiLeRhQajZklEwi52XVu7bu/bQ0UnPMSw==
X-Received: by 2002:a05:6830:4c5:: with SMTP id s5mr20648889otd.140.1574036465676;
        Sun, 17 Nov 2019 16:21:05 -0800 (PST)
Received: from com.attlocal.net ([2600:1700:4870:71e0::10])
        by smtp.gmail.com with ESMTPSA id 65sm5532194oie.50.2019.11.17.16.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 16:21:04 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        bvanassche@acm.org
Subject: [PATCH v2 1/4] skd: Prefer pcie_capability_read_word()
Date:   Sun, 17 Nov 2019 18:20:54 -0600
Message-Id: <20191118002057.9596-2-fred@fredlawl.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118002057.9596-1-fred@fredlawl.com>
References: <20191118002057.9596-1-fred@fredlawl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/block/skd_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 51569c199a6c..f25f6ef6b4c7 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3134,18 +3134,14 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
 
 static char *skd_pci_info(struct skd_device *skdev, char *str)
 {
-	int pcie_reg;
-
 	strcpy(str, "PCIe (");
-	pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
 
-	if (pcie_reg) {
+	if (pci_is_pcie(skdev->pdev)) {
 
 		char lwstr[6];
 		uint16_t pcie_lstat, lspeed, lwidth;
 
-		pcie_reg += 0x12;
-		pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);
+		pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);
 		lspeed = pcie_lstat & (0xF);
 		lwidth = (pcie_lstat & 0x3F0) >> 4;
 
-- 
2.20.1


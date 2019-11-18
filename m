Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E37FFC76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 01:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKRAVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 19:21:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33290 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfKRAVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 19:21:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id m193so13737093oig.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 16:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wINNGpwv7rfFjkOocRZinKoRo1EENB9vc5x4WXjd+NU=;
        b=Md6Zu6Hf26Pi97+YT3Y3YaEfxiXS2RlDrYentpQ1YYF++gN0B8+XJlQyLBEdSEJ8k2
         /lVUs4hHhTDSkgDSs1rfBp4aZEFo3Zs6jaiYMiLr/sgi7M0BA/kJOr2LcJQupVboUiMC
         P4yF51yrAW6rqzgDi+VNCrb7evSOuE937VJ3pFefub48AFyW03t6EK2cvibRwOdCKWbz
         eBfh5jPuCF0p25+TFDypI/uJshS6jOyExtu15XqcWtHmaZs0OX9XnuU9Nkkv6FAWAeBR
         0HNok0nFKouqVG8NQL80KDpqt5d/HkS4Fpi0B7WNgtCklDdyCD7vxDUrXeqzH8ylYlbq
         uJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wINNGpwv7rfFjkOocRZinKoRo1EENB9vc5x4WXjd+NU=;
        b=nmTfgG9wWaWVYtqUaNgIIL6A7UtoAQ8KMYY5+VEt1ba40IsP96H2MIJbQj7W6ip0pP
         ww+0vO+t5yjivCXSSVvZp7IBCPKCVt4TxVIbEZjBesNO/ClmACBhe26GUz/P8glMsyRj
         bydYHI7U5lvoPSMgnf9D0Z+HO/RQmmAbj7kPnMwnW1i7UmiYNBMRHnwKVHqcnXdbfEPt
         3fBwUdJgGvjAKDUsu99Qasfh+yd5xZjEs0HgWCbj79/sTXcn5F8MrXgv6nMwofYmYL/9
         VbE+eYyBLLHanT+iVNOBykLYjO34EUE3qagcNHVtkWd8KHl0DulA7WsNCvrLCHoxwgzs
         0M5Q==
X-Gm-Message-State: APjAAAWKmvsQTR7o9j6OVgNP5A+L5PV7VvX3JWewizj9s5tp8ByjAqod
        mu722eyd9zjo++fC80CWy4TDag==
X-Google-Smtp-Source: APXvYqz1qPqJq5C0BfZ+47CDZnFM48RNuI0KKG/3cQjhSRx0HCmWRg6V368wYAWKApLJyfaEDHiV9w==
X-Received: by 2002:aca:ddc2:: with SMTP id u185mr18492063oig.174.1574036474399;
        Sun, 17 Nov 2019 16:21:14 -0800 (PST)
Received: from com.attlocal.net ([2600:1700:4870:71e0::10])
        by smtp.gmail.com with ESMTPSA id 65sm5532194oie.50.2019.11.17.16.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 16:21:13 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        bvanassche@acm.org
Subject: [PATCH v2 3/4] mtip32xx: Prefer pcie_capability_read_word()
Date:   Sun, 17 Nov 2019 18:20:56 -0600
Message-Id: <20191118002057.9596-4-fred@fredlawl.com>
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
 drivers/block/mtip32xx/mtip32xx.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 964f78cfffa0..35703dc98e25 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3938,22 +3938,18 @@ static void mtip_disable_link_opts(struct driver_data *dd, struct pci_dev *pdev)
 	int pos;
 	unsigned short pcie_dev_ctrl;
 
-	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
-	if (pos) {
-		pci_read_config_word(pdev,
-			pos + PCI_EXP_DEVCTL,
-			&pcie_dev_ctrl);
-		if (pcie_dev_ctrl & (1 << 11) ||
-		    pcie_dev_ctrl & (1 << 4)) {
-			dev_info(&dd->pdev->dev,
-				"Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
-					pdev->vendor, pdev->device);
-			pcie_dev_ctrl &= ~(PCI_EXP_DEVCTL_NOSNOOP_EN |
-						PCI_EXP_DEVCTL_RELAX_EN);
-			pci_write_config_word(pdev,
-				pos + PCI_EXP_DEVCTL,
-				pcie_dev_ctrl);
-		}
+	if (!pci_is_pcie(pdev))
+		return;
+
+	pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &pcie_dev_ctrl);
+	if (pcie_dev_ctrl & (1 << 11) ||
+	    pcie_dev_ctrl & (1 << 4)) {
+		dev_info(&dd->pdev->dev,
+			 "Disabling ERO/No-Snoop on bridge device %04x:%04x\n",
+			 pdev->vendor, pdev->device);
+		pcie_dev_ctrl &= ~(PCI_EXP_DEVCTL_NOSNOOP_EN |
+					PCI_EXP_DEVCTL_RELAX_EN);
+		pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, pcie_dev_ctrl);
 	}
 }
 
-- 
2.20.1


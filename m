Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91750199E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgCaSiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 14:38:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39158 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgCaSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:38:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so12426467lfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ef53u72gwX154C7xAMYz+wCT3OMfVTWwHYstmLaCNlc=;
        b=cW0Tj1W36bWIKjTQK8D9mJ/96C2vkHPZEcGEzeHzqpZy67M9jPUIyXRV5YA1X2DaHZ
         Nzpvr5UpM29BGo6lks/pgSsnJES6sPStXAo9uafNp0/NlfHr3bJpYjCISQ8jc5IydKuv
         iHi7rqNqMiHP+rAsoHJW6SVRpUMNK/RhN1BJmik/agnq4A1zJm38xhfmtxsDxu/c/PYf
         KNl0mzd8Klq3O9ErQheYvhlwcsAQ4RCIuLEvbAx+wakyHiycLj6pt8B00BtM7cBGB0Ac
         wuqLoq169V2kl68TDfQyIlc5tkHPXYmP1QNVQrAI2ij9lp2xx6LLurbGqM9Jaes8Dvlv
         3IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ef53u72gwX154C7xAMYz+wCT3OMfVTWwHYstmLaCNlc=;
        b=rFEISobXhJUGSmbZnXA39y6HzQvMtIe3RyxyyG2HufxGSKrpktjoMTaapJKRG36Hg3
         Wz5mE1Q+SjI8DtD2yzjI4/w8ak+WPf1z7K9ZfkCF3MJl2JBjBdXvRSsiF57vJ2TwQeIq
         UOiYHm02R0As1UF3qc6gnn4e8FlxUzj1tAmZFBWFsS16vwf5A/Zr2IgsnbWx04UfQabv
         Y9vktAo4jzbhE2aI8922QkrXYZQBgPCmjZzsTrGaztZZSuW2dDMJXkDM+faxR1LkOVcC
         b80ju576OIhuVl9nBAhT8hvwNvX1gmgyb6gQxfum7AiLBNm224nxXy9ntFG0/tPeZ9tM
         GFpw==
X-Gm-Message-State: AGi0PuZegtmSGq4yEtsBw9PeO4NVXVf0Qms22jTiXZms7S9lCg0ODb/m
        +RIxxApQWl6eiSrwLRMnTpZwGw==
X-Google-Smtp-Source: APiQypJlHBdy85VzPZtpSqUGdPox7hK2Nb2Ow9qHdh0GVGjkZIEzlPooZMXhxhreWPUR3bq6fB+QZA==
X-Received: by 2002:a19:c507:: with SMTP id w7mr11146673lfe.131.1585679930697;
        Tue, 31 Mar 2020 11:38:50 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b28sm10331849ljp.90.2020.03.31.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:38:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] driver core: platform: Initialize dma_parms for platform devices
Date:   Tue, 31 Mar 2020 20:38:43 +0200
Message-Id: <20200331183844.30488-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331183844.30488-1-ulf.hansson@linaro.org>
References: <20200331183844.30488-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's currently the platform driver's responsibility to initialize the
pointer, dma_parms, for its corresponding struct device. The benefit with
this approach allows us to avoid the initialization and to not waste memory
for the struct device_dma_parameters, as this can be decided on a case by
case basis.

However, it has turned out that this approach is not very practical.  Not
only does it lead to open coding, but also to real errors. In principle
callers of dma_set_max_seg_size() doesn't check the error code, but just
assumes it succeeds.

For these reasons, let's do the initialization from the common platform bus
at the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

---

Changes in v2:
	- Move initialization to setup_pdev_dma_masks(). This means the
	initialization is done also in the OF path.

---
 drivers/base/platform.c         | 2 ++
 include/linux/platform_device.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b5ce7b085795..c81b68d5d66d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -361,6 +361,8 @@ struct platform_object {
  */
 static void setup_pdev_dma_masks(struct platform_device *pdev)
 {
+	pdev->dev.dma_parms = &pdev->dma_parms;
+
 	if (!pdev->dev.coherent_dma_mask)
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	if (!pdev->dev.dma_mask) {
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 041bfa412aa0..81900b3cbe37 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	bool		id_auto;
 	struct device	dev;
 	u64		platform_dma_mask;
+	struct device_dma_parameters dma_parms;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.20.1


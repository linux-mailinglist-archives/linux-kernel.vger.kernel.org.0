Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4734A4E00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 05:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfIBD6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 23:58:37 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:43585 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729262AbfIBD6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:58:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0CC4A44A;
        Sun,  1 Sep 2019 23:58:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 01 Sep 2019 23:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=6HpwFSX23/R6f
        qQ1Vmx0lv614ze3IiqChsWjpEUZsHk=; b=nMCFMKow35QSDhSi44FBntAkPCA8R
        hpr7mWF9BVlaK6uFQ+S1uhXImb1U+G+v3mccDCBLJuO9F5+e3ZJ6t9BbnT0Rzwlt
        a86bMHprPe+3qBZUZuZkH3jW2eAezjVbe0GDmKFwYLEFXDMm6Lztc4jyf2k39UBu
        zIkDJOKpud+rtQF7rMFGmOmYf7p5iVNm+VZnXRoROKBkrljzJ28ZXygnYib75kec
        mg+AtHsrd/BDjyzscQHq3iEjVsO/ZSbQ3p1hzZ0vqST2srjvFhDDMTotxzSzNo49
        EVh4siLSD+PUNnGKX74XHGNPafgwznWrIEoT83VD1sBmSEEfBJSI2o8YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=6HpwFSX23/R6fqQ1Vmx0lv614ze3IiqChsWjpEUZsHk=; b=Fd6KmWft
        1gg/nvdFoYNWtvYbUu6e5NNroZYZra5us7LqGeTZEAXIqtbuGzGofL2YgjGyJI2B
        bieEE12Zak5D6qZotkQP7IccvSJYmv9JqOy/Vz83hRmozVFiVv9AohbAMLBvRBU7
        fl8TuzLUCVbDC8Jd+NmLF+TRzhtmXaiE40H/9E+B9GQ0zmV9tMN6xKF6w1KMfqxB
        Zr1GZ1DOJx5r7hayRkfb5LV+hEoeXgA9Odrm0ySgqdOvNUeJzDc0/DZtG0u2mJZu
        fFKzVu5+oiQbz2wPLN8qyus1b6VN+3kM5vwh8S3r9HvhFCdSL+guMpScvFOMazLu
        Oo7eqbim2SwDNw==
X-ME-Sender: <xms:apNsXRINKU-hEJclL32ZGTQSIqUyAjksgqsINnv_ZaXC8gja6RauSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppedvtdefrdehjedrvdduhedrudejkeenucfrrghrrghmpe
    hmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:apNsXbqnNQg6UzznnOk2pKWxlMuuYqhqpWaPwfxavJ96zx7KQWNTRw>
    <xmx:apNsXQALeJMlZV3rwIJa5oHS3kVYvJLkJODDUKv81P4VhshN0ge2PQ>
    <xmx:apNsXY_qfw1QNrR2EAmrkCNKnzljNwHDJhkhOU0U3FdlJpEXT-a8sw>
    <xmx:apNsXXVYgpwm-tSXWW2Au-acbA2_x9x3X034qNeQLcghAbpdImqeog>
Received: from localhost.localdomain (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46C91D6005B;
        Sun,  1 Sep 2019 23:58:31 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, joel@jms.id.au, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2 1/4] mmc: sdhci-of-aspeed: Fix link failure for SPARC
Date:   Mon,  2 Sep 2019 13:28:39 +0930
Message-Id: <20190902035842.2747-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902035842.2747-1-andrew@aj.id.au>
References: <20190902035842.2747-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolves the following build error reported by the 0-day bot:

    ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!

SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Guard the
callsite to maintain build coverage for the rest of the driver.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 38 ++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index d5acb5afc50f..96ca494752c5 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -224,10 +224,30 @@ static struct platform_driver aspeed_sdhci_driver = {
 	.remove		= aspeed_sdhci_remove,
 };
 
-static int aspeed_sdc_probe(struct platform_device *pdev)
-
+static int aspeed_sdc_create_sdhcis(struct platform_device *pdev)
 {
+#if defined(CONFIG_OF_ADDRESS)
 	struct device_node *parent, *child;
+
+	parent = pdev->dev.of_node;
+
+	for_each_available_child_of_node(parent, child) {
+		struct platform_device *cpdev;
+
+		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
+		if (!cpdev) {
+			of_node_put(child);
+			return -ENODEV;
+		}
+	}
+#endif
+
+	return 0;
+}
+
+static int aspeed_sdc_probe(struct platform_device *pdev)
+
+{
 	struct aspeed_sdc *sdc;
 	int ret;
 
@@ -256,17 +276,9 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, sdc);
 
-	parent = pdev->dev.of_node;
-	for_each_available_child_of_node(parent, child) {
-		struct platform_device *cpdev;
-
-		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
-		if (!cpdev) {
-			of_node_put(child);
-			ret = -ENODEV;
-			goto err_clk;
-		}
-	}
+	ret = aspeed_sdc_create_sdhcis(pdev);
+	if (ret)
+		goto err_clk;
 
 	return 0;
 
-- 
2.20.1


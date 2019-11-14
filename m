Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C1FC6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 13:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKNMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 07:55:02 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:33640 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbfKNMy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:54:59 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id CA19F42E7D;
        Thu, 14 Nov 2019 12:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1573736096; x=1575550497; bh=dU4Qiqla3HKSYHl+Wvu4W3/EUd/15lXXOMG
        hZ+0TFuQ=; b=TYwELifC+V6L9QXxu43Q+9Yb+OUpSBpe54G2+CyEmgWgETwHWzf
        UXlGzzAs6uUbCl1/40s4dDmR9VX+FHGxDmXYAyB5NNIY7SPhQo+wKgKDg2BPfkmh
        lco3HU0GxT55/NUNuIZ3pCfXX49Dtz1HS9colU5+EsxcDCT1WZ2As1rQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QNR538L5M_zS; Thu, 14 Nov 2019 15:54:56 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id CE144411D9;
        Thu, 14 Nov 2019 15:54:56 +0300 (MSK)
Received: from localhost.dev.yadro.com (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 14 Nov 2019 15:54:54 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v2 2/2] mmc: sdhci-of-aspeed: add inversion signal presence
Date:   Thu, 14 Nov 2019 15:54:35 +0300
Message-ID: <20191114125435.27756-3-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114125435.27756-1-i.mikhaylov@yadro.com>
References: <20191114125435.27756-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.69]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the default .get_cd callback. Add inverted signal card detection
check.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 8962f6664381..186559ee8fcc 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -143,6 +143,19 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 	return (delta / 0x100) - 1;
 }
 
+static int aspeed_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	int present = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
+			 & SDHCI_CARD_PRESENT);
+
+	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
+		present = !present;
+
+	return present;
+}
+
 static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -183,6 +196,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	host->mmc_host_ops.get_cd = aspeed_get_cd;
+	if (of_property_read_bool(pdev->dev.of_node, "cd-inverted"))
+		dev_info(&pdev->dev, "aspeed: sdhci: presence signal inversion enabled\n");
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err_sdhci_add;
-- 
2.20.1


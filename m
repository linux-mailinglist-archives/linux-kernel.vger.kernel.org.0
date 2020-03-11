Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1D181CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgCKPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:44:48 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6057 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgCKPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:44:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e6907600000>; Wed, 11 Mar 2020 08:44:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Mar 2020 08:44:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Mar 2020 08:44:45 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Mar
 2020 15:44:45 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Mar 2020 15:44:45 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.232]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e69076c0012>; Wed, 11 Mar 2020 08:44:45 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <skomatineni@nvidia.com>
CC:     <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 2/2] sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
Date:   Wed, 11 Mar 2020 08:47:55 -0700
Message-ID: <1583941675-9884-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583941675-9884-1-git-send-email-skomatineni@nvidia.com>
References: <1583941675-9884-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583941472; bh=WQbMCJ65f2TyXJ8ZQ5LpK0swY2bTxKhl2kWonRDVGlg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=hkTby4UTOPzILHAEceijMzbErmsugOXxjJC5qw2ukJwZYQUd20PtJhyz+5MnMGYF6
         9e+W1QbQEKtV48GQAG6jprUnbh6mqYZkDBTxejnaCPHuVtKHYBJVResGq+IutvNpMm
         gotjtBTep3zDq8p/bzMFkBnNpmEjEE8Ev3amB4VBFe+VuFsCari5tjEfrU1JRhUO3y
         KvrCWZaaqvaScgkOzwiBnZd5GM9LP0Z39lw4IIUjaPs4t9yjJlGS2GyOrkI/atiFln
         q2/AkvHV5euF7d69m+lHpcIIiG6nuJCRiVRMAmQAbkrR2nEPmGsucbi65F9dbnShVB
         L5Ia7XqIB6+nA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra sdhci host supports HW busy detection of the device busy
signaling over data0 lane.

So, this patch enables host capability MMC_CAP_wAIT_WHILE_BUSY.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index fa8f6a4..1c381f8 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1580,6 +1580,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_parse_dt;
 
+	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
-- 
2.7.4


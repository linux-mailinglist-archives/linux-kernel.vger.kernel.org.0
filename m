Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9410E19737
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 05:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfEJDmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 23:42:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34660 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfEJDmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:42:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4A3gGAh098185;
        Thu, 9 May 2019 22:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557459736;
        bh=xGnnEs0VvLOau4salih9c7vlIkVrfDHhDl/ZUbqJ1Ik=;
        h=From:To:CC:Subject:Date;
        b=Q+DS1IZurs3128n2ebd/ure8y2h17FJzRdbq9nR7MWaL16bd/CbSm7IqThX5+ifBB
         tPaqPt5dLtudcfT+XgstohSePRBwruydIH9WjfFhN+S3OI4x4StjSWws5dnWSg74aZ
         PBiKW2nZ7j132t2GG0mDgmBwmnOdMNz1JwzBYU2w=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4A3gGJx129485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 May 2019 22:42:16 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 9 May
 2019 22:42:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 9 May 2019 22:42:16 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4A3gD2o002845;
        Thu, 9 May 2019 22:42:14 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2 0/3] Fix issues with phy configurations in am65x MMC driver
Date:   Fri, 10 May 2019 09:12:25 +0530
Message-ID: <20190510034228.32211-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches fix issues with phy configurations for
sdhci_am654 driver.

v2:
1. Split patch 1 into 2 separate patches.
2. Improved patch descriptions.

Faiz Abbas (3):
  mmc: sdhci_am654: Improve line wrapping with regmap_*() calls
  mmc: sdhci_am654: Print error message if the DLL fails to lock
  mmc: sdhci_am654: Fix SLOTTYPE write

 drivers/mmc/host/sdhci_am654.c | 37 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

-- 
2.19.2


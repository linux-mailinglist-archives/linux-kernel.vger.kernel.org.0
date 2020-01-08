Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E9C1345BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgAHPHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:07:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43344 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgAHPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:07:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008F7ofC014550;
        Wed, 8 Jan 2020 09:07:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578496070;
        bh=nABr0rOy2x3lVMXTWU5UFQKT88ibNI0DZI1k0DXXm1g=;
        h=From:To:CC:Subject:Date;
        b=DwgBmErTNRTBxZ1yQAz126k7JknMk2vOe8t4wMKOcKueQQLrYFch3xVJwmrPHjMh9
         FbsVBXr+nHW1lSVHNzEJ2my24avSboZ6Anqv87e1jiCdKA5bGDWKb2++vpyfYU+Ot9
         YzyMIIWVbd7po7puPDlMPmoxtGvbeiSk6SyMbxR4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008F7oWA105408;
        Wed, 8 Jan 2020 09:07:50 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 09:07:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 09:07:50 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008F7ln0018107;
        Wed, 8 Jan 2020 09:07:48 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>, <robh+dt@kernel.org>
Subject: [PATCH 0/3] Update phy configuration for AM65x
Date:   Wed, 8 Jan 2020 20:39:17 +0530
Message-ID: <20200108150920.14547-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches update phy configurations for AM65x as given in
the latest data manual.

The patches depend on my fixes series posted just before this:
https://patchwork.kernel.org/project/linux-mmc/list/?series=225425

Device tree patch updating the actual otap values will be posted
separately.

Tested with Am65x-evm and J721e-evm.

Faiz Abbas (3):
  dt-bindings: mmc: sdhci-am654: Update Output tap delay binding
  mmc: sdhci_am654: Update OTAPDLY writes
  mmc: sdhci_am654: Enable DLL only for some speed modes

 .../devicetree/bindings/mmc/sdhci-am654.txt   |  21 +-
 drivers/mmc/host/sdhci_am654.c                | 247 ++++++++++++------
 include/linux/mmc/host.h                      |   2 +
 3 files changed, 192 insertions(+), 78 deletions(-)

-- 
2.19.2


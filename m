Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E237D0534
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 03:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfJIB2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 21:28:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:11066 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfJIB2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:28:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 18:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="206769647"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2019 18:28:20 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        michal.simek@xilinx.com, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 0/2] mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC
Date:   Wed,  9 Oct 2019 09:28:16 +0800
Message-Id: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current arasan sdhci PHY configuration isn't compatible
with the PHY on Intel's LGM(Lightning Mountain) SoC devices.

Therefore, add a new compatible, to adapt the Intel's LGM
SDXC PHY with arasan-sdhc controller to configure the PHY.

Linux code base : V5.4-rc1 

Ramuthevar Vadivel Murugan (2):
  dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM
    SDXC
  mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC

changes from v1: 
 -  commit message updated 
 -  Acked-by tag added

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c                     | 15 +++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.11.0


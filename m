Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7589DC31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 05:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfH0D6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 23:58:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:41483 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbfH0D6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:58:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 20:58:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="197212700"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2019 20:58:42 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        jwboyer@gmail.com, boris.brezillon@free-electrons.com,
        cyrille.pitchen@atmel.com, david.oberhollenzer@sigma-star.at,
        miquel.raynal@bootlin.com, tudor.ambarus@gmail.com,
        vigneshr@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 0/3] dt-bindings: mtd: cadence-qspi:add support for Intel lgm-qspi
Date:   Tue, 27 Aug 2019 11:58:24 +0800
Message-Id: <20190827035827.21024-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtd: spi-nor: cadence-quadspi: disable DMA and DAC for Intel LGM
mtd: spi-nor: cadence-quadspi: disable the auto-poll for Intel LGM

changes from V1:
  - many thanks to Vignesh for review comments.
  - split 2 patches one for DMA and DAC and other one
    is disable the auto-poll
  - removed ahb_phy_addr and used existing trigger_address
  - trigger_address property used.
  
Ramuthevar Vadivel Murugan (3):
  dt-bindings: mtd: cadence-qspi:add support for Intel lgm-qspi
  mtd: spi-nor: cadence-quadspi: disable DMA and DAC for Intel LGM
  mtd: spi-nor: cadence-quadspi: disable the auto-poll for Intel LGM

 .../devicetree/bindings/mtd/cadence-quadspi.txt    |  1 +
 drivers/mtd/spi-nor/Kconfig                        |  2 +-
 drivers/mtd/spi-nor/cadence-quadspi.c              | 45 ++++++++++++++++++++--
 3 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.11.0


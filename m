Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4FDA641
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 09:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408083AbfJQHUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 03:20:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:10404 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408044AbfJQHUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:20:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 00:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,306,1566889200"; 
   d="scan'208";a="200304826"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 17 Oct 2019 00:20:04 -0700
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
Subject: [PATCH v4 0/2] mtd: spi-nor: cadence-quadspi: Disable the DAC and Autopoll for Intel LGM SoC
Date:   Thu, 17 Oct 2019 15:19:58 +0800
Message-Id: <20191017072000.48860-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Lightning Mountain SoCs QSPI controller do not use auto-poll
and Direct Access Controller (DAC).

Thanks vignesh for your time to review the patch.
The following comments are addressed..
changes from v3:
- commit messages are updated in both the patches
- moved cqspi_disable_auto_poll() in cqspi_controller_init()
- moved the check <if (ddata && (ddata->quirks & CQSPI_DISABLE_DAC_MODE))> in cqspi_setup_flash()
- introduced cqspi->auto_poll variable instead of f_pdata->use_direct_mode for auto_poll patch 
  
Ramuthevar Vadivel Murugan (2):
  mtd: spi-nor: cadence-quadspi: Disable the DAC for Intel LGM SoC
  - This patch adds a quirk to disable the Direct Access Controller
    for data transfer instead it uses indirect data transfer.    	

  mtd: spi-nor: cadence-quadspi: Disable the auto-poll for Intel LGM SoC
  - This patch disables auto polling when direct access mode is disabled

 drivers/mtd/spi-nor/Kconfig           |  2 +-
 drivers/mtd/spi-nor/cadence-quadspi.c | 55 +++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 7 deletions(-)

-- 
2.11.0


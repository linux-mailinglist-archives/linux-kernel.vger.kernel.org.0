Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5CDE8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfJUJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 05:54:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:27943 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfJUJyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:54:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 02:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209409910"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2019 02:54:38 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com
Subject: [PATCH v6 0/2] phy: intel,lgm-emmc-phy: Add support for eMMC PHY on Intel LGM SoC
Date:   Mon, 21 Oct 2019 17:54:34 +0800
Message-Id: <20191021095436.50303-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Rebased to kernel verson 5.4 

dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
changes in v6:
   - cobined comaptible strings
   - added as contiguous and can be a single entry for reg properties
changes in v5:
   - earlier Review-by tag given by Rob
   - rework done with syscon parent node.

 changes in v4:
   - As per Rob's review: validate 5.2 and 5.3
   - drop unrelated items.

 changes in v3:
   - resolve 'make dt_binding_check' warnings

 changes in v2:
   As per Rob Herring review comments, the following updates
  - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
  - filename is the compatible string plus .yaml
  - LGM: Lightning Mountain
  - update maintainer
  - add intel,syscon under property list
  - keep one example instead of two

phy: intel-lgm-emmc: Add support for eMMC PHY
  No changes from  patchV5 
 
Ramuthevar Vadivel Murugan (2):
  dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
	
  phy: intel-lgm-emmc: Add support for eMMC PHY

 .../bindings/phy/intel,lgm-emmc-phy.yaml           |  63 +++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/intel/Kconfig                          |   9 +
 drivers/phy/intel/Makefile                         |   2 +
 drivers/phy/intel/phy-intel-emmc.c                 | 283 +++++++++++++++++++++
 6 files changed, 359 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
 create mode 100644 drivers/phy/intel/Kconfig
 create mode 100644 drivers/phy/intel/Makefile
 create mode 100644 drivers/phy/intel/phy-intel-emmc.c

-- 
2.11.0


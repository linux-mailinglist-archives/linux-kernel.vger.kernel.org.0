Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F358811FD43
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 04:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLPDso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 22:48:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:56942 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfLPDso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:48:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2019 19:48:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,320,1571727600"; 
   d="scan'208";a="226982184"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 15 Dec 2019 19:48:40 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, peter.harliman.liem@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v9 0/2]  phy: intel-lgm-emmc: Add support for eMMC PHY
Date:   Mon, 16 Dec 2019 11:48:36 +0800
Message-Id: <20191216034838.21875-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eMMC-PHY support for Intel LGM SoC

changes in v9:
  - Rob's review comments update in YAML
  
changes in v8:
 Remove the extra Signed-of-by

changes in v7:
 Rebased to maintainer kernel tree phy-tag-5.5

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

Ramuthevar Vadivel Murugan (2):
  dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
  phy: intel-lgm-emmc: Add support for eMMC PHY

 .../bindings/phy/intel,lgm-emmc-phy.yaml           |  58 +++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/intel/Kconfig                          |   9 +
 drivers/phy/intel/Makefile                         |   2 +
 drivers/phy/intel/phy-intel-emmc.c                 | 283 +++++++++++++++++++++
 6 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
 create mode 100644 drivers/phy/intel/Kconfig
 create mode 100644 drivers/phy/intel/Makefile
 create mode 100644 drivers/phy/intel/phy-intel-emmc.c

-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8019238C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 10:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCYJAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 05:00:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:13375 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCYJAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:00:04 -0400
IronPort-SDR: E2i2dbPB4nj0WdSQJQPLrxUFHANp+hS07T2hxAhvigdsNPeDA17p56S5fC78i4ItaIF9trf7j7
 JlHanCUsxgnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 02:00:02 -0700
IronPort-SDR: IDp46QtdmQGBfhvKf7SS6K61QbWQK5OSU2HJQ4MKlmLUvQjY5E9KUOAeBQBtLq8gXdQwYcOI5s
 P51eJpGWtQBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="293290484"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2020 02:00:00 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v5 0/4] Add Intel ComboPhy driver
Date:   Wed, 25 Mar 2020 16:59:36 +0800
Message-Id: <cover.1585103753.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds Intel ComboPhy driver, respective yaml schemas
and a kernel API fwnode_to_regmap().
ComboPhy driver calls it to get regmap handle through firmware node.

Dilip Kota (4):
  mfd: syscon: Add fwnode_to_regmap
  dt-bindings: phy: Add PHY_TYPE_XPCS definition
  dt-bindings: phy: Add YAML schemas for Intel ComboPhy
  phy: intel: Add driver support for ComboPhy

 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 ++++
 drivers/mfd/syscon.c                               |   8 +
 drivers/phy/intel/Kconfig                          |  14 +
 drivers/phy/intel/Makefile                         |   1 +
 drivers/phy/intel/phy-intel-combo.c                | 626 +++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |   1 +
 include/linux/mfd/syscon.h                         |   6 +
 7 files changed, 757 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
 create mode 100644 drivers/phy/intel/phy-intel-combo.c

-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 202D618693A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 11:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgCPKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 06:37:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:26973 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbgCPKhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:37:47 -0400
IronPort-SDR: UDXvqxzMYB9NxNXWpvn2DKcZho46AVjHu6oaeTgTqmnUR10AKQtvRHpn/6A7AYeHRpfxAO/31y
 4ejUP5b89vYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 03:37:46 -0700
IronPort-SDR: +yOYCpQQmAvMHWv5T76iAjArCJkMt3v+Ysd1H3lDGIxbjJtH7agzPOV0ZaHsTNar5jZ9kKJ5aW
 V3/C8uFaf3dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="267522683"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2020 03:37:44 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 0/2] phy: intel: Add Keem Bay eMMC PHY support
Date:   Mon, 16 Mar 2020 18:37:24 +0800
Message-Id: <20200316103726.16339-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The first part is to document DT bindings for Keem Bay eMMC PHY.

The second is the driver file, loosely based on phy-rockchip-emmc.c
and phy-intel-emmc.c. The latter is not being reused as there are
quite a number of differences i.e. registers offset, supported clock
rates, bitfield to set.

The patch was tested with Keem Bay evaluation module board.

Thank you.

Best regards,
Zainie


Wan Ahmad Zainie (2):
  dt-bindings: phy: intel: Add documentation for Keem Bay eMMC PHY
  phy: intel: Add Keem Bay eMMC PHY support

 .../bindings/phy/intel,keembay-emmc-phy.yaml  |  57 +++++
 drivers/phy/intel/Kconfig                     |   7 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-keembay-emmc.c          | 231 ++++++++++++++++++
 4 files changed, 296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
 create mode 100644 drivers/phy/intel/phy-keembay-emmc.c

-- 
2.17.1


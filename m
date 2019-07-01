Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8CD38469
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfFGGg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 02:36:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:52439 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbfFGGg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:36:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 23:36:27 -0700
X-ExtLoop1: 1
Received: from pg-eswbuild-angstrom-alpha.altera.com ([10.142.34.148])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2019 23:36:25 -0700
From:   "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, hean.loong.ong@intel.com,
        chin.liang.see@intel.com, Ong@vger.kernel.org
Subject: [PATCHv16 2/3] ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite
Date:   Fri,  7 Jun 2019 22:30:21 +0800
Message-Id: <20190607143022.427-3-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143022.427-1-hean.loong.ong@intel.com>
References: <20190607143022.427-1-hean.loong.ong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong Hean Loong <hean.loong.ong@intel.com>

Intel FPGA Video and Image Processing Suite Frame Buffer II
driver config for Arria 10 devkit and its variants

Signed-off-by: Ong, Hean Loong <hean.loong.ong@intel.com>
---
 arch/arm/configs/socfpga_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 371fca4e1ab7..4727a96a16da 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -112,6 +112,14 @@ CONFIG_MFD_ALTERA_A10SR=y
 CONFIG_MFD_STMPE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_DRM=m
+CONFIG_DRM_IVIP=m
+CONFIG_DRM_IVIP_OF=m
+CONFIG_FB=y
+CONFIG_FB_SIMPLE=y
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_USB=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC2=y
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA76AD8CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392050AbfJPJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:44:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:61115 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfJPJoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:44:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 02:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="186100964"
Received: from unknown (HELO ubuntu.localdomain) ([10.226.249.160])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2019 02:44:11 -0700
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Ong Hean Loong <hean.loong.ong@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>
Subject: [PATCHv2] arm64: dts: altera: update QSPI reg addresses for Stratix10
Date:   Wed, 16 Oct 2019 02:44:07 -0700
Message-Id: <1571219047-12437-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the reg addresses for QSPI boot and QSPI rootfs in
the device tree for Stratix10

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
v2: update the qspi_rootfs partition size
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 66e4ffb..3704a17 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -178,12 +178,12 @@
 
 			qspi_boot: partition@0 {
 				label = "Boot and fpga data";
-				reg = <0x0 0x4000000>;
+				reg = <0x0 0x034B0000>;
 			};
 
-			qspi_rootfs: partition@4000000 {
+			qspi_rootfs: partition@34B0000 {
 				label = "Root Filesystem - JFFS2";
-				reg = <0x4000000 0x4000000>;
+				reg = <0x034B0000 0x0CB50000>;
 			};
 		};
 	};
-- 
1.9.1


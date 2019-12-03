Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFB10FD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 13:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLCM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 07:29:11 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41006 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLCM3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:29:09 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ECC0B1A1319;
        Tue,  3 Dec 2019 13:29:07 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F65B1A1308;
        Tue,  3 Dec 2019 13:29:03 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 16A16402F0;
        Tue,  3 Dec 2019 20:28:56 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, ran.wang_1@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [v5 2/3] arm: dts: ls1021a: fix that FlexTimer cannot wakeup system in deep sleep
Date:   Tue,  3 Dec 2019 20:28:17 +0800
Message-Id: <20191203122818.21941-2-biwen.li@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203122818.21941-1-biwen.li@nxp.com>
References: <20191203122818.21941-1-biwen.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes a bug that FlexTimer cannot
wakeup system in deep sleep.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v5:
	- none

Change in v4:
	- update property name
	  fsl,ippdexpcr-alt-addr -> fsl,ippdexpcr1-alt-addr

Change in v3:
  	- update property name
	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr
  	  
Change in v2:
  	- none

 arch/arm/boot/dts/ls1021a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 816e2926c448..6659d83c3aa2 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -988,6 +988,12 @@
 			compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x8>;
 			#fsl,rcpm-wakeup-cells = <2>;
+
+			/*
+			 * The second and third entry compose an alt offset
+			 * address for IPPDEXPCR1(SCFG_SPARECR8)
+			 */
+			fsl,ippdexpcr1-alt-addr = <&scfg 0x0 0x51c>;
 		};
 
 		ftm_alarm0: timer0@29d0000 {
-- 
2.17.1


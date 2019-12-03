Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC7A10FDA1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 13:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLCM3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 07:29:13 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42532 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfLCM3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:29:11 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F166200376;
        Tue,  3 Dec 2019 13:29:09 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 20643200367;
        Tue,  3 Dec 2019 13:29:05 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B4AF9402F3;
        Tue,  3 Dec 2019 20:28:58 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     leoyang.li@nxp.com, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, ran.wang_1@nxp.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [v5 3/3] Documentation: dt: binding: fsl: Add 'fsl,ippdexpcr1-alt-addr' property
Date:   Tue,  3 Dec 2019 20:28:18 +0800
Message-Id: <20191203122818.21941-3-biwen.li@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203122818.21941-1-biwen.li@nxp.com>
References: <20191203122818.21941-1-biwen.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'fsl,ippdexpcr1-alt-addr' property is used to handle an errata A-008646
on LS1021A

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v5:
	- none

Change in v4:
	- rename property name
	  fsl,ippdexpcr-alt-addr -> fsl,ippdexpcr1-alt-addr

Change in v3:
  	- rename property name
	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr

Change in v2:
  	- update desc of the property
	  'fsl,rcpm-scfg'

 .../devicetree/bindings/soc/fsl/rcpm.txt      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
index 5a33619d881d..751a7655b694 100644
--- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -34,6 +34,13 @@ Chassis Version		Example Chips
 Optional properties:
  - little-endian : RCPM register block is Little Endian. Without it RCPM
    will be Big Endian (default case).
+ - fsl,ippdexpcr1-alt-addr : The property is related to a hardware issue
+   on SoC LS1021A and only needed on SoC LS1021A.
+   Must include 1 + 2 entries.
+   The first entry must be a link to the SCFG device node.
+   The non-first entry must be offset of registers of SCFG.
+   The second and third entry compose an alt offset address
+   for IPPDEXPCR1(SCFG_SPARECR8)
 
 Example:
 The RCPM node for T4240:
@@ -43,6 +50,20 @@ The RCPM node for T4240:
 		#fsl,rcpm-wakeup-cells = <2>;
 	};
 
+The RCPM node for LS1021A:
+	rcpm: rcpm@1ee2140 {
+		compatible = "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
+		reg = <0x0 0x1ee2140 0x0 0x8>;
+		#fsl,rcpm-wakeup-cells = <2>;
+
+		/*
+		 * The second and third entry compose an alt offset
+		 * address for IPPDEXPCR1(SCFG_SPARECR8)
+		 */
+		fsl,ippdexpcr1-alt-addr = <&scfg 0x0 0x51c>;
+	};
+
+
 * Freescale RCPM Wakeup Source Device Tree Bindings
 -------------------------------------------
 Required fsl,rcpm-wakeup property should be added to a device node if the device
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920A2197A87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgC3LRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 07:17:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59390 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbgC3LRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:17:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 198621A04AB;
        Mon, 30 Mar 2020 13:17:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AD3161A04A6;
        Mon, 30 Mar 2020 13:17:05 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 49786402B1;
        Mon, 30 Mar 2020 19:17:00 +0800 (SGT)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] arm: dts: ls1021atwr: Add QSPI node properties
Date:   Mon, 30 Mar 2020 16:46:31 +0530
Message-Id: <1585566991-24049-2-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585566991-24049-1-git-send-email-kuldeep.singh@nxp.com>
References: <1585566991-24049-1-git-send-email-kuldeep.singh@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1021A-TWR has one micron "n25q128a13" flash of size 16M.
Add QSPI node properties for it.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index 9b1fe99..5edf001 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -242,6 +242,20 @@
         status = "okay";
 };
 
+&qspi {
+	status = "okay";
+
+	n25q128a130: flash@0 {
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
+
 &sai1 {
 	status = "okay";
 };
-- 
2.7.4


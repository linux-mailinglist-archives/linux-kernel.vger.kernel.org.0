Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D742176F90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 07:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCCGjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 01:39:07 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55114 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgCCGjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:39:07 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FE231A13D4;
        Tue,  3 Mar 2020 07:39:06 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B5F21A13EA;
        Tue,  3 Mar 2020 07:39:02 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D0C6E40370;
        Tue,  3 Mar 2020 14:38:40 +0800 (SGT)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 1/2] arm64: dts: lx2160ardb: Update FSPI node properties
Date:   Tue,  3 Mar 2020 12:08:31 +0530
Message-Id: <1583217512-27994-1-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update fspi node compatibles of LX2160A-RDB to "jedec,spi-nor" for
automatic detection of flash.

This also helps in fixing below warning:
spi-nor spi0.0: found mt35xu512aba, expected m25p80
spi-nor spi0.1: found mt35xu512aba, expected m25p80

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 51615de..22d0308 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -84,7 +84,7 @@
 	mt35xu512aba0: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,m25p80";
+		compatible = "jedec,spi-nor";
 		m25p,fast-read;
 		spi-max-frequency = <50000000>;
 		reg = <0>;
@@ -95,7 +95,7 @@
 	mt35xu512aba1: flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "spansion,m25p80";
+		compatible = "jedec,spi-nor";
 		m25p,fast-read;
 		spi-max-frequency = <50000000>;
 		reg = <1>;
-- 
2.7.4


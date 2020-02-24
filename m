Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6009916B4D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 00:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBXXIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 18:08:31 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44882 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgBXXIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:31 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE9C81B0791;
        Tue, 25 Feb 2020 00:08:29 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B5D011A4BBB;
        Tue, 25 Feb 2020 00:08:29 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 09CBA40A63;
        Mon, 24 Feb 2020 16:08:29 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 00/15] Enable drivers for NXP/FSL QorIQ arm64 boards
Date:   Mon, 24 Feb 2020 17:07:55 -0600
Message-Id: <1582585690-463-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series enables necessary drivers for the QorIQ reference boards
supported in mainline.

Li Yang (15):
  arm64: defconfig: run through savedefconfig for ordering
  arm64: defconfig: Enable NXP flexcan driver
  arm64: defconfig: Enable QorIQ DPAA1 drivers
  arm64: defconfig: Enable QorIQ DPAA2 drivers
  arm64: defconfig: Enable ENETC Ethernet controller and FELIX switch
  arm64: defconfig: Enable NXP/FSL SPI controller drivers
  arm64: defconfig: Enable QorIQ cpufreq driver
  arm64: defconfig: Enable ARM SBSA watchdog driver
  arm64: defconfig: Enable QorIQ IFC NAND controller driver
  arm64: defconfig: Enable QorIQ GPIO driver
  arm64: defconfig: Enable ARM Mali display driver
  arm64: defconfig: Enable flash device drivers for QorIQ boards
  arm64: defconfig: Enable RTC devices for QorIQ boards
  arm64: defconfig: Enable PHY devices used on QorIQ boards
  arm64: defconfig: Enable e1000 device

 arch/arm64/configs/defconfig | 57 +++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

-- 
2.17.1


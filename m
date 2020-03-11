Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E5182548
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 23:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgCKWyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 18:54:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37636 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbgCKWyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:54:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E1961A0CAD;
        Wed, 11 Mar 2020 23:54:07 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 467261A0C9A;
        Wed, 11 Mar 2020 23:54:07 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 8310A40A5F;
        Wed, 11 Mar 2020 15:54:06 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 00/15] Enable drivers for NXP/FSL QorIQ arm64 boards
Date:   Wed, 11 Mar 2020 17:53:02 -0500
Message-Id: <20200311225317.11198-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


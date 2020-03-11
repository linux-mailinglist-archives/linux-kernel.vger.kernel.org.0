Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C43E418253E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 23:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgCKWya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 18:54:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42856 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731381AbgCKWyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:54:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F233200BED;
        Wed, 11 Mar 2020 23:54:10 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCD9F200BEE;
        Wed, 11 Mar 2020 23:54:09 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 5BE8440A5F;
        Wed, 11 Mar 2020 15:54:09 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 11/15] arm64: defconfig: Enable ARM Mali display driver
Date:   Wed, 11 Mar 2020 17:53:13 -0500
Message-Id: <20200311225317.11198-12-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20200311225317.11198-1-leoyang.li@nxp.com>
References: <20200311225317.11198-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the Mali display driver for the display port on NXP LS1028a SoC.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7da63af7c9a1..557d2cefba6d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -548,6 +548,7 @@ CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_DRM=m
 CONFIG_DRM_I2C_NXP_TDA998X=m
+CONFIG_DRM_MALI_DISPLAY=m
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_EXYNOS=m
 CONFIG_DRM_EXYNOS5433_DECON=y
-- 
2.17.1


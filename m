Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AACE10E6A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 09:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfLBIEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 03:04:42 -0500
Received: from inva020.nxp.com ([92.121.34.13]:48460 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBIEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:04:42 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 032011A0E29;
        Mon,  2 Dec 2019 09:04:40 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EB5C01A068D;
        Mon,  2 Dec 2019 09:04:39 +0100 (CET)
Received: from fsr-ub1864-103.ro-buh02.nxp.com (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 331B1203C6;
        Mon,  2 Dec 2019 09:04:39 +0100 (CET)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux@rempel-privat.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.olaru@nxp.com, shengjiu.wang@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] firmware: imx: Allow IMX DSP to be selected as module
Date:   Mon,  2 Dec 2019 10:04:32 +0200
Message-Id: <20191202080432.12579-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX DSP is only needed by SOF or any other module that
wants to communicate with the DSP. When SOF is build
as a module IMX DSP is forced to be built inside the
kernel image. This is not optimal, so allow IMX DSP
to be built as a module.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 0dbee32da4c6..1d2e5b85d7ca 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IMX_DSP
-	bool "IMX DSP Protocol driver"
+	tristate "IMX DSP Protocol driver"
 	depends on IMX_MBOX
 	help
 	  This enables DSP IPC protocol between host AP (Linux)
-- 
2.17.1


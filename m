Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E63ACE6B59
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 04:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfJ1DQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 23:16:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40248 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbfJ1DQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:16:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D7681A0C3F;
        Mon, 28 Oct 2019 04:16:16 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C11881A06B7;
        Mon, 28 Oct 2019 04:16:11 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5A03940310;
        Mon, 28 Oct 2019 11:16:05 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 8/9] ARM: imx: Add serial number support for i.MX6SX
Date:   Mon, 28 Oct 2019 11:12:49 +0800
Message-Id: <1572232370-31580-9-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572232370-31580-1-git-send-email-Anson.Huang@nxp.com>
References: <1572232370-31580-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX has a 64-bit SoC unique ID stored in OCOTP, it can be used
as SoC serial number, see below example:

root@imx6qpdlsolox:~# cat /sys/devices/soc0/serial_number
986540983AE87921

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index eb65eff..17cfa86 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -136,6 +136,7 @@ struct device * __init imx_soc_device_init(void)
 		soc_id = "i.MX6DL";
 		break;
 	case MXC_CPU_IMX6SX:
+		ocotp_compat = "fsl,imx6sx-ocotp";
 		soc_id = "i.MX6SX";
 		break;
 	case MXC_CPU_IMX6Q:
-- 
2.7.4


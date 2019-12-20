Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79CC1276A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 08:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLTHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 02:40:39 -0500
Received: from inva021.nxp.com ([92.121.34.21]:39184 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfLTHkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:40:39 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCAEA2000A8;
        Fri, 20 Dec 2019 08:40:37 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A0A3C201225;
        Fri, 20 Dec 2019 08:40:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A8114031B;
        Fri, 20 Dec 2019 15:40:24 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, fugang.duan@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 0/2] irqchip: add NXP INTMUX interrupt controller
Date:   Fri, 20 Dec 2019 15:37:09 +0800
Message-Id: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

   Thanks for your kindly reminder:-), I understood a little more. After
adding the .select callback, we can assign an interrupt to one of irq
domains from interrupt specifier. Thanks a lot.

ChangeLogs:
V2->V3:
	*impletement .xlate and .select callback.

V1->V2:
	*squash patches:
		drivers/irqchip: enable INTMUX interrupt controller driver
 		drivers/irqchip: add NXP INTMUX interrupt multiplexer support
	*remove properity "fsl,intmux_chans", only support channel 0 by
	default.
	*delete two unused macros.
	*align the various field in struct intmux_data.
	*turn to spin lock _irqsave version.
	*delete struct intmux_irqchip_data.
	*disable interrupt in probe stage and clear pending status in remove
	stage.

Joakim Zhang (2):
  dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
  drivers/irqchip: add NXP INTMUX interrupt multiplexer support

 .../interrupt-controller/fsl,intmux.txt       |  36 ++
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-imx-intmux.c              | 311 ++++++++++++++++++
 4 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
 create mode 100644 drivers/irqchip/irq-imx-intmux.c

-- 
2.17.1


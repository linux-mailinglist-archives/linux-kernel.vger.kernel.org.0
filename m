Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2578F13D518
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgAPHh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 02:37:29 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60414 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgAPHh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:37:29 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 84649200668;
        Thu, 16 Jan 2020 08:37:27 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 73C4B200659;
        Thu, 16 Jan 2020 08:37:27 +0100 (CET)
Received: from fsr-ub1864-014.ea.freescale.net (fsr-ub1864-014.ea.freescale.net [10.171.95.219])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C4D792047A;
        Thu, 16 Jan 2020 08:37:26 +0100 (CET)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] clk: imx8mn: add snvs clock
Date:   Thu, 16 Jan 2020 09:37:15 +0200
Message-Id: <20200116073718.4475-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: add commmit message for trivial patch 1/3

This patch set adds the clock for snvs module on imx8mn.
DT bindings, clk driver are updated accordingly.
DT for imx8mn (snvs-rtc-lp node) is also updated.

Horia Geantă (3):
  dt-bindings: clock: imx8mn: add SNVS clock
  clk: imx8mn: add SNVS clock to clock tree
  arm64: dts: imx8mn: add clock for snvs rtc node

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 +
 drivers/clk/imx/clk-imx8mn.c              | 1 +
 include/dt-bindings/clock/imx8mn-clock.h  | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1


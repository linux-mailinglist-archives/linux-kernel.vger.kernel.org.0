Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72A910905D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 15:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfKYOut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 09:50:49 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:39258 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbfKYOut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:50:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 0E0FEFB02;
        Mon, 25 Nov 2019 15:50:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jRIkPuWtdP79; Mon, 25 Nov 2019 15:50:43 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id CA0914928B; Mon, 25 Nov 2019 15:50:07 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: imx8mq: Add eLCDIF controller
Date:   Mon, 25 Nov 2019 15:50:05 +0100
Message-Id: <cover.1574693313.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some minimal support on imx8mq we might as well add it to the DT

Changes from v1:
- Per review comments by Fabio Estevam
  - Document compatible
  - use lcd-controller instead of lcdif as node name
- Add Reviewed-by: from Fabio Estevam, thanks!

Guido Günther (2):
  dt-bindings: mxsfb: Add compatible for iMX8MQ
  arm64: dts: imx8mq: Add eLCDIF controller

 .../devicetree/bindings/display/mxsfb.txt       |  1 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.23.0


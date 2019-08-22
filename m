Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B3B991AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbfHVLHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 07:07:23 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35576 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbfHVLHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:07:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6A36EFB03;
        Thu, 22 Aug 2019 13:07:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 20gLphEHrcFq; Thu, 22 Aug 2019 13:07:19 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1D3224014F; Thu, 22 Aug 2019 13:07:19 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] arch: arm64: imx8mq: Add mux-controller to iomuxc_gpr
Date:   Thu, 22 Aug 2019 13:07:18 +0200
Message-Id: <cover.1566471985.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a mux-controller to the iomuxc_gpr syscon. It will e.g. be used by
the NWL DSI host controller driver.

Guido Günther (1):
  arm64: dts: imx8mq: Add mux controller to iomuxc_gpr

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.20.1


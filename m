Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7C36F86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfFFJJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 05:09:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36776 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfFFJJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:09:43 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYoOv-0003Fk-Uv; Thu, 06 Jun 2019 11:09:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, papadakospan@gmail.com,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] clk: rockchip: add a type from SGRF-controlled gate clocks
Date:   Thu,  6 Jun 2019 11:09:33 +0200
Message-Id: <20190606090934.4443-1-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clk gates on Rockchip SoCs are part of the SGRF (secure general
register files) and thus only controllable from secure mode, with the
most prominent example being the watchdog.

In most cases we still want to define this as a real clock though,
to have complete clock tree and not reference the generic base-clock
from the devicetree.

So far we've just defined this as factor-1-1 clocks in the clock init,
so define a special clock-type for it so that this definition can be
part of the general tree-definition and save some boilerplate code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 1b5270755431..2a911923cf81 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -820,6 +820,10 @@ struct rockchip_clk_branch {
 		.gate_offset	= -1,				\
 	}
 
+/* SGRF clocks are only accessible from secure mode, so not controllable */
+#define SGRF_GATE(_id, cname, pname)				\
+		FACTOR(_id, cname, pname, 0, 1, 1)
+
 struct rockchip_clk_provider *rockchip_clk_init(struct device_node *np,
 			void __iomem *base, unsigned long nr_clks);
 void rockchip_clk_of_add_provider(struct device_node *np,
-- 
2.20.1


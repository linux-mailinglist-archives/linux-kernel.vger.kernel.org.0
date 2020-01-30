Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E101B14D6C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 07:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgA3Gw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 01:52:56 -0500
Received: from mx.socionext.com ([202.248.49.38]:26330 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgA3Gwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:52:55 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Jan 2020 15:52:54 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id DFD84603AB;
        Thu, 30 Jan 2020 15:52:54 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 30 Jan 2020 15:53:59 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 5E8FD1A01BB;
        Thu, 30 Jan 2020 15:52:54 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 3/7] phy: uniphier-usb3ss: Add Pro5 support
Date:   Thu, 30 Jan 2020 15:52:41 +0900
Message-Id: <1580367165-16760-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pro5 SoC has same scheme of USB3 ss-phy as Pro4, so the data for Pro5 is
equivalent to Pro4.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-usb3ss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/socionext/phy-uniphier-usb3ss.c b/drivers/phy/socionext/phy-uniphier-usb3ss.c
index 05e40a2..6700645 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3ss.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3ss.c
@@ -313,6 +313,10 @@ static const struct of_device_id uniphier_u3ssphy_match[] = {
 		.data = &uniphier_pro4_data,
 	},
 	{
+		.compatible = "socionext,uniphier-pro5-usb3-ssphy",
+		.data = &uniphier_pro4_data,
+	},
+	{
 		.compatible = "socionext,uniphier-pxs2-usb3-ssphy",
 		.data = &uniphier_pxs2_data,
 	},
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E377122608
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 08:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLQH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 02:59:18 -0500
Received: from se15e.web-hosting.com ([198.54.122.209]:59635 "EHLO
        se15e.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLQH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:59:17 -0500
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <akash@openedev.com>)
        id 1ih7l4-0002DN-R6; Mon, 16 Dec 2019 23:59:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=diOgM+1bEFTCStq0UeCQsuK8N2c5AS/suGJiaKd7qsU=; b=gBTyf2nP2LL9YXnxdGBwJQCDY
        rUG9U4ZtV2zu5fEnIaDyZSCWJewbmuOjZm+77bZxtWH0peTGJlsfIG7v46+eGsLUCk+303YmG8EFH
        YQb8VB/UDqcbETISz5g/TpY010Iu+GYMR0tp2fqZsztVIfcRRrGbwBO6FmbZ/D6X7Lq/H6MWhKbvL
        uBguk72zOaKAdMionpcrnd4qBYtUg7eRMYDA8dQ/1wMUmlEah0PxbjqbeLSll2W8PIGC3I2ysgzlK
        qBTMUSHNBak1pDeZFxHkP1lMm8xWldrGDgC6Qtze810vzVY9YhaRACBORzf7s7B9+8TIsC4bqjzI9
        U2icuvKtA==;
Received: from nat-inn.mentorg.com ([192.94.34.34]:44656 helo=akash-vm.inn-wifi.mentorg.com)
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <akash@openedev.com>)
        id 1ih7kz-003CWq-MW; Tue, 17 Dec 2019 02:59:06 -0500
From:   Akash Gajjar <akash@openedev.com>
To:     heiko@sntech.de
Cc:     jagan@openedev.com, tom@radxa.com, kever.yang@rock-chips.com,
        Akash Gajjar <akash@openedev.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 2/2] phy: phy-rockchip-inno-usb2: add usb2-phy support for RK3308 SoC
Date:   Tue, 17 Dec 2019 13:27:15 +0530
Message-Id: <20191217075722.11646-3-akash@openedev.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217075722.11646-1-akash@openedev.com>
References: <20191217075722.11646-1-akash@openedev.com>
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0c2Pj46HODYmpAMVAv0J1pOpSDasLI4SayDByyq9LIhV5dqwct359/CV
 xZICQFYJSkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3Kk502M/hntTzIKfCMISdhHQGg
 t7nAtP8WjkKKy9v/mXRkty7kshl0qfjNTiHz6D+lTs1OFZCJnqICuBP35KwNAmisedSHrV8USIJy
 ZKu4Q0eBPJf4fBJswECxJoMRbkC3SF2DuTVJlHUR2BtY80W8dG60QfvEMzMeJ6Rw9B2oZpcFefeT
 nKVTea+Z7pU/97kaMRINxtYvoDPmxBEirO18GFgbEtxGbfWvsckv3Tqu01KJGGjsNnBvKhksFPgp
 Ju7VRAUaZyvXYsGqun+gsnRrw40vpN++k/mRssszRiW/L+aVL5CXNSk/AzmiJysF8dLHRyryw85/
 rAZb27+VZ3biGtaW8qQvbDNe5IP3ZP124DrwHHYNWMFQ3rxmq0HUMfG+c6Hob6r/eV86ndcww4rw
 IzAvtpjiIeRlwI+LpEJwnKenvHgTJm4rUod0ueKDsCR8lJjuWToZaiaFIvhnz77Y+k6uhs/Q2KE1
 Lby4XA9T8Bmj3saNZ0eUp3kqVmG1d7Vk0NCCILyLLaQ9eQTOszvxQTkjHv8L1XCo8f/lClCdnQEw
 egH725V8o9NmtwsOgq00IT3zX/Zzh6cpDYUl6c6Y0/5r1yWIc3jXLVN/s8cHerYtW55yLfDen/wr
 oS11FXNac8XwfSk5a6wPi3PS+6vBhpISIqK1GdyQE0WyMBODOy30v1Op0AWqhD2stjbU32pojN4X
 8zAZfIZ8CjT9GInTMPN38Uyq3PQ8yDScr+8662B3D4UT/bdQYZMqtJwVgGaPV8GdcLPofFI165s+
 Fi8oQNCwxvxuh+xtfMocbqMn/Qow8uvbAccZ4WWjZTIX9MhLKTjECb0PwpN4olPuA0AI93gbcx8Z
 jKXXCSz+ofgapDj5Myrxgk8zlzkZR8hg4/tjCwvQy21RlJtzRtySOaj2KPqMwd2r4+trrKXkWu7f
 x8D6z8uZdl1/53Cf3G9hN76KRnxfIvD0xWRSasqqxNnWfwc3A8r6JfNzxEm+Adh5Il9bsJFhaqar
 dOLrAnCsmfJ3HSl/Lt1pDXWpU9yav05pkiyHpQ9cOADsvE/xCV8jXdQF5Hew752uew/O2uwTJhUB
 Z3+qi/5h4DZCfPGWm7MoPBOavov9A2tPRpxsJ/Ez2OT1H/aAwarQpYDOYx/6JtUOkfNK1xk8kTd1
 Ny+HuiOkN2mAdCO+RVfxIo7mcAZ9GMPEl9B+0hmmdOnbSMz7Y9ZIgfFrL3927nPLXidUYhzTL/6b
 zJY8ZLbVls9GTjTyP2j0DLjHCOlbYrvqvTn3lmAWHSgj8REt1LPAYpi/k8cuog==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds usb2-phy support for RK3308 SoCs and amend phy Documentation.

Signed-off-by: Akash Gajjar <akash@openedev.com>
---
 .../bindings/phy/phy-rockchip-inno-usb2.txt   |  1 +
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 44 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
index 541f5298827c..e978aad34d3f 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
@@ -5,6 +5,7 @@ Required properties (phy (parent) node):
 	* "rockchip,px30-usb2phy"
 	* "rockchip,rk3228-usb2phy"
 	* "rockchip,rk3328-usb2phy"
+	* "rockchip,rk3308-usb2phy"
 	* "rockchip,rk3366-usb2phy"
 	* "rockchip,rk3399-usb2phy"
 	* "rockchip,rv1108-usb2phy"
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 680cc0c8825c..9fe817486ea1 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1256,6 +1256,49 @@ static const struct rockchip_usb2phy_cfg rk3228_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3308_phy_cfgs[] = {
+	{
+		.reg = 0x100,
+		.num_ports	= 2,
+		.clkout_ctl	= { 0x0108, 4, 4, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0100, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x3020, 2, 2, 0, 1 },
+				.bvalid_det_st	= { 0x3024, 2, 2, 0, 1 },
+				.bvalid_det_clr = { 0x3028, 2, 2, 0, 1 },
+				.ls_det_en	= { 0x3020, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x3024, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x3028, 0, 0, 0, 1 },
+				.utmi_avalid	= { 0x0120, 10, 10, 0, 1 },
+				.utmi_bvalid	= { 0x0120, 9, 9, 0, 1 },
+				.utmi_ls	= { 0x0120, 5, 4, 0, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x0104, 8, 0, 0, 0x1d1 },
+				.ls_det_en	= { 0x3020, 1, 1, 0, 1 },
+				.ls_det_st	= { 0x3024, 1, 1, 0, 1 },
+				.ls_det_clr	= { 0x3028, 1, 1, 0, 1 },
+				.utmi_ls	= { 0x120, 17, 16, 0, 1 },
+				.utmi_hstdet	= { 0x120, 19, 19, 0, 1 }
+			}
+		},
+		.chg_det = {
+			.opmode		= { 0x0100, 3, 0, 5, 1 },
+			.cp_det		= { 0x0120, 24, 24, 0, 1 },
+			.dcp_det	= { 0x0120, 23, 23, 0, 1 },
+			.dp_det		= { 0x0120, 25, 25, 0, 1 },
+			.idm_sink_en	= { 0x0108, 8, 8, 0, 1 },
+			.idp_sink_en	= { 0x0108, 7, 7, 0, 1 },
+			.idp_src_en	= { 0x0108, 9, 9, 0, 1 },
+			.rdm_pdwn_en	= { 0x0108, 10, 10, 0, 1 },
+			.vdm_src_en	= { 0x0108, 12, 12, 0, 1 },
+			.vdp_src_en	= { 0x0108, 11, 11, 0, 1 },
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3328_phy_cfgs[] = {
 	{
 		.reg = 0x100,
@@ -1425,6 +1468,7 @@ static const struct rockchip_usb2phy_cfg rv1108_phy_cfgs[] = {
 static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,px30-usb2phy", .data = &rk3328_phy_cfgs },
 	{ .compatible = "rockchip,rk3228-usb2phy", .data = &rk3228_phy_cfgs },
+	{ .compatible = "rockchip,rk3308-usb2phy", .data = &rk3308_phy_cfgs },
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
 	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
-- 
2.17.1


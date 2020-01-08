Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660A0134E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 22:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgAHVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 16:08:05 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:43149 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgAHVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=luCgFmgElWl1DuPHBDrrBpPod+21xDQdITgD2m8WnFg=;
        b=aN5FDHIH3VVTbtJruSAZMCC35h2qMJkradv+RVDwisruOH7MGMT01ExLQOkumVk1VPgl
        cNBufKkscs7bIQy168NihOIEBPoVMoHsA7dPfHH8+/gu5mTeagm9MBrcgL804tUayO+CXy
        5rgvIe04q0wZ2mogi741Zp/jB9jsiLCww=
Received: by filterdrecv-p3mdw1-56c97568b5-9vfcv with SMTP id filterdrecv-p3mdw1-56c97568b5-9vfcv-17-5E1644A8-3B
        2020-01-08 21:07:52.606277766 +0000 UTC m=+1974281.228840687
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id OKxCYGFDTAKvOTnyv7bIhw
        Wed, 08 Jan 2020 21:07:52.400 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 13/14] drm/rockchip: dw-hdmi: remove unused plat_data on
 rk3228/rk3328
Date:   Wed, 08 Jan 2020 21:07:52 +0000 (UTC)
Message-Id: <20200108210740.28769-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hy7IFG+7y2omFdHym?=
 =?us-ascii?Q?qX0VGAyR32NQleVzsNfuSFqSWD2EgKZV+rde+YD?=
 =?us-ascii?Q?rT25M5w886gYT63ObARodq0WT87rowBnsb=2FYIHY?=
 =?us-ascii?Q?RYly0fr76ctneNYtZOdaDEOLkmCJ4h4axj6Hn1o?=
 =?us-ascii?Q?q+l8cbXxEbMTNp3nKZVrPYe6zreg1Gzs80GZGS0?=
 =?us-ascii?Q?biD39ITrclbqJebXUugEQ=3D=3D?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpll_cfg/cur_ctr/phy_config is not used when phy_force_vendor is true,
lets remove them.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 66c14df4a680..a813299e97a2 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -443,9 +443,6 @@ static struct rockchip_hdmi_chip_data rk3228_chip_data = {
 
 static const struct dw_hdmi_plat_data rk3228_hdmi_drv_data = {
 	.mode_valid = dw_hdmi_rk3228_mode_valid,
-	.mpll_cfg = rockchip_mpll_cfg,
-	.cur_ctr = rockchip_cur_ctr,
-	.phy_config = rockchip_phy_config,
 	.phy_data = &rk3228_chip_data,
 	.phy_ops = &rk3228_hdmi_phy_ops,
 	.phy_name = "inno_dw_hdmi_phy2",
@@ -480,9 +477,6 @@ static struct rockchip_hdmi_chip_data rk3328_chip_data = {
 
 static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
 	.mode_valid = dw_hdmi_rk3228_mode_valid,
-	.mpll_cfg = rockchip_mpll_cfg,
-	.cur_ctr = rockchip_cur_ctr,
-	.phy_config = rockchip_phy_config,
 	.phy_data = &rk3328_chip_data,
 	.phy_ops = &rk3328_hdmi_phy_ops,
 	.phy_name = "inno_dw_hdmi_phy2",
-- 
2.17.1


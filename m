Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C54134E61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 22:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgAHVIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 16:08:09 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:35289 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgAHVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=x3d4O9Awmply7Gb2seTh415j0YsnxIYTmKDTHVNNT2c=;
        b=dAcpmKP7UgPlLeMck1G5y8sTRPP4wEPF7bFoQBH/J07rMy0E94zT4hjLtF41IbCiUgPX
        BgEY2nwdlRYQNuLbrmcrxy1xTIXqbyttzdFpp0NOrLVqpb+Yd2kGX6KvS43Jm33ungyQn8
        Osllpm2FE9dZEUTg6G2jTTyYx4xQS7jJg=
Received: by filterdrecv-p3mdw1-56c97568b5-2vkp8 with SMTP id filterdrecv-p3mdw1-56c97568b5-2vkp8-20-5E1644A6-62
        2020-01-08 21:07:50.961205325 +0000 UTC m=+1974284.203795984
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id QWVTuMAqSKqZc5uIdTCBpw
        Wed, 08 Jan 2020 21:07:50.764 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 09/14] arm64: dts: rockchip: increase vop clock rate on
 rk3328
Date:   Wed, 08 Jan 2020 21:07:51 +0000 (UTC)
Message-Id: <20200108210740.28769-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hwYU02QfFsqeFLpfX?=
 =?us-ascii?Q?zC=2FPIsIIlZOhCQWMaWStdn4Sgg70tNAgTTH9RVO?=
 =?us-ascii?Q?HaqqultxCHltJE+1pIIzRgEALOD6ueRbUpLsUq0?=
 =?us-ascii?Q?IYYNm+GfobzDKAHuKbzOoBJlxsomm6GPqR3e3Bv?=
 =?us-ascii?Q?QB+ISN73HNluZljqCB=2FHNs=2FTLFlRQJfrnwXVGuK?=
 =?us-ascii?Q?5dh5QEvG2NSLjh7Lw8Y4g=3D=3D?=
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

The VOP on RK3328 needs to run at higher rate in order to
produce a proper 3840x2160 signal.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index c9ff1188bd7b..fee896338cc1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -803,8 +803,8 @@
 			<0>, <24000000>,
 			<24000000>, <24000000>,
 			<15000000>, <15000000>,
-			<100000000>, <100000000>,
-			<100000000>, <100000000>,
+			<300000000>, <100000000>,
+			<400000000>, <100000000>,
 			<50000000>, <100000000>,
 			<100000000>, <100000000>,
 			<50000000>, <50000000>,
-- 
2.17.1


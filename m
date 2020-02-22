Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7956C169216
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 23:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgBVWcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 17:32:00 -0500
Received: from vps.xff.cz ([195.181.215.36]:33652 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgBVWb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 17:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582410717; bh=JXyUwfOt5qQZMrdIu4ex8maESbx2epZpUJC0gC9L4w4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AUYJNq8I8IHJuRrgU97v7kcLO4ytgLad+vrkMhZa1fJO9jjlC+X/sS6h3G5NFAgFg
         4sOA6z6mAqm85JzyZElUYrIjUnGeXw8fkXPK16MAdCnbXudapqntos2Mb4FYL9aItt
         3YUU54zQa0yTtHBfR8mlfZRX4t7AhE8SHY6zL6bk=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Tomas Novotny <tomas@novotny.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] ARM: dts: sun8i-a83t-tbs-a711: Drop superfluous dr_mode
Date:   Sat, 22 Feb 2020 23:31:54 +0100
Message-Id: <20200222223154.221632-5-megous@megous.com>
In-Reply-To: <20200222223154.221632-1-megous@megous.com>
References: <20200222223154.221632-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property dr_mode = "otg" is the default in sun8i-a83t.dtsi

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 32fa64a44d8b4..267653775203e 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -490,7 +490,6 @@ gnss {
 };
 
 &usb_otg {
-	dr_mode = "otg";
 	status = "okay";
 };
 
-- 
2.25.1


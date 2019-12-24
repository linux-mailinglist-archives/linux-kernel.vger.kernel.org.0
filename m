Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4F12A1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 14:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLXNl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 08:41:27 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55603 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfLXNl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 08:41:27 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EFBDA240007;
        Tue, 24 Dec 2019 13:41:24 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2] MAINTAINERS: Track Rockchip PMIC drivers
Date:   Tue, 24 Dec 2019 14:41:22 +0100
Message-Id: <20191224134122.20385-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current Rockchip section misses all the PMIC related drivers. They
are all prefixed rk8* and are as wide as clks, regulators, pinctrl,
RTCs, audio, etc.

Add a dedicated MAINTAINER's entry.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v1:
* Create a PMIC entry in MAINTAINERS.
* Track files with rk8 and not rk80.

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3a5c54a41d..d3f814212ba8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13943,6 +13943,17 @@ S:	Maintained
 F:	drivers/staging/media/hantro/
 F:	Documentation/devicetree/bindings/media/rockchip-vpu.txt
 
+ROCKCHIP PMIC DRIVERS
+M:	Heiko Stuebner <heiko@sntech.de>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-rockchip@lists.infradead.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*rk8*
+F:	include/*/*/rk8*
+F:	include/*/*/*/rk8*
+F:	drivers/*/*rk8*
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.20.1


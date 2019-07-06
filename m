Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A249860FC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 12:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfGFKGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 06:06:06 -0400
Received: from mailoutvs40.siol.net ([185.57.226.231]:33742 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbfGFKGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:06:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 37A23521F90;
        Sat,  6 Jul 2019 12:06:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xglTeObZeE5R; Sat,  6 Jul 2019 12:06:01 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id F3EAE521FAE;
        Sat,  6 Jul 2019 12:06:00 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A99C5521F90;
        Sat,  6 Jul 2019 12:05:58 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     wens@csie.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: axp20x: fix DCDC6 for AXP803
Date:   Sat,  6 Jul 2019 12:05:45 +0200
Message-Id: <20190706100545.22759-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190706100545.22759-1-jernej.skrabec@siol.net>
References: <20190706100545.22759-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring of axp20x driver introduced a bug in AXP803's DCDC6
regulator definition.

Fix it.

Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
index c951568994a1..29b92ce521b7 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -181,7 +181,7 @@
 #define AXP803_DCDC6_600mV_END		\
 	(AXP803_DCDC6_600mV_START + AXP803_DCDC6_600mV_STEPS)
 #define AXP803_DCDC6_1120mV_START	0x33
-#define AXP803_DCDC6_1120mV_STEPS	14
+#define AXP803_DCDC6_1120mV_STEPS	20
 #define AXP803_DCDC6_1120mV_END		\
 	(AXP803_DCDC6_1120mV_START + AXP803_DCDC6_1120mV_STEPS)
 #define AXP803_DCDC6_NUM_VOLTAGES	72
--=20
2.22.0


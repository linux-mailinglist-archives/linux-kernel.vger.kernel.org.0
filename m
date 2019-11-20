Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38993103DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfKTO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:59:31 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:46354 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfKTO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:59:30 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id UEzU2100d5USYZQ06EzUK0; Wed, 20 Nov 2019 15:59:28 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXRS4-0002Ij-JA; Wed, 20 Nov 2019 15:59:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXRS4-0002EH-Ht; Wed, 20 Nov 2019 15:59:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] reset: Do not register resource data for missing resets
Date:   Wed, 20 Nov 2019 15:59:26 +0100
Message-Id: <20191120145927.8523-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120145927.8523-1-geert+renesas@glider.be>
References: <20191120145927.8523-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an optional reset is not present, __devm_reset_control_get() and
devm_reset_control_array_get() still register resource data to release
the non-existing reset on cleanup, which is futile.

Fix this by skipping NULL reset control pointers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Use IS_ERR_OR_NULL().
---
 drivers/reset/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index c8cc8cacdade0391..7597c70e04d5b42b 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -787,7 +787,7 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
-	if (!IS_ERR(rstc)) {
+	if (!IS_ERR_OR_NULL(rstc)) {
 		*ptr = rstc;
 		devres_add(dev, ptr);
 	} else {
@@ -928,7 +928,7 @@ devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
 		return ERR_PTR(-ENOMEM);
 
 	rstc = of_reset_control_array_get(dev->of_node, shared, optional, true);
-	if (IS_ERR(rstc)) {
+	if (IS_ERR_OR_NULL(rstc)) {
 		devres_free(devres);
 		return rstc;
 	}
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0110A92A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfIDTxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 15:53:52 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58072 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfIDTxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:53:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 2894EFB03;
        Wed,  4 Sep 2019 21:45:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hA6abr_Xhskt; Wed,  4 Sep 2019 21:45:14 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BED9E486D0; Wed,  4 Sep 2019 12:35:00 -0700 (PDT)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     "to : Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: tps65132: Stop parsing DT when gpio is not found
Date:   Wed,  4 Sep 2019 12:35:00 -0700
Message-Id: <363bd50cc7c60daa57d614a341d1fd649f05194c.1567625660.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of a missing (optional) gpio don't fall through up to
"ti,active-discharge-time-us" due to
devm_fwnode_get_index_gpiod_from_child() returning NULL (since
gpiod_get_from_of_node() returned NULL) but rather indicate success as
intended.

This makes the driver probe correctly when e.g. only the enable gpio is
given.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/regulator/tps65132-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 6e22f5ebba2e..e302bd01a084 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -138,7 +138,7 @@ static int tps65132_of_parse_cb(struct device_node *np,
 
 	rpdata->en_gpiod = devm_fwnode_get_index_gpiod_from_child(tps->dev,
 					"enable", 0, &np->fwnode, 0, "enable");
-	if (IS_ERR(rpdata->en_gpiod)) {
+	if (IS_ERR_OR_NULL(rpdata->en_gpiod)) {
 		ret = PTR_ERR(rpdata->en_gpiod);
 
 		/* Ignore the error other than probe defer */
@@ -150,7 +150,7 @@ static int tps65132_of_parse_cb(struct device_node *np,
 	rpdata->act_dis_gpiod = devm_fwnode_get_index_gpiod_from_child(
 					tps->dev, "active-discharge", 0,
 					&np->fwnode, 0, "active-discharge");
-	if (IS_ERR(rpdata->act_dis_gpiod)) {
+	if (IS_ERR_OR_NULL(rpdata->act_dis_gpiod)) {
 		ret = PTR_ERR(rpdata->act_dis_gpiod);
 
 		/* Ignore the error other than probe defer */
-- 
2.23.0.rc1


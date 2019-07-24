Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CE27412F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 00:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfGXWB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 18:01:58 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:39216 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbfGXWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:01:57 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d44 with ME
        id gm1q2000P4n7eLC03m1rDF; Thu, 25 Jul 2019 00:01:55 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Jul 2019 00:01:55 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ide: tx4939ide: Fix the name used in a 'devm_request_mem_region()' call
Date:   Thu, 25 Jul 2019 00:01:45 +0200
Message-Id: <20190724220145.17282-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be "tx4939ide" instead of "tx4938ide", but here MODNAME is even
better.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/ide/tx4939ide.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index 88d132edc4e3..079b271dd5a7 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -549,7 +549,7 @@ static int __init tx4939ide_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	if (!devm_request_mem_region(&pdev->dev, res->start,
-				     resource_size(res), "tx4938ide"))
+				     resource_size(res), MODNAME))
 		return -EBUSY;
 	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
 					      resource_size(res));
-- 
2.20.1


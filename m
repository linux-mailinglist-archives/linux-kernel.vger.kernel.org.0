Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 301B3A42D4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 08:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfHaGnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 02:43:05 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:54100 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfHaGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 02:43:05 -0400
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d55 with ME
        id vij1200023xPcdm03ij1Hg; Sat, 31 Aug 2019 08:43:02 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 Aug 2019 08:43:02 +0200
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ek5.chimenti@gmail.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] media: seco-cec: Add a missing 'release_region()' in an error handling path
Date:   Sat, 31 Aug 2019 08:42:58 +0200
Message-Id: <20190831064258.916-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of the probe function, we have a call to
'request_muxed_region(BRA_SMB_BASE_ADDR, 7, "CEC00001")()'

A corresponding 'release_region()' is performed in the remove function but
is lacking in the error handling path.

Add it.

Fixes: b03c2fb97adc ("media: add SECO cec driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/platform/seco-cec/seco-cec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/seco-cec/seco-cec.c b/drivers/media/platform/seco-cec/seco-cec.c
index 9cd60fe1867c..a86b6e8f9196 100644
--- a/drivers/media/platform/seco-cec/seco-cec.c
+++ b/drivers/media/platform/seco-cec/seco-cec.c
@@ -675,6 +675,7 @@ static int secocec_probe(struct platform_device *pdev)
 err_delete_adapter:
 	cec_delete_adapter(secocec->cec_adap);
 err:
+	release_region(BRA_SMB_BASE_ADDR, 7);
 	dev_err(dev, "%s device probe failed\n", dev_name(dev));
 
 	return ret;
-- 
2.20.1


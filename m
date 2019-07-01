Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED00F54DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfFYLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 07:47:42 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:56312 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728527AbfFYLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:47:41 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 07:47:40 EDT
Received: from lab-pc01.sra.uni-hannover.de (lab.sra.uni-hannover.de [130.75.33.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 267C51F3F6;
        Tue, 25 Jun 2019 13:42:30 +0200 (CEST)
From:   Florian Knauf <florian.knauf@stud.uni-hannover.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@i4.cs.fau.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Knauf <florian.knauf@stud.uni-hannover.de>,
        Christian Ewert <christian.ewert@stud.uni-hannover.de>
Subject: [PATCH] drivers/block/loop: Remove deprecated function, range check for max_loop
Date:   Tue, 25 Jun 2019 13:40:56 +0200
Message-Id: <20190625114056.8706-1-florian.knauf@stud.uni-hannover.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the deprecated simple_strtol function from the option
parsing logic in the loopback device driver. It also introduces a range
check for the max_loop parameter to ensure that negative and out-of-range
values (that cannot be represented by int max_loop) are ignored.

Signed-off-by: Florian Knauf <florian.knauf@stud.uni-hannover.de>
Signed-off-by: Christian Ewert <christian.ewert@stud.uni-hannover.de>
---
 drivers/block/loop.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 102d79575895..acdd028ed486 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2289,7 +2289,17 @@ module_exit(loop_exit);
 #ifndef MODULE
 static int __init max_loop_setup(char *str)
 {
-	max_loop = simple_strtol(str, NULL, 0);
+	long max_loop_long = 0;
+
+	/*
+	 * Range check for max_loop: negative values and values not
+	 * representable by int are ignored.
+	 */
+	if (kstrtol(str, 0, &max_loop_long) == 0 &&
+			max_loop_long >= 0 &&
+			max_loop_long <= INT_MAX)
+		max_loop = (int) max_loop_long;
+
 	return 1;
 }
 
-- 
2.17.1


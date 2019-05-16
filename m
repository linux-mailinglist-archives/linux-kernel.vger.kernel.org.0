Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2920713
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfEPMj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 08:39:27 -0400
Received: from skyboo.net ([94.40.87.198]:47592 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfEPMj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:39:27 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hRFfQ-0007IX-3Y; Thu, 16 May 2019 14:39:24 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Mariusz Bialonczyk <manio@skyboo.net>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Date:   Thu, 16 May 2019 14:39:21 +0200
Message-Id: <20190516123921.27516-1-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, greg@kroah.com, manio@skyboo.net, jeff.dagenais@gmail.com
X-SA-Exim-Mail-From: manio@skyboo.net
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on nemesis.skyboo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RELAYS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.1
Subject: [PATCH v2] w1: ds2408: Fix typo after 49695ac46861 (reset on output_write retry with readback)
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in commit:
49695ac46861 w1: ds2408: reset on output_write retry with readback

Fixes: 49695ac46861 ("w1: ds2408: reset on output_write retry with readback")
Reported-by: Phil Elwell <phil@raspberrypi.org>
Cc: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---
 drivers/w1/slaves/w1_ds2408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index 92e8f0755b9a..edf0bc98012c 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -138,7 +138,7 @@ static ssize_t status_control_read(struct file *filp, struct kobject *kobj,
 		W1_F29_REG_CONTROL_AND_STATUS, buf);
 }
 
-#ifdef fCONFIG_W1_SLAVE_DS2408_READBACK
+#ifdef CONFIG_W1_SLAVE_DS2408_READBACK
 static bool optional_read_back_valid(struct w1_slave *sl, u8 expected)
 {
 	u8 w1_buf[3];
-- 
2.19.0.rc1


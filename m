Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E12A37D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 10:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEYIqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 04:46:00 -0400
Received: from skyboo.net ([94.40.87.198]:41804 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfEYIp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 04:45:59 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hUSJR-0007xV-DF; Sat, 25 May 2019 10:45:57 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>
Date:   Sat, 25 May 2019 10:45:38 +0200
Message-Id: <20190525084538.29389-1-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20190524182109.GA26827@kroah.com>
References: <20190524182109.GA26827@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, greg@kroah.com, manio@skyboo.net
X-SA-Exim-Mail-From: manio@skyboo.net
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on nemesis.skyboo.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RELAYS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.1
Subject: [PATCH 4/4 v2] w1: ds2805: rename w1_family struct, fixing c-p typo
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ds2805 has a structure named: w1_family_2d, which surely
comes from a w1_ds2431 module. This commit fixes this name to
prevent confusion and mark a correct family name.

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---
Changes in v2:
    Added a missing commit msg.

 drivers/w1/slaves/w1_ds2805.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2805.c b/drivers/w1/slaves/w1_ds2805.c
index 29348d283a65..ab349604531a 100644
--- a/drivers/w1/slaves/w1_ds2805.c
+++ b/drivers/w1/slaves/w1_ds2805.c
@@ -288,7 +288,7 @@ static struct w1_family_ops w1_f0d_fops = {
 	.remove_slave   = w1_f0d_remove_slave,
 };
 
-static struct w1_family w1_family_2d = {
+static struct w1_family w1_family_0d = {
 	.fid = W1_EEPROM_DS2805,
 	.fops = &w1_f0d_fops,
 };
@@ -296,13 +296,13 @@ static struct w1_family w1_family_2d = {
 static int __init w1_f0d_init(void)
 {
 	pr_info("%s()\n", __func__);
-	return w1_register_family(&w1_family_2d);
+	return w1_register_family(&w1_family_0d);
 }
 
 static void __exit w1_f0d_fini(void)
 {
 	pr_info("%s()\n", __func__);
-	w1_unregister_family(&w1_family_2d);
+	w1_unregister_family(&w1_family_0d);
 }
 
 module_init(w1_f0d_init);
-- 
2.19.0.rc1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC4058A34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 20:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfF0SwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 14:52:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37217 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0SwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:52:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so1680904pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=7D0PzAfViZ1saMwvNXJVGOaPjQ/bd1/rxTaSKwyyN7c=;
        b=Or3LxChJeEuS1HBnMbn0UutirVCYfBWmq+PyVXAXsmtTRTu2mgUE0I+d2IFhAA4eMt
         hDPclPC9uDGZW/BcYzaRPWWQdaEzo2N60lU0qf2Ul/oMsmtURjSWwNsjQB581IMH5bg2
         KxhX0Pepu0pJkMF1p2c7/ehz91TZJXogYpMLnp4br5BFJ+lyIkf51A7m/lN2u1Z/1xj7
         cdtKTn/ITHXAcj7r3hNhpDrmm+/9a5Aqi71PYdmCI4sg5EMcrt77LF87Z/vx+EeeLDwf
         3WG85rGLM4DLRuHVKEI3IlP4AWkfmZKRaBRdGxLhLbjaxYObDIh6wUg0knh9fDR/VJBh
         W+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=7D0PzAfViZ1saMwvNXJVGOaPjQ/bd1/rxTaSKwyyN7c=;
        b=UeFpxg7q8zh+Yl9Nrv4ePk25LAQAAkE62hAO45rbQ1HGjtXv0hO8PYvcb1Fp+RcmVl
         E885BMDO4+pX1dXMqv9EPN+LrXrtuT+9Ie67umUZQfh4sU0xsSxvWc+yWXvn4R72+8g7
         EDeApu99iJvqExg+HaHOHLASKf1KJQ+7MjF1UDdz1P0jB1c3LpJ0K+xJe2OGzEkEQlbh
         xqUIv0DZ7Uk/zJcCVQFp9IwS+g/bct6/nQluWN1tWNtw9s06xmsVD9XsYAvwpEqv4dE1
         8ZEBeE5da8WA94H4izZ3fqA1JzkagYAdJGAHzOA7hcUVmHh9TGhQFJkooTp0oYhShTeh
         d6AQ==
X-Gm-Message-State: APjAAAU3Z0st6P2k5929lR1jRipa4S+SzYytpQBv/vB5NOIXRTAy2Tok
        dlTheAMUXheDAThboKCAKHo=
X-Google-Smtp-Source: APXvYqxlncH/motRpxarXISHjXNRG22cGr8PEndowAP9oFWA6icJDy71gKmV/rtomSNgmIBIN4/uZQ==
X-Received: by 2002:a63:6b07:: with SMTP id g7mr5345593pgc.325.1561661521129;
        Thu, 27 Jun 2019 11:52:01 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id c83sm5194088pfb.111.2019.06.27.11.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 11:52:00 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, harshjain32@gmail.com,
        harshjain.prof@gmail.com
Subject: [PATCH] staging:kpc2000:Fix sparse warnings
Date:   Fri, 28 Jun 2019 00:21:38 +0530
Message-Id: <20190627185138.26214-1-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: root <harshjain32@gmail.com>

Fix following sparse warning
symbol was not declared. Should it be static?
Using plain integer as NULL pointer

Signed-off-by: Harsh Jain <harshjain32@gmail.com>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
index 0fb068b2408d..155da641e3a2 100644
--- a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
+++ b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
@@ -614,7 +614,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 /********************************
  *** Part 2 - Driver Handlers ***
  ********************************/
-int pi2c_probe(struct platform_device *pldev)
+static int pi2c_probe(struct platform_device *pldev)
 {
     int err;
     struct i2c_device *priv;
@@ -664,7 +664,7 @@ int pi2c_probe(struct platform_device *pldev)
     return 0;
 }
 
-int pi2c_remove(struct platform_device *pldev)
+static int pi2c_remove(struct platform_device *pldev)
 {
     struct i2c_device *lddev;
     dev_dbg(&pldev->dev, "pi2c_remove(pldev = %p '%s')\n", pldev, pldev->name);
@@ -679,9 +679,9 @@ int pi2c_remove(struct platform_device *pldev)
     //pci_set_drvdata(dev, NULL);
     
     //cdev_del(&lddev->cdev);
-    if(lddev != 0) {
+    if(lddev != NULL) {
         kfree(lddev);
-        pldev->dev.platform_data = 0;
+        pldev->dev.platform_data = NULL;
     }
     
     return 0;
-- 
2.17.1


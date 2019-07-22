Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D0970137
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfGVNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 09:38:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40786 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGVNiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:38:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so19194609pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4rY0o9P+RQBwG6AQA0NgfV52Wyz0Agef44vTTTeJso=;
        b=MR2+B7q96ZvYtKQQbTurfq0mf0Ea9yTRfAzNCiQYSXUl0a6YKY7MaJTIzWzoNAFlgG
         z7WKK0mNICPAoI99WgJ1ElMFxADK5BVorb/4RGLOZiFoCCO6nukJ2XPhKfzOKExGUHsF
         W7xJVmBUgQ4AhVs3KKLggVjfkSG9ymTK6Arf/29xwCdc/vVScKwGOoMmridg7xBCz0qC
         lSynofsZnLqs/Y7Ogxaz+/7n5HtDhnKbgvoeKgxf/1eQoA/cNWs5XfzPJaQpWXl15M97
         Myg2IPNLdsYAZIyzyK2mzlKvAL5fJeqlnYfWpNfWzI6lMegRqfFn2ggpWzWdbvHJ1PNh
         k1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4rY0o9P+RQBwG6AQA0NgfV52Wyz0Agef44vTTTeJso=;
        b=Jmz1necoe0EuOVW3e8/LfeASM6NuaBK/y+ruV40Yxtmd93gRRLrQoZ+hRIl35u8Wwt
         WG90OaSbYQzY9h9xywbZ9tNOmVKU37LDwaCKwmKLkfY/1shNrzV2xRg+3UBfD0lU5hgs
         qO31fjfmemhIFene0dleKw6lFrUlYZbKVHgX8JaybfznCzV6PR/ehpJvr/9w0n5aMRIb
         tUegL9tQj8ISQ+V0qYFT7WbDYA/moqVppE4SZdjc8PDgL+mjMYjUfszOkLv+ra1Fydrk
         gwvXKfcxE+iz0lw3+lQEnL/PhdrlW9juDMdLMgffvJZT/qXo8RH3uvtKDnVuSUrug+LQ
         cWDA==
X-Gm-Message-State: APjAAAXERN+Ft5tYdQGj++ejMu6zuiwoXuLvfJ9zgvaUBk1iwq4HayPp
        1bX7WeF8LF4eCdhhIleQQxrfQZD7dXI=
X-Google-Smtp-Source: APXvYqyFWjihQTH6NgfcnSlOtdswGEBSLOjFhXsMOLbt7dx0lVglxyNn9BjK8qcDtbIr6vNLyQH2zQ==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr77874631pld.16.1563802682411;
        Mon, 22 Jul 2019 06:38:02 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id f3sm62630907pfg.165.2019.07.22.06.37.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:38:01 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mailbox: armada-37xx-rwtm: Use device-managed registration API
Date:   Mon, 22 Jul 2019 21:37:23 +0800
Message-Id: <20190722133722.26784-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_mbox_controller_register to get rid of
redundant remove function.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mailbox/armada-37xx-rwtm-mailbox.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mailbox/armada-37xx-rwtm-mailbox.c b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
index 97f90e97a83c..19f086716dc5 100644
--- a/drivers/mailbox/armada-37xx-rwtm-mailbox.c
+++ b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
@@ -180,7 +180,7 @@ static int armada_37xx_mbox_probe(struct platform_device *pdev)
 	mbox->controller.ops = &a37xx_mbox_ops;
 	mbox->controller.txdone_irq = true;
 
-	ret = mbox_controller_register(&mbox->controller);
+	ret = devm_mbox_controller_register(mbox->dev, &mbox->controller);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register mailbox controller\n");
 		return ret;
@@ -190,17 +190,6 @@ static int armada_37xx_mbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int armada_37xx_mbox_remove(struct platform_device *pdev)
-{
-	struct a37xx_mbox *mbox = platform_get_drvdata(pdev);
-
-	if (!mbox)
-		return -EINVAL;
-
-	mbox_controller_unregister(&mbox->controller);
-
-	return 0;
-}
 
 static const struct of_device_id armada_37xx_mbox_match[] = {
 	{ .compatible = "marvell,armada-3700-rwtm-mailbox" },
@@ -211,7 +200,6 @@ MODULE_DEVICE_TABLE(of, armada_37xx_mbox_match);
 
 static struct platform_driver armada_37xx_mbox_driver = {
 	.probe	= armada_37xx_mbox_probe,
-	.remove	= armada_37xx_mbox_remove,
 	.driver	= {
 		.name		= DRIVER_NAME,
 		.of_match_table	= armada_37xx_mbox_match,
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F193340E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfFCPxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:53:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbfFCPwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 804261A25;
        Mon,  3 Jun 2019 08:52:04 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 672DB3F246;
        Mon,  3 Jun 2019 08:52:03 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Jiri Slaby <jslaby@suse.com>
Subject: [RFC PATCH 43/57] drivers: tty : Use class_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:50:09 +0100
Message-Id: <1559577023-558-44-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic helper to find a device matching the of_node.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/tty/tty_io.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 033ac7e..b078fdb 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2950,17 +2950,11 @@ void do_SAK(struct tty_struct *tty)
 
 EXPORT_SYMBOL(do_SAK);
 
-static int dev_match_devt(struct device *dev, const void *data)
-{
-	const dev_t *devt = data;
-	return dev->devt == *devt;
-}
-
 /* Must put_device() after it's unused! */
 static struct device *tty_get_device(struct tty_struct *tty)
 {
 	dev_t devt = tty_devnum(tty);
-	return class_find_device(tty_class, NULL, &devt, dev_match_devt);
+	return class_find_device_by_devt(tty_class, NULL, devt);
 }
 
 
-- 
2.7.4


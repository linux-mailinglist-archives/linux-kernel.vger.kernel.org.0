Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1FF2603
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 04:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbfKGDc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 22:32:58 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:40787 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbfKGDc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:32:58 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 477pns2cxLzJb;
        Thu,  7 Nov 2019 04:30:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1573097441; bh=vZsP+gC6xjkhdwkU8RmUdpu99NTy+OKDeJJ+3qq5kYI=;
        h=Date:From:Subject:To:Cc:From;
        b=Vp+bEi+GUhpQ5WfPDWNZMnazNS1UYkrwJF8PI1MnS9Xx+cYCK1n7+HhCneO2qFKxH
         ZIwc+TA5Yr/9I+0ORz59LVWSibS/faCpvKg61RK3aQYU1duQVIst7+lV9babK6QI4G
         pIQakIJjInH2J5yFhngG4ucKz3nq5HyYI0HqTuykeDPXLjCpmQ8MXBMst6eFquJr7m
         LPOjCI2/dTx/LVW1AowrEliT4dS/VI8g0lqbeEFvYO/zjIO4NhjulLY8QySAm9ObNO
         QQzg2QVVy/cQMrNYKmgStqkkx8Qn3wb9F7JCAVrshzi7pjyKUy8i9KUR2zQgibWGqW
         eGMz8tAmwRYKw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Thu, 07 Nov 2019 04:32:53 +0100
Message-Id: <a47522045d251146c8f7daaeb18a32716bfc3397.1573097536.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH RESEND] ata_piix: remove open-coded dmi_match(DMI_OEM_STRING)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-ide@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since de40614de99 ("firmware: dmi_scan: Add DMI_OEM_STRING support to
dmi_matches") dmi_check_system() can match OEM_STRINGs itself.
Use the feature.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/ata/ata_piix.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index e4da725381d3..3ca7720e7d8f 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -840,6 +840,12 @@ static int piix_broken_suspend(void)
 				DMI_MATCH(DMI_PRODUCT_NAME, "Tecra M3"),
 			},
 		},
+		{
+			.ident = "TECRA M3",
+			.matches = {
+				DMI_MATCH(DMI_OEM_STRING, "Tecra M3,"),
+			},
+		},
 		{
 			.ident = "TECRA M4",
 			.matches = {
@@ -955,18 +961,10 @@ static int piix_broken_suspend(void)
 
 		{ }	/* terminate list */
 	};
-	static const char *oemstrs[] = {
-		"Tecra M3,",
-	};
-	int i;
 
 	if (dmi_check_system(sysids))
 		return 1;
 
-	for (i = 0; i < ARRAY_SIZE(oemstrs); i++)
-		if (dmi_find_device(DMI_DEV_TYPE_OEM_STRING, oemstrs[i], NULL))
-			return 1;
-
 	/* TECRA M4 sometimes forgets its identify and reports bogus
 	 * DMI information.  As the bogus information is a bit
 	 * generic, match as many entries as possible.  This manual
-- 
2.20.1


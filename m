Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A57B1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfG3SQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:16:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43501 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfG3SQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so30264763pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dycfr8v1fdba663pIpdzjcaqpiqeC9jW3WU7WRUspIM=;
        b=TQZZoOLvt58dfKVYoj15whJcQ7tnhbLU89aCOVDpcoqllL3LKtld2+Q4MLeOghIXbF
         Z0oHqm159YrVMrXWR7iUVI8WTDdJvDZe1RsBVUBXHQG8eIhHBrUG0s52gHmhK4GjESCv
         YvAjtxLeiT3Nu3PuZP+vBz7AU16SXrtXmSth4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dycfr8v1fdba663pIpdzjcaqpiqeC9jW3WU7WRUspIM=;
        b=mgHrm7iOVcWlPzkdF4D2Oh9NCFuvbU8GqM5WyPZm9ZRkp3wyhAVxYbkq1FMJ2GLrlV
         EUIF9VcGNkl//NGjvcWd3v7Z/3GWM3tKq+DPOFK/Nr9EKpJaOLHPt9B0Vt0F+/00eVWc
         IO4G6KnuGF8M5dNZjWWhtSyp3I1raK3vW7r86lsm125feq2oG4h2jrfg6QXeDmNcCh7f
         IbNTdJ0PQFAxKePiBLWWfneiY7fB7sC0oJz7Bi0+yMt8Qe7wgN5lcp6ck6LQ1RPrlaIj
         u2OXBGgTkfXbR4utOqjz7kLyixJXxu9kGBWrZ/g8uHaUHYUp5PuyQlcm45bRHIDjvKF1
         dQrA==
X-Gm-Message-State: APjAAAU9y2lwQKmGZf87v2YSCYt7nczZA9/cuKoqICJfKFEmtIbXG0xo
        D2LXQ8xCY2DgCZ0S2u7WhjSPrrvQluc=
X-Google-Smtp-Source: APXvYqxhgatm4ea/UR+LHTwGkQink6xwt7eAaph3+IuuaJMRKEdnT5Ph9WsXOO++1OHrj8aVKflyFA==
X-Received: by 2002:a63:2006:: with SMTP id g6mr108309530pgg.287.1564510568689;
        Tue, 30 Jul 2019 11:16:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:08 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 11/57] edac: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:11 -0700
Message-Id: <20190730181557.90391-12-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: linux-edac@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/edac/altera_edac.c | 13 +++----------
 drivers/edac/xgene_edac.c  |  1 -
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index c2e693e34d43..5405bd727731 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -347,11 +347,8 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "No irq %d in DT\n", irq);
+	if (irq < 0)
 		return -ENODEV;
-	}
 
 	/* Arria10 has a 2nd IRQ */
 	irq2 = platform_get_irq(pdev, 1);
@@ -2177,10 +2174,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 
 	edac->sb_irq = platform_get_irq(pdev, 0);
-	if (edac->sb_irq < 0) {
-		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
+	if (edac->sb_irq < 0)
 		return edac->sb_irq;
-	}
 
 	irq_set_chained_handler_and_data(edac->sb_irq,
 					 altr_edac_a10_irq_handler,
@@ -2212,10 +2207,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 #else
 	edac->db_irq = platform_get_irq(pdev, 1);
-	if (edac->db_irq < 0) {
-		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
+	if (edac->db_irq < 0)
 		return edac->db_irq;
-	}
 	irq_set_chained_handler_and_data(edac->db_irq,
 					 altr_edac_a10_irq_handler, edac);
 #endif
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index e4a1032ba0b5..cb26ce5d5798 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1921,7 +1921,6 @@ static int xgene_edac_probe(struct platform_device *pdev)
 		for (i = 0; i < 3; i++) {
 			irq = platform_get_irq(pdev, i);
 			if (irq < 0) {
-				dev_err(&pdev->dev, "No IRQ resource\n");
 				rc = -EINVAL;
 				goto out_err;
 			}
-- 
Sent by a computer through tubes


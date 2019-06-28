Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE565A249
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfF1R15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 13:27:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37313 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1R1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:27:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh12so3597683plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=mLsHJ0i3ujM34GaeB9I76qtU6QknhGyjQmwjCGGHvKA=;
        b=DqFWfig9P23wc62pGuCwg0dPMtOsYiK0zWh3xIxvl5JzYBwvaQKkg9HU4XJE8efjSv
         RAPjqCv9RtEiWWBU54T7ZQjutf2/Vba2BKCaBGU6OVQG/Qox4QIh/+LNJmCWPmn7XU/Y
         P+DGF4KaRrLTioPue9TpH+SGQj5jyu2NrPKfLbFpMyeOYC4krOtjwaWsXe/vwp3mB6F6
         XsBoPEaaMUEadLLKpKTmMWwCPDAIQe5iCzmOR2HBfGxPrYpfvQq+LbkHqPNr6DwQR496
         2OKW/5fOvrR07JLR/HRzROi0gHV9XIZuMQtKN3euZvDHC6YTukkFq1F/HzqescBKHxXT
         hp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=mLsHJ0i3ujM34GaeB9I76qtU6QknhGyjQmwjCGGHvKA=;
        b=qVnRu06WNiUO0pP/HTvxEtW1jQ4ccE0K90yCvugGZ7JEXdFf36g536UQO/t92VESw+
         vnsyiLtCU0+j1Sb1NRlfRrDQq1X4bTHeSYsRxnj1gffxd3MueVKAciayt7AhoZofMYUh
         J6a2TnjrdZBPPNsAyJJn3TmmU6wFm/Mhsrk5Euc1Uwn1KP31HzLP81qFjnm7YlLk+xwF
         Tmc2JZ5F3++M+bs5NH2fyoSnts6NgEtyrMBh+OZSbNptdLZDA7NxIpdfIVauePDyLPLQ
         s0wEaU+3WFvd2+a49au6Q3HTmfHKGVg9W/ikcviv15OB4RyB2wpnlY5TM19rLa8IikIT
         ww4g==
X-Gm-Message-State: APjAAAVg4iD2F30hY9vUzys8dPNkZ61s5xnDCK1o3Ii5MfSb1dMzsCv1
        AGzA0ixNoOoe9udNRMZJrhXe3hQ6yGkxzg==
X-Google-Smtp-Source: APXvYqxSGAg6EZj/7hBC8Rbh4U6d65ZcCkSc/ZB+HyhFuwaojEV5WfwsTnHiDyNXVEJfiPzSsXlb/w==
X-Received: by 2002:a17:902:bf08:: with SMTP id bi8mr13291525plb.189.1561742875096;
        Fri, 28 Jun 2019 10:27:55 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id k19sm2070490pgl.42.2019.06.28.10.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 10:27:54 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, harshjain32@gmail.com,
        harshjain.prof@gmail.com
Subject: [PATCH 2/2] staging:kpc2000:Fix integer as null pointer warning
Date:   Fri, 28 Jun 2019 22:57:24 +0530
Message-Id: <20190628172724.2689-3-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628172724.2689-2-harshjain32@gmail.com>
References: <20190628172724.2689-1-harshjain32@gmail.com>
 <20190628172724.2689-2-harshjain32@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes "Using plain integer as NULL pointer"
sparse warning.

Signed-off-by: Harsh Jain <harshjain32@gmail.com>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
index 204f33d0dc69..155da641e3a2 100644
--- a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
+++ b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
@@ -679,9 +679,9 @@ static int pi2c_remove(struct platform_device *pldev)
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


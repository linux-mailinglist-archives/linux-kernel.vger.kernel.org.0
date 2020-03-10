Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE78180609
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:17:27 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54909 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:17:27 -0400
Received: by mail-pj1-f68.google.com with SMTP id np16so762167pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5tsowySGUi7fWa5LgHfYnviwiJBcMtPtbeyXUuKpjsQ=;
        b=T0E8HUeA7l4gRvbttaZDHmRSVcxZWbwTx8VaRiegZJ1itOZbArzlvs6v8reeDRz1VQ
         NoRxhUI8omLu6iCccuoI6TSyHXu12+JsWLVY3ownjYdKRidQh1PCQikeud7opT/kV0xD
         JCO5tSEbRUHMPdSSYkhz/q7Etd10dLCsXshRfQiEgb6PmabB1iqNWlmgb2R00JWaVq0e
         N8kCvTzv2GFCxY2S3jCHzSZWxpSIUPCAEZAkqUuXPC5NR1LszhMjOnqRzVmTyOCXfZaT
         2Difadbergz4ym4bsqs7hVfDzGokD8JiDaetZoAN4eZo4rqYkdNDWwC68jq/bbouH7ih
         lHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5tsowySGUi7fWa5LgHfYnviwiJBcMtPtbeyXUuKpjsQ=;
        b=UzpiZTEzLQ0weNLHEU/rBfxLfits//Jr84tC6B6v6SGgvFVuqdgeuQdIItKArVMutu
         l8kGBYOIeUWiAkke7SyNPsDIYERGgiOYWmyjcYWFf8BbEGJ4KSRLJsSS/l9x3m6xs0UC
         9+y7dQEd0HOqIajLZJ8w0xxSCPYSzTktrj2cng+0Cd8N9fCTMn1ZRX4WuNZrNSuPgICl
         hT1I9JDR6bvK6LVkxcvd4hIdkCIE3G9CIN4mf1LIQfGSWdZk5cxXDmEsgMFi1CbarEXd
         OLXJ6fKBA0TRMeh4xCF+3ruKUuij3mbt4K0FgPi7BnkTwa42DBdF/hKZAhDfeVIxmM5u
         bQcA==
X-Gm-Message-State: ANhLgQ0M/rvewZm/s6pT3cOMWpsrWEl3k6+e9wMgZ4dS1n36IdisfWVW
        9vXb4SAZSUMbXng2AgJIUfg=
X-Google-Smtp-Source: ADFU+vt1aV+K5dD0WuYCnprsamxD3MXtNOZ1HsDbCasxtvc8KALg1pF81s2OzocK/4CjJoAiTwRLJw==
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr3002772pjx.175.1583864246484;
        Tue, 10 Mar 2020 11:17:26 -0700 (PDT)
Received: from localhost.localdomain ([49.128.163.16])
        by smtp.gmail.com with ESMTPSA id l25sm47245630pgn.47.2020.03.10.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:17:25 -0700 (PDT)
From:   Sladyn Nunes <sladynlinuxkernel@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Sladyn Nunes <sladynlinuxkernel@gmail.com>
Subject: [PATCH] drivers: base: platform.c: Fix coding style issue.
Date:   Tue, 10 Mar 2020 23:47:12 +0530
Message-Id: <20200310181712.884-1-sladynlinuxkernel@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed whitespace and coding style issues in the
document.

Signed-off-by: Sladyn Nunes <sladynlinuxkernel@gmail.com>
---
 drivers/base/platform.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..0da339e14437 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -552,7 +552,8 @@ int platform_device_add(struct platform_device *pdev)
 		if (p) {
 			ret = insert_resource(p, r);
 			if (ret) {
-				dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
+				dev_err(&pdev->dev, "failed to claim resource %d: %pR\n",
+						 i, r);
 				goto failed;
 			}
 		}
@@ -573,6 +574,7 @@ int platform_device_add(struct platform_device *pdev)
 
 	while (i--) {
 		struct resource *r = &pdev->resource[i];
+
 		if (r->parent)
 			release_resource(r);
 	}
@@ -604,6 +606,7 @@ void platform_device_del(struct platform_device *pdev)
 
 		for (i = 0; i < pdev->num_resources; i++) {
 			struct resource *r = &pdev->resource[i];
+
 			if (r->parent)
 				release_resource(r);
 		}
@@ -997,7 +1000,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	if (len != -ENODEV)
 		return len;
 
-	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
+	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
-- 
2.18.0


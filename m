Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08E810CAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 15:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfK1O50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 09:57:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38673 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfK1O5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so4004378lfm.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpr+mYQ+9NhljhKb64xmmktj4amAj+pnq2WBWOuqqds=;
        b=d3kmOdLH1nQ1nKEoDYYtc0T6z2HuyQRGRStUwfE2OY3yRETb5N94S4G2Kpj1PAc9Xn
         pAzCDOtkxI9HSMWxUvxzwM7qJUNFuZH/NZUf0Qlg0JcuFbCamVQsU3TgMVUwyGnhimXn
         oIBPeX0gtsrm4gJDjQK6zKTksO4njOigj+cV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpr+mYQ+9NhljhKb64xmmktj4amAj+pnq2WBWOuqqds=;
        b=TmckzReSxt/aIBxO/k89v/JqTkBPaG/TkymRNyN5Qx0q7NHgaqxI2E7WQ/uWr8FMe+
         NDXPpH9mw27bF+JWSrXt+RGd0DfeWWHfM9IshHNXS6mlsz41rsBP3rXUJY7zPShCP5ED
         /0qozWMWw/CLrImoSchBzH8vdwdvmP6NP9wHpkdC1vPoWFtCP+QLQqmTG0TYepUgZs4q
         zvTROBsquhvLiWq92Z8tCDWKNf1sw5MtHgjC5BHB0DOaIHXImfLUmG11QZHkBrLQWTe7
         jPmlpiX5/jszuaZTK+xttFCUhOYHUc6A4gp7IqVMQHlu6slLVQi4hwlyu3FxcgrhTyiV
         lZig==
X-Gm-Message-State: APjAAAW38SXm8m+2yHTf0ykuFTXIyyh2nF6RSsk0w/RYKYw9CET5STjp
        CVBX6mc7vgYgfaNOt+1afpzSVA==
X-Google-Smtp-Source: APXvYqzBPcdHaviXcZ9S4ZGfso3OF5EGZpWvSwdjKnbpQV7b22GzQm/MJpik7k/V1g3rb+yQCOnAAg==
X-Received: by 2002:a19:f107:: with SMTP id p7mr32135574lfh.91.1574953037520;
        Thu, 28 Nov 2019 06:57:17 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:17 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 10/49] soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
Date:   Thu, 28 Nov 2019 15:55:15 +0100
Message-Id: <20191128145554.1297-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in registering with sysfs when that doesn't actually
allow any interaction with the device or driver (no uevents, no sysfs
files that provide information or allow configuration, no nothing).

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 4b03060d8079..f170926ce4d1 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -474,34 +474,3 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
 
 	return 0;
 }
-
-static struct bus_type qe_ic_subsys = {
-	.name = "qe_ic",
-	.dev_name = "qe_ic",
-};
-
-static struct device device_qe_ic = {
-	.id = 0,
-	.bus = &qe_ic_subsys,
-};
-
-static int __init init_qe_ic_sysfs(void)
-{
-	int rc;
-
-	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
-
-	rc = subsys_system_register(&qe_ic_subsys, NULL);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys class\n");
-		return -ENODEV;
-	}
-	rc = device_register(&device_qe_ic);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys device\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-subsys_initcall(init_qe_ic_sysfs);
-- 
2.23.0


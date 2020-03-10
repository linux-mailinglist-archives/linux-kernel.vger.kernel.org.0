Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90AB17EEA7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 03:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCJCfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 22:35:47 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40351 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCJCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 22:35:46 -0400
Received: by mail-pj1-f66.google.com with SMTP id gv19so771917pjb.5;
        Mon, 09 Mar 2020 19:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weiT/gNMaT98DNcrVoArqN1n8qFeWFcO2aQcNrwiOqg=;
        b=uxXytDB3DRQOxrf6pVlKVlOQH0reGS/RA0mfsP2HFwvi0wllV2YKlIc6k7vHehz7/6
         1gSRXObd3WUwmpYBMiflWSSOTPFZOZZCUH+FjuKa+U+MOv7noMKdyhzJ7cgnqveEIaPG
         ZwZEEjoQnFIR57tphVcc4UE9MLyQXd9qUVxMAFIvEDNZxhoe4atpBb6WTV2MF83yvv6P
         q2kGNu3xBAMQUZZ6Uvn0abfyYWgqJcYOM9L1O8G5J2ntuY/u6b/TP7Ldg9mX8kOBPGla
         Z6lKmLItIFm1rieh7LRe7UUUtOkuw78CLJ0he6t8cSeTDIlxFR91rsQSt/iBxwOagnY+
         qPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=weiT/gNMaT98DNcrVoArqN1n8qFeWFcO2aQcNrwiOqg=;
        b=N8TjHBpJouKWMTnDIxAi38aoWzWwxraZuDuckX4wadhOHGHXx0/JeVGpz5xdrqjrvS
         p4Ffl08wYt19p3jnmiAeoFdKvlXxuYDJOXypsYbUWE8q+G+HAJaQzGlCbCBRC2iq37Wu
         JI/X36aIUSXF8M7w9JFV8ONN2UEtvLpVWIJ48/N/rfOPUAQWSqg44ji5oWy3wG54HTdy
         hKkQ/IBWpogh2PpUj6w+d2TKkDFnQIG/GGZrqoPZOYVlsTnNFfMkoaNk0NmDwvA30+SC
         oYY9nhqcyhkf9UJo80EgYC+Oi9W4/I5Fk9aSDyyoHhRzYhGzbFRXApDVLj2F17+I6crE
         36Kw==
X-Gm-Message-State: ANhLgQ3ofyctJ/qgxSlCCC0vdlpo9wtTj8YnqvxtPymUALgyhQhFT8/2
        pmmcymHxKreK2Id4Z5mAJkM=
X-Google-Smtp-Source: ADFU+vuZFLuZ7dndLbqKaQsp8rEK6RvoNsgepHsiTu02j9X4XFtDo/9FRU6R4aQmSDiH3nLE2/pjvg==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr2487827pjs.107.1583807745548;
        Mon, 09 Mar 2020 19:35:45 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id u11sm816627pjn.2.2020.03.09.19.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 19:35:44 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3] video: fbdev: vesafb: add missed release_region
Date:   Tue, 10 Mar 2020 10:35:36 +0800
Message-Id: <20200310023536.13622-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to free the I/O region in remove and probe
failure.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Revise the commit message.
  - Add an error handler to suit the "goto error" before request_region().
  - Revise the order of operations in remove.
  
 drivers/video/fbdev/vesafb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index a1fe24ea869b..c7bc9ace47d4 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -439,7 +439,7 @@ static int vesafb_probe(struct platform_device *dev)
 		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
 			vesafb_fix.smem_len, vesafb_fix.smem_start);
 		err = -EIO;
-		goto err;
+		goto err_release_region;
 	}
 
 	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
@@ -458,15 +458,17 @@ static int vesafb_probe(struct platform_device *dev)
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENOMEM;
-		goto err;
+		goto err_release_region;
 	}
 	if (register_framebuffer(info)<0) {
 		err = -EINVAL;
 		fb_dealloc_cmap(&info->cmap);
-		goto err;
+		goto err_release_region;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
+err_release_region:
+	release_region(0x3c0, 32);
 err:
 	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
@@ -481,6 +483,7 @@ static int vesafb_remove(struct platform_device *pdev)
 	struct fb_info *info = platform_get_drvdata(pdev);
 
 	unregister_framebuffer(info);
+	release_region(0x3c0, 32);
 	framebuffer_release(info);
 
 	return 0;
-- 
2.25.1


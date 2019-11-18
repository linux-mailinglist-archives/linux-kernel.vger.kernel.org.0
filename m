Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB238100240
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 11:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKRKT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 05:19:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36102 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:19:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so18737936wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 02:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44Rxui9+sXz1jjK4QHC/uAg9YkgdEiOPXXORVOElxkQ=;
        b=NW4cGZP169UPi8mK+boFH8CnPAxrFrE/Kf0XNMLz5ofRJ0UfUzR6Z1G/lBuP+kDH/m
         c8AFbsIGESfK5GxS/9Bnez631gyKv3kMXH1sIjESLTm00hUEv4W+Sl6ns42ukhLjGqRB
         R5OhjzXL2ATLIs/cM/qepbvdKGsGZ6phak7/iwVFd2TFbEqF96xenCtMHuAap6d+7kp0
         0osYdmyXgEq8uoXtEqDzbnen6M61UPtxlRMVKzpmG1s/t2ezCWN7BFfqKNlEF9wNgpbb
         UQ3f/vAgfPpPSyOOjqfOmFYIo3EENE9r+3v+AWpadz8AOmx8ONuWq7HS7ze+ATigYKi9
         QyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44Rxui9+sXz1jjK4QHC/uAg9YkgdEiOPXXORVOElxkQ=;
        b=LBUjFQscYAACVHdAZGReb66wP7el986+8UyQbKb4DYY22ZsB0+DDQXLcmgHcYsbj/O
         kPr1y7lMYf3RB/nhr7+e9qTV78Ll/1FeYUGPo4+3TJTOaRkYihLir2BkJrNqVvuNPcuu
         s2bueXZiCEDLlGWCX2yYG+YnINXBNtAZjU2jBAFLK5Mjcpruaj23k3G2NCO2SsQduodS
         4ioxGJhV7Jf4PlUCHTvUO+c4FFq2WKLJsnUV4Nga4LmNVqk8+H2epv0KDRcCMUa20DEl
         4OGNogJvsBXNSOEiF7Mj9uLUhQty6lttF4vmlJnXfutk21F1Os05C1nK/bBpttgVhaB6
         7lNw==
X-Gm-Message-State: APjAAAU5b5XrE65wT4taCeLsddGlfwRRtlEDy12j50qkAOIVFGEt5VXQ
        bOicdE/vnWzcRIUOwaO3m+3Vnlb7s8OFwP6U
X-Google-Smtp-Source: APXvYqxSLuMF9v670yjg5fac1nejzQaEU47gEcX5oJaOoP4Ba8o81mN1Kl8j2xDRULPbm+kYYR32pA==
X-Received: by 2002:a5d:4ad2:: with SMTP id y18mr13916131wrs.396.1574072392821;
        Mon, 18 Nov 2019 02:19:52 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id t134sm20766740wmt.24.2019.11.18.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:19:52 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>
Subject: [PATCH v3 2/3] firmware: google: Unregister driver_info on failure and exit in gsmi
Date:   Mon, 18 Nov 2019 11:19:30 +0100
Message-Id: <20191118101934.22526-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191118101934.22526-1-patrick.rudolph@9elements.com>
References: <20191118101934.22526-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Heymans <arthur@aheymans.xyz>

Fix a bug where the kernel module couldn't be loaded after unloading,
as the platform driver wasn't released on exit.

Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
-v2:
	Add missing s-o-b.
-v3:
	No changes.
---
 drivers/firmware/google/gsmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index edaa4e5d84ad..974c769b75cf 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -1016,6 +1016,9 @@ static __init int gsmi_init(void)
 	dma_pool_destroy(gsmi_dev.dma_pool);
 	platform_device_unregister(gsmi_dev.pdev);
 	pr_info("gsmi: failed to load: %d\n", ret);
+#ifdef CONFIG_PM
+	platform_driver_unregister(&gsmi_driver_info);
+#endif
 	return ret;
 }
 
@@ -1037,6 +1040,9 @@ static void __exit gsmi_exit(void)
 	gsmi_buf_free(gsmi_dev.name_buf);
 	dma_pool_destroy(gsmi_dev.dma_pool);
 	platform_device_unregister(gsmi_dev.pdev);
+#ifdef CONFIG_PM
+	platform_driver_unregister(&gsmi_driver_info);
+#endif
 }
 
 module_init(gsmi_init);
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E14727BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 13:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfEWLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 07:36:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45726 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbfEWLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id r76so5097607lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ebGkDFqJT6qukVHBMr/0MpW6/cJt0FRWIZVTQsZX7U=;
        b=FKVpadiYCdmYWjUaT0nN1Z9y14mjPw7AZROwtY64MTjbmUps6LPfdAeiu1OFjIPoTu
         CRovGXgevKahtiSyQrTJgX4jYUTm42w0hVpjUpyqI/7TShAmfKj9VRDJmbLKx2fRJPXC
         B+zVB0NFOvCCABJAF1+75+D4cBAuKgKnY0l3ufUBmvhffCp1HTTNV9U6aPTrm7ryOjgH
         hx1JTqfBsy5Sf0Y+qdAYn/2zafkq5K0lxj7Y1B2pgaGAjDQh39Oyr0xvOQegDjOQbITm
         DYSFqApBVB94b/vdwFGBO/c77G1zEAOPWzyttv/Orjt7m3puG2tWoHV/zu02EhCvsHOU
         1Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ebGkDFqJT6qukVHBMr/0MpW6/cJt0FRWIZVTQsZX7U=;
        b=OM3lNWJFLQ3svmODfScY7auxIs8HQguskah5U72h25QIiSb8WGi/ukbiNf1zJz8LZB
         slV4veOtj1wRNnKVRM61GcsvLuJ0+s0pbngMzW4UEKaSqw5hWdsehYU5o3RjiFiyj7W5
         HdtAL7Yglq4RnU0BtDkDpgw6mXAXizdF8EP+YHInU2afMlC7tmJYdBdOoAjo/gm8hjTd
         sI/mGQLGZWO8so4LJdf/DuUJpt+To5mksCO5VsOe36sI4nh/Xk6KKq5740pZR9tws7ws
         YxhFIAM3IBKVNo3H787rVuXc5/I6+4KUUN82hzGww1oetFgg4bELP2+O4lX0ru9Z6Ty3
         TF3g==
X-Gm-Message-State: APjAAAWWDeYG26WZgYAWWYKOCym9Ue40b6nkqyTMZqFm8Em9pZdWPR67
        DDmNytIPU5w0TTkhFy4GxYAJcchXddVxUg==
X-Google-Smtp-Source: APXvYqwB1+MUJG0lX8okZaHsaMEL5d2/5QscUnMQWuq8SrgfvxIAc7h4xSEPoPdjkeI2mxxBuMF2Mg==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr2119559ljg.28.1558611394616;
        Thu, 23 May 2019 04:36:34 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:34 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: kpc2000: fix alignment issues in cell_probe.c
Date:   Thu, 23 May 2019 13:36:09 +0200
Message-Id: <20190523113613.28342-5-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523113613.28342-1-simon@nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings "Alignment should match open parenthesis"
and "Lines should not end with a '('".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 34 +++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index c4015c62686f..b621adb712ff 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -128,15 +128,13 @@ static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 
 	cell.resources = resources;
 
-	return mfd_add_devices(
-		PCARD_TO_DEV(pcard),    // parent
-		pcard->card_num * 100,  // id
-		&cell,                  // struct mfd_cell *
-		1,                      // ndevs
-		&pcard->regs_base_resource,
-		0,                      // irq_base
-		NULL                    // struct irq_domain *
-	);
+	return mfd_add_devices(PCARD_TO_DEV(pcard),    // parent
+			       pcard->card_num * 100,  // id
+			       &cell,                  // struct mfd_cell *
+			       1,                      // ndevs
+			       &pcard->regs_base_resource,
+			       0,                      // irq_base
+			       NULL);                  // struct irq_domain *
 }
 
 
@@ -374,15 +372,13 @@ static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_re
 
 	cell.resources = resources;
 
-	return mfd_add_devices(
-		PCARD_TO_DEV(pcard),    // parent
-		pcard->card_num * 100,  // id
-		&cell,                  // struct mfd_cell *
-		1,                      // ndevs
-		&pcard->dma_base_resource,
-		0,                      // irq_base
-		NULL                    // struct irq_domain *
-	);
+	return mfd_add_devices(PCARD_TO_DEV(pcard),    // parent
+			       pcard->card_num * 100,  // id
+			       &cell,                  // struct mfd_cell *
+			       1,                      // ndevs
+			       &pcard->dma_base_resource,
+			       0,                      // irq_base
+			       NULL);                  // struct irq_domain *
 }
 
 static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
@@ -463,7 +459,7 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 			switch (cte.type) {
 			case KP_CORE_ID_I2C:
 				err = probe_core_basic(core_num, pcard,
-				KP_DRIVER_NAME_I2C, cte);
+						       KP_DRIVER_NAME_I2C, cte);
 				break;
 
 			case KP_CORE_ID_SPI:
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DDB100BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 19:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKRSwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 13:52:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34331 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfKRSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:52:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so10822304pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 10:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GvV8oaMdUFkbGSdHfV8pM7qcL93fKWfHHP3kuX4k8Dc=;
        b=Xy3llRtkMWbJAqF37pj7ZbvTW5JPx0TK6JCyO/kUFREaNtf9yL7z+DnF1CFd87jF+A
         Ix8V5NDls+qIdu5roV8yAcJSQKjAaYD2orEGxYLdJ5XkLG+/f1Qe/4qkPSksksyUc+jv
         FiDl5EmYCJpfFyUBYj1zYpfSGgtVruXJdlPc07cULx88xll8/infS8udX7sIQQyWZwon
         cOXhi6jbP58g//iBmc75C1zYKKTFlDop1xk5ieCBcU4tIq5hGdoCsEZAiyU9w7LY0BDY
         rvRVgOUOtH9buQ55eygh+a107ECd+Zkg6twvPeXdahlRIV88/KAzF9h9kvJ2HI0ZibkJ
         i2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GvV8oaMdUFkbGSdHfV8pM7qcL93fKWfHHP3kuX4k8Dc=;
        b=LLCREHK9HEQXtwhaXC1jzEmsCAVGE5FflxA17YNewgn2MQfMom8awvVBtnD/nTARUI
         yI+YH3DRZpfMeMAMVKzxUA5uE1L2QajsU7hxbMrq4lsid1Dz2sGt4carBUfdTxai6kO5
         ICJKGHthiDfNZNJEzHBCNxPCP75r0kWc6/0Q48+DG4d2MAvDQYqt1kKxRgc7j8Wcj2yJ
         ZTGxKQhzvJdzC1FKsj/RNLiROnvQ/1s+8Gtz1Gt8O9j0mcXnTNBkkcA5ew7z6QbNS1nT
         qNtLoJhmcL9OpqcGGQ3M6nSk/fwO8HwWFl6FZC16dkgjnFo/N83AAa5HFaYa45pOYvIg
         ySCQ==
X-Gm-Message-State: APjAAAW+fJsaXMRPqINIFFmmRlSQ2GQhUzS2ZHLS0Z6/3uWEONBC3znb
        wzCTL2l9SlX8w6KXNXlhBpVN7Q==
X-Google-Smtp-Source: APXvYqzjvR2ItnL7bBxTT1tfG6CN4pgDLv1y0/MiV10l9FWIy7QUTqs14NvQiKFrOv5HqoX8kK0bqg==
X-Received: by 2002:a63:201b:: with SMTP id g27mr866907pgg.56.1574103130166;
        Mon, 18 Nov 2019 10:52:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r10sm19878910pgn.68.2019.11.18.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 10:52:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] coresight: funnel: Fix missing spin_lock_init()
Date:   Mon, 18 Nov 2019 11:52:06 -0700
Message-Id: <20191118185207.30441-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118185207.30441-1-mathieu.poirier@linaro.org>
References: <20191118185207.30441-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The driver allocates the spinlock but not initialize it.
Use spin_lock_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Tested-by: Yabin Cui <yabinc@google.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-funnel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b605889b507a..900690a9f7f0 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -253,6 +253,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	}
 	dev->platform_data = pdata;
 
+	spin_lock_init(&drvdata->spinlock);
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
 	desc.ops = &funnel_cs_ops;
-- 
2.17.1


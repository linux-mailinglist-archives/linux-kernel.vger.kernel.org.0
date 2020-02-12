Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCC515B1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 21:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgBLUWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 15:22:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46805 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLUWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:22:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so3236353otb.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmzww6qF1lYp+hV6WRAA52aNnE6EhgFR79VxQVFdEbg=;
        b=Adc/S5/i76Ge5ACV1BmK0s/4sDZr6B7HhvqtnF9ExDtUzJk2VJUyPmlKv3BRAUjNX8
         qa5Mj9wDJ3+8JX9A2JhlK2X1jxFlRZXyaaQh7xzRqf5vq7vwZjI3pD15sHb8iNpp72Uw
         jC3N4Gp7fZvSBc95gV2ynJO24Rcc6aSWpGy7b67mziqU7e5/XNA7/+eh2FnqK3u5873F
         OOs9WfFm4M747HwtlD4T4quNa6t+W5iBQmq09LScHjklULKUQYwEb/DKQGYCsG3+uq4Y
         9sKVkAti5z3eqzJ3l1ONUth0nBoMyfjl2jrmKc+g5MX/tHlu/yGIXrBm0rfKmT/mVfik
         fBjw==
X-Gm-Message-State: APjAAAVirEjSATEufcQlMk3+iQjmu51aADfIkADhrB78xdCkz4+volHw
        k6+7ZLjRWIGndXO/pR6V4HJnogw=
X-Google-Smtp-Source: APXvYqyU0o1Pze8wveuZDA3u/iHypwszUsk+ei4KqiNpwRNL9Jlei+NqysV33pWakfS6MC4rBmeMAQ==
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr10865483otq.190.1581538958277;
        Wed, 12 Feb 2020 12:22:38 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o1sm14852otl.49.2020.02.12.12.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 12:22:37 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] drm/panfrost: Don't try to map on error faults
Date:   Wed, 12 Feb 2020 14:22:36 -0600
Message-Id: <20200212202236.13095-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomeu Vizoso <tomeu.vizoso@collabora.com>

If the exception type isn't a translation fault, don't try to map and
instead go straight to a terminal fault.

Otherwise, we can get flooded by kernel warnings and further faults.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
I rewrote this some simplifying the code and somewhat following Steven's 
suggested. Still not using defines though. No defines here was good 
enough before IMO.

Only compile tested.

 drivers/gpu/drm/panfrost/panfrost_mmu.c | 44 +++++++++++--------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 763cfca886a7..4f2836bd9215 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -596,33 +596,27 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
 		source_id = (fault_status >> 16);
 
 		/* Page fault only */
-		if ((status & mask) == BIT(i)) {
-			WARN_ON(exception_type < 0xC1 || exception_type > 0xC4);
-
+		ret = -1;
+		if ((status & mask) == BIT(i) && (exception_type & 0xF8) == 0xC0)
 			ret = panfrost_mmu_map_fault_addr(pfdev, i, addr);
-			if (!ret) {
-				mmu_write(pfdev, MMU_INT_CLEAR, BIT(i));
-				status &= ~mask;
-				continue;
-			}
-		}
 
-		/* terminal fault, print info about the fault */
-		dev_err(pfdev->dev,
-			"Unhandled Page fault in AS%d at VA 0x%016llX\n"
-			"Reason: %s\n"
-			"raw fault status: 0x%X\n"
-			"decoded fault status: %s\n"
-			"exception type 0x%X: %s\n"
-			"access type 0x%X: %s\n"
-			"source id 0x%X\n",
-			i, addr,
-			"TODO",
-			fault_status,
-			(fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
-			exception_type, panfrost_exception_name(pfdev, exception_type),
-			access_type, access_type_name(pfdev, fault_status),
-			source_id);
+		if (ret)
+			/* terminal fault, print info about the fault */
+			dev_err(pfdev->dev,
+				"Unhandled Page fault in AS%d at VA 0x%016llX\n"
+				"Reason: %s\n"
+				"raw fault status: 0x%X\n"
+				"decoded fault status: %s\n"
+				"exception type 0x%X: %s\n"
+				"access type 0x%X: %s\n"
+				"source id 0x%X\n",
+				i, addr,
+				"TODO",
+				fault_status,
+				(fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
+				exception_type, panfrost_exception_name(pfdev, exception_type),
+				access_type, access_type_name(pfdev, fault_status),
+				source_id);
 
 		mmu_write(pfdev, MMU_INT_CLEAR, mask);
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9474D187978
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 07:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgCQGP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 02:15:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35545 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQGP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:15:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so3457708wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 23:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I+q7+Jbaq1SKd35pnpj+Zyxbo7Ea5dhgdfNOx7vAwoo=;
        b=ZlPyXdxvvPTjYi7zINWE9eUXHfXmsARoIRffaNWXDE3NnwL2jFmlhRTvvgYqCuhVng
         yiGsBoBhsBaRNjea3XYB1RnftWbqpufu1AL3cqUqdnmiztRFYAXen+eOGr176MzYZAnG
         LNeygZU83jC6ydw+Om0WGB3+gMZH2kGZfqMEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I+q7+Jbaq1SKd35pnpj+Zyxbo7Ea5dhgdfNOx7vAwoo=;
        b=fsGTHEGcMhKmxXGnG4XV1pXkav5uq1rW93AuvWFHfgGT+xbEP2AXu0X4Npf1k/Mm+t
         2qMpDkE/cDmZZUZBzsnfQ41UMGXhYB3R6zdS2W/jqx9kgPF6iva6ecUOKdg6CEGyfnR3
         AtCA/QSRg8fc7nnGm/YbgJBuglcEGin3oMgM7MZywSAfdluSZCtL5QXpZR4R4X2QBpak
         a72oZLaAIcPf+c3ZVcNOkxqB1G/lhOACblBAnyH2Z96F2OZSKg9abxb/ZxBI3tQkUJq+
         C6MjUUbg62SpcOfFUIlNBw2NVjuOym+aZlpqhjk5LBKHvHx9mDYr3Uf/azdBOKjGCywf
         D9IQ==
X-Gm-Message-State: ANhLgQ0qBA0fmTUnJ9gTG3H0pnRuBIBCcytKNmNnP7+zYXb91x9phd8s
        ffxIQIG19ko5kZ6IbblTMzBSdA==
X-Google-Smtp-Source: ADFU+vthGfbwy0mIHC4QwmBqoU7mDAhGf6AkLOvvv8M41Cnd7TlLgwjG9W9KsdWbYXVHZ5BW796CjA==
X-Received: by 2002:a05:6000:1184:: with SMTP id g4mr3911842wrx.396.1584425754526;
        Mon, 16 Mar 2020 23:15:54 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o5sm2658096wmb.8.2020.03.16.23.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 23:15:53 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/2] async_tx: return error instead of BUG_ON
Date:   Tue, 17 Mar 2020 11:45:21 +0530
Message-Id: <20200317061522.12685-2-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317061522.12685-1-rayagonda.kokatanur@broadcom.com>
References: <20200317061522.12685-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error upon failure instead of using BUG_ON().
BUG_ON() will crash the kernel.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 crypto/async_tx/async_raid6_recov.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/crypto/async_tx/async_raid6_recov.c b/crypto/async_tx/async_raid6_recov.c
index f249142ceac4..33f2a8f8c9f4 100644
--- a/crypto/async_tx/async_raid6_recov.c
+++ b/crypto/async_tx/async_raid6_recov.c
@@ -205,7 +205,9 @@ __2data_recov_5(int disks, size_t bytes, int faila, int failb,
 		good = i;
 		good_srcs++;
 	}
-	BUG_ON(good_srcs > 1);
+
+	if (good_srcs > 1)
+		return NULL;
 
 	p = blocks[disks-2];
 	q = blocks[disks-1];
@@ -339,7 +341,9 @@ async_raid6_2data_recov(int disks, size_t bytes, int faila, int failb,
 	void *scribble = submit->scribble;
 	int non_zero_srcs, i;
 
-	BUG_ON(faila == failb);
+	if (faila == failb)
+		return NULL;
+
 	if (failb < faila)
 		swap(faila, failb);
 
@@ -455,7 +459,8 @@ async_raid6_datap_recov(int disks, size_t bytes, int faila,
 				break;
 		}
 	}
-	BUG_ON(good_srcs == 0);
+	if (good_srcs == 0)
+		return NULL;
 
 	p = blocks[disks-2];
 	q = blocks[disks-1];
-- 
2.17.1


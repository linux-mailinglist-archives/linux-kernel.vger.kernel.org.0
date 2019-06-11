Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7523C163
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 05:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390885AbfFKC77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 22:59:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39618 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390717AbfFKC77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 22:59:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so6078246pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 19:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3RvF588gW/eOiodTO3ulTpUto6/HGBoQ0uLzQhVKiAY=;
        b=UotuSMSg82fg5NGnIk39gGKWbzlAwata7Bb06GRioyYSpU+nYnazHpAMkxgj8rtdZ0
         Pq0UM+60by3JiKK2U7gNQm0lY1yiV0wJ2D9F1D4nHak8aas5AgRPPWkdTExlqpYdGPVI
         VmmGLMdeIuMNbQ7WeQiXPPhh7RdrjnpxXpNBunBf6yNCVZw01cZFTWcCBjeakyRjMSxn
         PKycyTachHikK1CAb28KLBjxQL89DbUpfZmlYnXvkFuyDulipJjrChEV/7hYn5UOYLk9
         pVU5bHcE3iT/82GcWhjaTxfFiYMPXEaQisMdf3o31XIXlyuYijhrxD6nhSA+nUZiUXXl
         UuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3RvF588gW/eOiodTO3ulTpUto6/HGBoQ0uLzQhVKiAY=;
        b=I5XbGXUg+i9svDfGEdDY7K822GWCbsn3LC24bJD7vVeckXV666yKtBqlpau2KJb0aO
         sWBUl0D8QIPJC5xmbYXEgPthYRtiSjHD/J9t+arSRSdOpziYNSzI9kHR8CGcp1eNQreG
         RLojHInBC+aYu3goagF7kdwBaX3Bz8xRaZZhkong+n7hWemw/9lsY2yMyt5ikFAhgsxU
         1iZb28a47W4dSxoHtXRJ8EsvKpShQSwHp9ItDyJm0UHzLLpeh1xHhAB0N04MAIYhmjam
         tL+vtD9IspeYfnZWElrPPQdUq9a61zXRbbMWzmVZagzLQ1gu1bh2+7x5Dv1mtVMkJA2Y
         N2Zg==
X-Gm-Message-State: APjAAAU5OfWqpSGebYEIOj5F2Xtn2QIA+j+PpWhI/4L/lZiAC3SFQ4k2
        iDce0Su4zFD3QNl4bStPYuA=
X-Google-Smtp-Source: APXvYqwAiYXXj0zgcOalF+oKh2682wSbp41Bmwzooikq9yRU4xC5SaJCr5gRZpvR/852/XAg8pbdEA==
X-Received: by 2002:a17:90a:32ed:: with SMTP id l100mr24199013pjb.11.1560221998813;
        Mon, 10 Jun 2019 19:59:58 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id 133sm10861906pfa.92.2019.06.10.19.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 19:59:58 -0700 (PDT)
Date:   Tue, 11 Jun 2019 08:29:53 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: fix issue Comparison to NULL
Message-ID: <20190611025953.GA26041@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issues reported by checkpatch

CHECK: Comparison to NULL could be written "rtw_proc"
CHECK: Comparison to NULL could be written "!rtw_proc"
CHECK: Comparison to NULL could be written "!rtw_proc"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/rtw_proc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/rtw_proc.c b/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
index d8e7ad1..d6862e8 100644
--- a/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
+++ b/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
@@ -122,14 +122,14 @@ int rtw_drv_proc_init(void)
 	ssize_t i;
 	struct proc_dir_entry *entry = NULL;
 
-	if (rtw_proc != NULL) {
+	if (rtw_proc) {
 		rtw_warn_on(1);
 		goto exit;
 	}
 
 	rtw_proc = rtw_proc_create_dir(RTW_PROC_NAME, get_proc_net, NULL);
 
-	if (rtw_proc == NULL) {
+	if (!rtw_proc) {
 		rtw_warn_on(1);
 		goto exit;
 	}
@@ -152,7 +152,7 @@ void rtw_drv_proc_deinit(void)
 {
 	int i;
 
-	if (rtw_proc == NULL)
+	if (!rtw_proc)
 		return;
 
 	for (i = 0; i < drv_proc_hdls_num; i++)
@@ -637,18 +637,18 @@ static struct proc_dir_entry *rtw_odm_proc_init(struct net_device *dev)
 	struct adapter	*adapter = rtw_netdev_priv(dev);
 	ssize_t i;
 
-	if (adapter->dir_dev == NULL) {
+	if (!adapter->dir_dev) {
 		rtw_warn_on(1);
 		goto exit;
 	}
 
-	if (adapter->dir_odm != NULL) {
+	if (adapter->dir_odm) {
 		rtw_warn_on(1);
 		goto exit;
 	}
 
 	dir_odm = rtw_proc_create_dir("odm", adapter->dir_dev, dev);
-	if (dir_odm == NULL) {
+	if (!dir_odm) {
 		rtw_warn_on(1);
 		goto exit;
 	}
@@ -674,7 +674,7 @@ static void rtw_odm_proc_deinit(struct adapter	*adapter)
 
 	dir_odm = adapter->dir_odm;
 
-	if (dir_odm == NULL) {
+	if (!dir_odm) {
 		rtw_warn_on(1);
 		return;
 	}
@@ -695,18 +695,18 @@ struct proc_dir_entry *rtw_adapter_proc_init(struct net_device *dev)
 	struct adapter *adapter = rtw_netdev_priv(dev);
 	ssize_t i;
 
-	if (drv_proc == NULL) {
+	if (!drv_proc) {
 		rtw_warn_on(1);
 		goto exit;
 	}
 
-	if (adapter->dir_dev != NULL) {
+	if (adapter->dir_dev) {
 		rtw_warn_on(1);
 		goto exit;
 	}
 
 	dir_dev = rtw_proc_create_dir(dev->name, drv_proc, dev);
-	if (dir_dev == NULL) {
+	if (!dir_dev) {
 		rtw_warn_on(1);
 		goto exit;
 	}
@@ -736,7 +736,7 @@ void rtw_adapter_proc_deinit(struct net_device *dev)
 
 	dir_dev = adapter->dir_dev;
 
-	if (dir_dev == NULL) {
+	if (!dir_dev) {
 		rtw_warn_on(1);
 		return;
 	}
@@ -760,7 +760,7 @@ void rtw_adapter_proc_replace(struct net_device *dev)
 
 	dir_dev = adapter->dir_dev;
 
-	if (dir_dev == NULL) {
+	if (!dir_dev) {
 		rtw_warn_on(1);
 		return;
 	}
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1281E10703
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 12:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEAKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 06:36:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40865 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEAKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 06:36:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so4474027pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uepw+mfuloh+jLBG3kb0aMinc0ROEt2j9Im/Cxk8ZGs=;
        b=dhtcXE4Z7Tclim9+rYNg6EgB1hHMUgXE00H3zIe7f1At8ET0Um0TQ8lxymeI+DKd9F
         NTr8QVV7kvcVtnxXK08dtVEQAC5pzEKTQJOv1YyxC5cKkj2SXTkEUxg6oureGlT9MdSW
         vkhzLO6W0lJby9vVv6c7/GKpB+U0wspH1VRGsMAKlHFdcG/zsMkn6lYFkJE+wkpG/Beb
         BK1w918Memkj9K4fNEU7JB/W1qVvv0L6wHA7su16cVyEuoyZtE5dNNXZNIrfYq1FtsU/
         Wwm30/EXDm1YyXx0x1PokydFNSGk+y6+jvcUbhtP1H/jqPw9U24mvEPt62/MHDPg5BtV
         T2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uepw+mfuloh+jLBG3kb0aMinc0ROEt2j9Im/Cxk8ZGs=;
        b=CUZD2uO+kUs1im3twz+xH1PqUc+SEksLNl/aj8Pxt9tpgwMRBF7G2gFxOwKXB8uvDQ
         HBUHmK75tEnT/EFK4OBqFISZHzL9xcyX7nlfnamZzZ+mBMa5gM01RmpCldp5fbCcisBe
         ZCzzHjnbWfD141heksf6u+c4vatTNDRkXMKMTLrkj0JPcizLEeIYRLNHBVl2rtZJ54LH
         3/Cd/nIEbhlZybcblHMIl5zs/T39FL9vRTbTvZ0jYbkYSxqoVH9dAlhjxdEWRUulLjBg
         S9vlKr+R44qudyvp8lOBsbYrQiHhvv18V18Mo20vB/95azQf00sQYysFlSyf1DEdPWY1
         5OcA==
X-Gm-Message-State: APjAAAWwj+CwQEbJ7IojaMXIfFtCxMtzyskUmOEam+o4d3JC+9XGTYCE
        kCVMfm49rBXG3kmYoXfjp/0Qp8DhgcU=
X-Google-Smtp-Source: APXvYqxBQq3NVY3DfQ3GqA7F81Kl3BhX3fpO/89q/Erx07WaIF59Pt4Tt7xDXd/ZOc4a5+zfJ4jMAw==
X-Received: by 2002:a63:165f:: with SMTP id 31mr73874636pgw.321.1556706966862;
        Wed, 01 May 2019 03:36:06 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.94])
        by smtp.gmail.com with ESMTPSA id 13sm56012563pfi.172.2019.05.01.03.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 03:36:06 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr, Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core: Use !x in place of NULL comparison.
Date:   Wed,  1 May 2019 16:05:47 +0530
Message-Id: <20190501103547.10095-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid NULL comparison, compare using boolean operator.

Issue found using coccinelle.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_io.c      | 2 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index d341069097e2..a92bc19b196a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -156,7 +156,7 @@ int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct adapt
 	struct io_priv *piopriv = &padapter->iopriv;
 	struct intf_hdl *pintf = &piopriv->intf;
 
-	if (set_intf_ops == NULL)
+	if (!set_intf_ops)
 		return _FAIL;
 
 	piopriv->padapter = padapter;
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 67b8840ee2fd..bdc52d8d5625 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -316,7 +316,7 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	struct	sta_priv *pstapriv = &padapter->stapriv;
 	struct hw_xmit *phwxmit;
 
-	if (psta == NULL)
+	if (!psta)
 		goto exit;
 
 
@@ -520,7 +520,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	u8 *addr;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	if (hwaddr == NULL)
+	if (!hwaddr)
 		return NULL;
 
 	if (IS_MCAST(hwaddr))
@@ -565,7 +565,7 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 	psta = rtw_alloc_stainfo(pstapriv, bcast_addr);
 
-	if (psta == NULL) {
+	if (!psta) {
 		res = _FAIL;
 		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("rtw_alloc_stainfo fail"));
 		goto exit;
-- 
2.17.1


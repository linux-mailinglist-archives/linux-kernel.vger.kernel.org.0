Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6CF322B7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfFBI2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 04:28:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37220 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfFBI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:28:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id h1so9219556wro.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WnNi9KkC4U+mIhXiCVi96pOXS/XmFU28bKFjrsJQpfY=;
        b=QSOIKTSGa2YueIbuOgCUlbVf4/H4ir6PyaElNxFbkoz+rmtLL4YyRmskp/q+r/ScPR
         mEUGT8rhc7UvlMCP+pQzH9Tj3XOK5qxHibwDGdmYFGZ676C1tLe9mkLFnzCfkR3Rggei
         3GmyH67W4Aa6J5jdNr/IkzXJ4Chdt39vUP4P7fBvkXowwC2h/GUYpiZjBnW3tz2D9xjH
         eEUHxymjFKxekx9IBq9J3a+NLbynIT782F044lNF5p78C6xp6jH8tqCn1fcFuy7SjKLp
         zHaImxaigsJ3MkkB0sdkunuK9bb3sGFuQVEl6plBZBIUtpy7NVexFKYxZwoEfcc3RAk2
         ZerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WnNi9KkC4U+mIhXiCVi96pOXS/XmFU28bKFjrsJQpfY=;
        b=FpD1waO6eluSSmfsnGcS+vX4MgAQkzO0cz+HEJ+m/N5I/huqpbd8t3zfUp8vQqS8KA
         rG03c084gebixYxORghUNR5S5GIdMoCqX33ku317qWBHLrf4f1OChsThsin3wLj97Cpk
         UK6Qm7Zg4xxLl1jWwK6PS45rEiIeiiLA72k2Cc/0tFfrMC8laYBwe6sxWgpKTvRA3O/u
         gQPx88uOcYC6JEWZWREUmo2AlFbvtl9uVLf1gH4mMYOW9wX7AT10y3h6max6fUaih1jR
         +oJf7GSL4pOGDK/imspDKRyNOqOvokGrChbhydcLJ1s8g2b0U6Ws230nh0l4SK9JSJGL
         J6Tg==
X-Gm-Message-State: APjAAAU3c5QxqImB28mSbgKwlh//hH8jB5YvI8/aYamqgUy1U7brC7p1
        nHGYNLgFG+9kIqLTIQJeOvA=
X-Google-Smtp-Source: APXvYqwtRn6icomP8dU6EUlNiNqfA6oW0HYJpH6eAFdqakg1ERF0j3ZrKujTsTiiS6+vj957Pw8Yhw==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr12532929wrt.84.1559464098333;
        Sun, 02 Jun 2019 01:28:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id 32sm34252041wra.35.2019.06.02.01.28.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:28:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove ODM_PhyStatusQuery() wrapper
Date:   Sun,  2 Jun 2019 10:28:00 +0200
Message-Id: <20190602082800.5846-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_PhyStatusQuery() is just a wrapper around
ODM_PhyStatusQuery_92CSeries(). Rename ODM_PhyStatusQuery_92CSeries()
to ODM_PhyStatusQuery() and remove the wrapper.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 149b0009ad66..d5a9ac51e907 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -387,10 +387,9 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 }
 
 /*  Endianness before calling this API */
-static void ODM_PhyStatusQuery_92CSeries(struct odm_dm_struct *dm_odm,
-					 struct odm_phy_status_info *pPhyInfo,
-					 u8 *pPhyStatus,
-					 struct odm_per_pkt_info *pPktinfo)
+void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
+			struct odm_phy_status_info *pPhyInfo,
+			u8 *pPhyStatus, struct odm_per_pkt_info *pPktinfo)
 {
 	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus,
 					 pPktinfo);
@@ -398,12 +397,4 @@ static void ODM_PhyStatusQuery_92CSeries(struct odm_dm_struct *dm_odm,
 		;/*  Select the packets to do RSSI checking for antenna switching. */
 	else
 		odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
-
-}
-
-void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
-			struct odm_phy_status_info *pPhyInfo,
-			u8 *pPhyStatus, struct odm_per_pkt_info *pPktinfo)
-{
-	ODM_PhyStatusQuery_92CSeries(dm_odm, pPhyInfo, pPhyStatus, pPktinfo);
 }
-- 
2.21.0


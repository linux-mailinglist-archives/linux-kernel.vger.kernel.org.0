Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07F513BD9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfEDStQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:49:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47063 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfEDStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:49:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id t187so241045pgb.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oUqAe72QoFoLb3ZFBY2MB1LTNHUJ0UJVx/ZXpwCh0Kc=;
        b=S/1rebLcVLsm6jgThI/3SA2aT8b8uRmEXUP74DdtJhF5ke4XFsDwjmoiMZpM+3Ap+K
         ak5l0Eq/yvPwraY+DWmS4wicDgGNAOBGcFxmYjhyakH0edcjvs9esUnYPoUvxdO+ix4h
         8I3S0QPlFoHrq7ajLgpm+5jJyQatHc3qoMiC6JNq9FWOVEzW7WRKkeDJ+aBNBI7mi0B1
         0iNZmAHOZJf9kHRWK2ZeDpMFYfN1MaRZRjlGV89C9MhvwQvLL/FEFMYY1zeHUFxmTkpd
         ZXSrpfYVNvbszkx/NCqHWtQ6lI4QwVODRULAIi6qW2eaJdbm6NxBPvn3WZ3YPiqxHR9i
         spRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oUqAe72QoFoLb3ZFBY2MB1LTNHUJ0UJVx/ZXpwCh0Kc=;
        b=KkluNdJASVp/I7If1GYpzctE9FxVCXPpGyME4rqUa9oYrceLNY9/TjnwQEuselnI7c
         dUApZ2QQ8B8iCBBVS0QbxeqzbyS3x/gAp5DHzrwvlNei6Vu5XuWSYiL8m+/wNlUr0DOM
         Ln0mLqdsSHAxFzgte1nQY6s+3RGgNcJ5Fy6pGHHxFdx33RM+nW860geJei1UJMMsBlHt
         7Cw/If5vHK7RakI6CA6rf5tm38eEy0LIGl3VCjI8xpWGqCzBdrF0wCt5Q1lCtLSd9fht
         7VPzhHiPFwgdwV2Zwx3+JmvTgzrUiQz1TurmUoVrv/tDG84V+P4YCbqTDGX14AWtcj5c
         VPrg==
X-Gm-Message-State: APjAAAWYjjFcdmPqLiq/p7CKcbeKpqsKA3XZPqIno30B7sOF45vkf1wh
        CJs4KtPL3GLz4SDfhBgI9TI=
X-Google-Smtp-Source: APXvYqyzNhXPSjIJ0SoSgg0XlC2p+BRnUwNDZK+aol5MOFifF93UVqzpp8D4mSmKyb+K7n7sCM4d+Q==
X-Received: by 2002:a65:5bc3:: with SMTP id o3mr21003477pgr.40.1556995755185;
        Sat, 04 May 2019 11:49:15 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id a17sm6900716pff.82.2019.05.04.11.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:49:14 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH 6/7] staging: rtl8723bs: core: Fix variable constant comparisons.
Date:   Sun,  5 May 2019 00:18:56 +0530
Message-Id: <20190504184856.26116-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap the terms of comparisons whenever the constant comes first to get
rid of checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 6f0205c9504b..2a8ae5fd1bc5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1276,7 +1276,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 			status = _STATS_FAILURE_;
 	}
 
-	if (_STATS_SUCCESSFUL_ != status)
+	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
 	/*  check if the supported rate is ok */
@@ -1372,7 +1372,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		wpa_ie_len = 0;
 	}
 
-	if (_STATS_SUCCESSFUL_ != status)
+	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
-- 
2.17.1


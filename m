Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1A158420
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 21:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBJUJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 15:09:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36409 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJUJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:09:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so657761wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 12:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKboNi//DgTEz5deRYoAuburODisq7rqrYp491IRSic=;
        b=M2/a83Nm4BdBUv9gXQ/mBPZMXXPBjlTQ+Of0m9y1Zsokt99NGzfHs9u8XYqi6MfyOe
         h28q90RGkIjP5glo6hbfrQe2k57+voxZZAHegwY3sN786x/H7mdgHIpDMp0/iFZaLPsS
         WbUiG6WUI7q9ndTBaj3vqBwU0gta6SCa+/OP0ZKiVgwJufZXdcy7j4qVjhao+7zWpBru
         FfHig8sNpO7befw8M5UjR8tfdYhNkd4A5gO9qApA0A1GQCKZcXSFuhLd622nae8EOo/J
         lKqgkG6KZWgIkRge3HJYTceFH7HKHap8isl6Zr95ubnfLSk4bsSlQXt+LNfqywtRomtF
         ZoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKboNi//DgTEz5deRYoAuburODisq7rqrYp491IRSic=;
        b=cd3w6vZ6vZDFKnUmWW6PWEA/jVtYCd/yLX7rQy91oO61ppIa0Fgi1dQfj4KGLHb6fv
         GOiW0o+ULKA4K5GqhxSffAMkJ0v6vRnWZ0S0TxBDvjZKysGZkP3gVS1z/CSygKmQM3GZ
         QrV/ilYTa22qP1+VFb/1EwsqL8a934Obl9XPuBHhkAmmfq1YMd2oA0FoZX7Ii3uXjwtQ
         WhqVIhrK0GcMs3jYnkRGu1d0YS7mnApwgR+teCMPCOK4NkE4N9X7fnG2Uaz1yd4uq3QX
         YP7RV5jXH9xD/RqoHaWQ9YQKU0mtVYcvF1Abvawx+pDnh4aqNuBSF6fL2oQni0kyzCyD
         SVSw==
X-Gm-Message-State: APjAAAX3xP6ZjYTZr9B4gK9KCCLxuq5umpM9QHP8E4dwyveAe49y+iCo
        soSIicmFo7aq7aNmvEwxoyA=
X-Google-Smtp-Source: APXvYqxcQjd5wkMyTqNHabVM+z8hjry3oeYMmwlpO1fz7/AEmC8sk+oRxeZyAaE+u078UHf+e5ERGQ==
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr708835wmd.156.1581365364842;
        Mon, 10 Feb 2020 12:09:24 -0800 (PST)
Received: from localhost.localdomain (ipservice-092-219-207-036.092.219.pools.vodafone-ip.de. [92.219.207.36])
        by smtp.gmail.com with ESMTPSA id s139sm518577wme.35.2020.02.10.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 12:09:24 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: rename variable pnetdev -> netdev
Date:   Mon, 10 Feb 2020 21:08:30 +0100
Message-Id: <20200210200830.22868-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the local variable pnetdev in rtw_alloc_etherdev_with_old_priv
to avoid hungarian notation and clear the last checkpatch warning in
the file osdep_service.c.

rtl8188eu/os_dep/osdep_service.c:32: WARNING: line over 80 characters

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/osdep_service.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/osdep_service.c b/drivers/staging/rtl8188eu/os_dep/osdep_service.c
index 4ba2378a1bb8..4d6d0347ab8e 100644
--- a/drivers/staging/rtl8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8188eu/os_dep/osdep_service.c
@@ -26,17 +26,17 @@ void _rtw_init_queue(struct __queue *pqueue)
 
 struct net_device *rtw_alloc_etherdev_with_old_priv(void *old_priv)
 {
-	struct net_device *pnetdev;
+	struct net_device *netdev;
 	struct rtw_netdev_priv_indicator *pnpi;
 
-	pnetdev = alloc_etherdev_mq(sizeof(struct rtw_netdev_priv_indicator), 4);
-	if (!pnetdev)
+	netdev = alloc_etherdev_mq(sizeof(struct rtw_netdev_priv_indicator), 4);
+	if (!netdev)
 		return NULL;
 
-	pnpi = netdev_priv(pnetdev);
+	pnpi = netdev_priv(netdev);
 	pnpi->priv = old_priv;
 
-	return pnetdev;
+	return netdev;
 }
 
 void rtw_free_netdev(struct net_device *netdev)
-- 
2.25.0


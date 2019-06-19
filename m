Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C19D34B806
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 14:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfFSMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 08:19:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40645 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731719AbfFSMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:19:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so1598765wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4OeT4QB9PU6VWYqnBOpEAKI0qOoaWHvz6HpjRQkiqU=;
        b=m9YyBNc8i5EA+3R/Dtqu49+173j3ZLWpLEmWJ5shrDWjBSS22iX6e3Ugqf2SZ9MnDN
         +303RkVSGZz6Ncll5Tzk/lYAgdeGoya1cd1PSaN4UWYhIMpMceV23xl48t7nAeUID5TW
         LF7DfgO793v3Ppt9W8P6w+hKVWORCcEdcccDYg6/W0e2GsGJamEwCoTf1S7gVX6FhTbq
         A+jv1Avn4jUQMm9oZgAp07qqUM4W0w8kvACwcSH9qWQLNzPX3YLoe9mkki4NTYP/IoDN
         nZetjUkNs4EQUoeek1nSqmAcfcWdMiKxb6Ng8rqIQfPhIe8RF1ELZQmeOjCqpKvlQDLg
         HO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4OeT4QB9PU6VWYqnBOpEAKI0qOoaWHvz6HpjRQkiqU=;
        b=oTnyEtLEIBkLbNoKdfGOBwyKb3i7rOE/LeeLzqjqy2y6Vqm54JEaXRQCFTm6x+9TVq
         5NwBdvr5bP9hNrbH56PvE2j+3I01evOWoqOxosme0bFQt1JAsI7jI/9WqUIhvsAhQR1U
         O1wfNMpNj80lujHDVGSxMY8L4JuuoGop8cZ1aWaLZXS197N95y8H1nHcCk8raouiXW8p
         IU+6XGFXkFN6K21xup58pGvYiFGQAZYvuzY7wtpJU/5wIVtDIQ8dx5L2xn1QFAMPLI6w
         avF2Nv9xXSqUtwP0KHmUifaFTmc2l5/2OdRvw2a2h+jOe/kuNvTPUEUEp9J5fcdT+7v9
         3fYw==
X-Gm-Message-State: APjAAAWfRAfJYcuqfLwR1NRFu2EPOvBHJ3NmkF/P8SkbC0O+q8irFr7o
        InS1b6N6vjn1tVAzyApYSNA=
X-Google-Smtp-Source: APXvYqzV+tD7OpfSIAGNCnmAiTHpfs1hqjUA9hPfSI4NsweDqVTtGYwKvjEZMP6QtXtraUf5+9p/hA==
X-Received: by 2002:a1c:6154:: with SMTP id v81mr7986066wmb.92.1560946763708;
        Wed, 19 Jun 2019 05:19:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id h90sm34887858wrh.15.2019.06.19.05.19.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:19:22 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unused code
Date:   Wed, 19 Jun 2019 14:19:08 +0200
Message-Id: <20190619121908.9203-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused and/or commented code from rtw_wlan_util.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index f404370d6631..d1e99885c8f5 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -27,9 +27,6 @@ static const u8 EPIGRAM_OUI[] = {0x00, 0x90, 0x4c};
 
 u8 REALTEK_96B_IE[] = {0x00, 0xe0, 0x4c, 0x02, 0x01, 0x20};
 
-#define R2T_PHY_DELAY	(0)
-
-/* define WAIT_FOR_BCN_TO_M	(3000) */
 #define WAIT_FOR_BCN_TO_MIN	(6000)
 #define WAIT_FOR_BCN_TO_MAX	(20000)
 
@@ -1041,7 +1038,6 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 
 		switch (pIE->ElementID) {
 		case _HT_EXTRA_INFO_IE_:	/* HT info */
-			/* HT_info_handler(padapter, pIE); */
 			bwmode_update_check(padapter, pIE);
 			break;
 		case _ERPINFO_IE_:
@@ -1346,8 +1342,6 @@ void update_IOT_info(struct adapter *padapter)
 			       false);
 		break;
 	case HT_IOT_PEER_REALTEK:
-		/* rtw_write16(padapter, 0x4cc, 0xffff); */
-		/* rtw_write16(padapter, 0x546, 0x01c0); */
 		/* disable high power */
 		Switch_DM_Func(padapter, (u32)(~DYNAMIC_BB_DYNAMIC_TXPWR),
 			       false);
-- 
2.22.0


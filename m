Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99053E6290
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfJ0NGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 09:06:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52755 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfJ0NGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 09:06:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so6690857wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gs3GiRBJblAnQ6egGV4uLJk282FsBIvSNYDjAwRLL+g=;
        b=Ywe3N4nQsVwPjtUQUEhvDHaoayXFYP/OeswTDv+CN1AbCzQxZ/m7hpJEIBga+I9pMY
         eNAD+KcRa8uTBgIumoiX8Nu5tbnx3/9gd2SJdAaJ5KSye5jr0huyZ3D1v9hZJod9cnQL
         nYFSM/0l36XP+6c+KwLl/jemZ/wKHnFUcs8pS1qsnj1im1bzwqlBPWaoT+jw8sof3mb1
         BpYBhrNB9KdGymDd9gRAo7LA7tSNCfy5slneQWeRTkTjDaLbUmOLDP6/3uKlYrLHFM1S
         1Dy24cc6VoZoYp2GJObFzo520mIwY34yOrkQ6M5Qu1a7LxARrl9+8VI9JtoSADheh/mR
         US6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gs3GiRBJblAnQ6egGV4uLJk282FsBIvSNYDjAwRLL+g=;
        b=ssDNO2YrDm9xg+/So8ILJSRJK49y8JLRH+QHVZQrvUMDxWjwgcK3K3QhuEnJXx7DtG
         fo9snerAbPQ75LLSMvBLVfNIewB+YE9ALs0DOqKMuRrWtNjFdtPE0kabKmsmqLVizoxP
         CnUyDfLRINtVuEoncU1vwotx/Isj7Eg5mcnYIUWTJfHXguE9wQfB/SW1LNTifxMXCNyl
         PSTR8WPqeelLdqPTRFJ7D7S51WW+8v8g0BnwjtparAqzGximti7UiDlntVOxMPbUrYDp
         gD2CF4wvgAGv+NTbV32C0mqmDCfcnrrpCvQuNAL0iXe89pSRQTScuwg81TnUmft60Jwr
         Cm6g==
X-Gm-Message-State: APjAAAVkWAWCOVC/NndhzdoWlozVVdtQgrFqrr8zMIF4Rth6irP/C2lU
        1WBxrSjDXo+zieNVhzVjzxo=
X-Google-Smtp-Source: APXvYqyF0Zd7gGXoIxMaA+lj8avWfAVO9dqxhm1cbZogNDJFN/LaCnpCEvh/bcezyQHbPUeZyRfe5Q==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr12335034wmb.168.1572181588816;
        Sun, 27 Oct 2019 06:06:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id 126sm8127371wma.48.2019.10.27.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 06:06:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: reduce indentation level in _rtw_free_sta_priv
Date:   Sun, 27 Oct 2019 14:06:02 +0100
Message-Id: <20191027130604.68379-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027130604.68379-1-straube.linux@gmail.com>
References: <20191027130604.68379-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce indentation level in _rtw_free_sta_priv by returning early if
pstapriv is NULL. Also clears a line over 80 characters checkpatch
warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 43 ++++++++++----------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 65a824b4dfe0..6c03068d7ed2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -135,31 +135,30 @@ u32 _rtw_free_sta_priv(struct sta_priv *pstapriv)
 	struct recv_reorder_ctrl *preorder_ctrl;
 	int index;
 
-	if (pstapriv) {
-		/* delete all reordering_ctrl_timer */
-		spin_lock_bh(&pstapriv->sta_hash_lock);
-		for (index = 0; index < NUM_STA; index++) {
-			phead = &pstapriv->sta_hash[index];
-			plist = phead->next;
-
-			while (phead != plist) {
-				int i;
-
-				psta = container_of(plist, struct sta_info,
-						    hash_list);
-				plist = plist->next;
-
-				for (i = 0; i < 16; i++) {
-					preorder_ctrl = &psta->recvreorder_ctrl[i];
-					del_timer_sync(&preorder_ctrl->reordering_ctrl_timer);
-				}
+	if (!pstapriv)
+		return _SUCCESS;
+
+	/* delete all reordering_ctrl_timer */
+	spin_lock_bh(&pstapriv->sta_hash_lock);
+	for (index = 0; index < NUM_STA; index++) {
+		phead = &pstapriv->sta_hash[index];
+		plist = phead->next;
+
+		while (phead != plist) {
+			int i;
+
+			psta = container_of(plist, struct sta_info, hash_list);
+			plist = plist->next;
+
+			for (i = 0; i < 16; i++) {
+				preorder_ctrl = &psta->recvreorder_ctrl[i];
+				del_timer_sync(&preorder_ctrl->reordering_ctrl_timer);
 			}
 		}
-		spin_unlock_bh(&pstapriv->sta_hash_lock);
-		/*===============================*/
-
-		vfree(pstapriv->pallocated_stainfo_buf);
 	}
+	spin_unlock_bh(&pstapriv->sta_hash_lock);
+
+	vfree(pstapriv->pallocated_stainfo_buf);
 
 	return _SUCCESS;
 }
-- 
2.23.0


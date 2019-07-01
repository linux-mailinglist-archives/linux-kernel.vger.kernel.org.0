Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF49472BD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 04:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfFPCyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 22:54:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36688 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfFPCyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 22:54:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so1681022plt.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rSYojKKqNckbYG/tUygNLocVuWuVohmc/L+Qes76CYE=;
        b=azL1fWDj/VaFfL9a+EU3dyAzxR2XAIeqzYD3ZEfAEuIxBq8E23eXJQdpJkYc+Wx1BE
         97YGhEtWi9nx5NqEOzEdmY6Sv2Kk3iaf/A8kvtS7grPSrqU47tDOvHWxK8tRw2KgU5vh
         8iFGuRL9QJCe5fNSRXy6MR/ufNPt/qltALYE02ZfUDxkSFcDO+Snm0R/k+KOpkMHZsHw
         f+fwt97b2Yn6wU1xxB/nxl5YW6vvaV7Gc8c19T+NVgpWoxEUbrsAYUPoIOD/3r8dgI8l
         LonnMpdycxR5z7OC04Lt30qQat5TZ2uL+x6UswOzFsELE6q7YpJfJI2h+zNPU6lSFGiv
         5+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rSYojKKqNckbYG/tUygNLocVuWuVohmc/L+Qes76CYE=;
        b=O9Vywstz78V2LPFEQYvChEe1igIWEzNiRciK7kEdleKLV4Rt3Vn/MuhEhXZlIj8UUs
         8x6n+6oVji5c4OxcJ1iwQ0P/+gdWdv5rCn0AB4cCYxRj0W4lWFNUGLWprm0azdePdtlj
         wOOIrcgBqjtBO5lMclFDc7yOaEU21Kou3+3lrQBKohGTdJcNXBDoQSGKW8WYmkQ2HxHX
         HhyQnb0sQ20N4JtJYHIiW9O3dv+LY+ZR/+9irYFHcN7dtxuo896gQdCcwzwTVhIEPaOU
         lH5BKPnsThlTq7Z9ADh1o0kk7GdlmFp4GPTd0faTeB6JEHsfLryaIjNLWw89bEIXT9gZ
         3bhw==
X-Gm-Message-State: APjAAAVbZ7wBkgGOZW/vRzJ15tucGjT7C3FYqRN8dWUUsQnLfTYMi79N
        g2mgFe4+N23OgK/fMrgc24o=
X-Google-Smtp-Source: APXvYqysiXGChPoHpbyxkJa7fBtYWM9b/WTr83QA/2CtymmU9Hk/xLsaSFBSvknMGRD1LOjVz59NkA==
X-Received: by 2002:a17:902:a506:: with SMTP id s6mr26553650plq.87.1560653641324;
        Sat, 15 Jun 2019 19:54:01 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id e127sm7464489pfe.98.2019.06.15.19.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 19:54:00 -0700 (PDT)
Date:   Sun, 16 Jun 2019 08:23:55 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Himadri Pandya <himadri18.07@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 1/2] staging: rtl8723bs: hal: Remove return type of
 initrecvbuf
Message-ID: <20190616025355.GA12008@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change return of initrecvbuf from s32 to void. As this function always
returns SUCCESS .

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
changes in v2: break the patch for specific change
----
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index b269de5..07bee19 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -10,14 +10,12 @@
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
 
-static s32 initrecvbuf(struct recv_buf *precvbuf, struct adapter *padapter)
+static void initrecvbuf(struct recv_buf *precvbuf, struct adapter *padapter)
 {
 	INIT_LIST_HEAD(&precvbuf->list);
 	spin_lock_init(&precvbuf->recvbuf_lock);
 
 	precvbuf->adapter = padapter;
-
-	return _SUCCESS;
 }
 
 static void update_recvframe_attrib(struct adapter *padapter,
@@ -435,9 +433,7 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 	/*  init each recv buffer */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		res = initrecvbuf(precvbuf, padapter);
-		if (res == _FAIL)
-			break;
+		initrecvbuf(precvbuf, padapter);
 
 		if (!precvbuf->pskb) {
 			SIZE_PTR tmpaddr = 0;
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7D303CA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfE3VGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 17:06:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40726 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3VGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:06:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so4724273pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DxmOz58/0StlKEibwrCYgGMkPyTrKsPAkT1wgfSCh0A=;
        b=lPw6/+BZnZp0BOUotnoU1MeyuJQwsyrA321feVb/7MXXacRgSmjox3pHL/H8CO+f3p
         imdp8c0qX1FWzrwob6k4izI59UKId2T3mqDABMRTLfh01+74kbrKZ7T7Whi2eta3abb1
         vQRJ8Kr56vB28hFfHtg/5Vf5Ha05EyhrotvxQgaMmw1rnl+a4gu5DGJMMbfelsYYM3zw
         Pfremua9e5oi510HZZKQO241rWg3PsscfMwRm54/3wxKC6dg1qoyqY5nAbFjgGJAFji8
         dTuXqO7Uz2lM65zzg525zN+fPTZ49nOldpzMLKMPyTLCNNlpzc8/yZgGZEqEQJJmGS0n
         3JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DxmOz58/0StlKEibwrCYgGMkPyTrKsPAkT1wgfSCh0A=;
        b=eM8NKauy1v5fAo+O/a1py+eU7KfoPWGxnXGPl60KtnIErAns59CHPoei4qOriOz3au
         WhDL2zZQL0KGuJMos92BYwaDOnDvRHQAz8DSel1ervM2QGF+oxMK4iTajqF0ep4gpWH7
         lPTzdPnstHn2Vp+fqzlDCaVrEU5iPsxJWWLoXDA40q6SF1g6+B2cOVfYKTooYhndD9qc
         ba0YUY8TUS8oZHh5US/8O0P4ByYyISo92r0rVHNH+iA18UkuhyeAKLeh7erfKK+iDKH6
         LESUZQEY/gj3mK7U+yhH70YT92OPVLZmRJW5rWW59gVAFUjbOb37u7aq++/Aa9rIp5+M
         ITLA==
X-Gm-Message-State: APjAAAXu0L/I7pkz42vKOv97HrDub1V7Iz2vVk/Dv3JWHw3W9CoxBKtY
        Malu7GuP+z7oGPI9kZJNz9w=
X-Google-Smtp-Source: APXvYqyu1BJ4IxDhFu/YN1BDSVzMQhD3CJxdO23KJDNS4pGJ9TN74IVMryUCyQG9FsRPLXQo03Ob8g==
X-Received: by 2002:a17:90a:9305:: with SMTP id p5mr5307493pjo.33.1559250413396;
        Thu, 30 May 2019 14:06:53 -0700 (PDT)
Received: from localhost.localdomain ([47.15.209.13])
        by smtp.gmail.com with ESMTPSA id r2sm3134580pgb.62.2019.05.30.14.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 14:06:52 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: Change _SUCCESS/_FAIL to 0/-ENOMEM
Date:   Fri, 31 May 2019 02:36:38 +0530
Message-Id: <20190530210638.30343-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return values _SUCCESS and _FAIL to 0 and -ENOMEM respectively,
to match the convention in the drivers (and also because the return
value of this changed function is never checked anyway).
Change return type of the function to int (from u8) to allow the return
of -ENOMEM.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_cmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 8220829b5c82..e408b15102ce 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -773,7 +773,7 @@ u8 r8712_addbareq_cmd(struct _adapter *padapter, u8 tid)
 	return _SUCCESS;
 }
 
-u8 r8712_wdg_timeout_handler(struct _adapter *padapter)
+int r8712_wdg_timeout_handler(struct _adapter *padapter)
 {
 	struct cmd_obj *ph2c;
 	struct drvint_cmd_parm  *pdrvintcmd_param;
@@ -781,18 +781,18 @@ u8 r8712_wdg_timeout_handler(struct _adapter *padapter)
 
 	ph2c = kmalloc(sizeof(*ph2c), GFP_ATOMIC);
 	if (!ph2c)
-		return _FAIL;
+		return -ENOMEM;
 	pdrvintcmd_param = kmalloc(sizeof(*pdrvintcmd_param), GFP_ATOMIC);
 	if (!pdrvintcmd_param) {
 		kfree(ph2c);
-		return _FAIL;
+		return -ENOMEM;
 	}
 	pdrvintcmd_param->i_cid = WDG_WK_CID;
 	pdrvintcmd_param->sz = 0;
 	pdrvintcmd_param->pbuf = NULL;
 	init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvintcmd_param, _DRV_INT_CMD_);
 	r8712_enqueue_cmd_ex(pcmdpriv, ph2c);
-	return _SUCCESS;
+	return 0;
 }
 
 void r8712_survey_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
-- 
2.19.1


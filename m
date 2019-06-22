Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331664F71F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 18:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfFVQlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 12:41:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42125 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:41:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so5126908pff.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bfddTUlKO6se+VLq0VfMnq9Jkt0mYxtKJaFGDRxHeeE=;
        b=qd+8j6h2zxjzpicDhL90XpunLAbD3F7DpD27WMzsAJI7Eedu0VO2NKKwtDvkNvaXto
         eGluBun20fTxXsgI0MzUK5NW3JSJG1B+ZnEXl9NMjk5ln/A899sp28nNCKRBqlevihlf
         OoCCIHFC1bKlYq9C/SBsJFL1AHXqTPSmthEngKBDlHuZ3Zdyd6P+EbtosWOdHhseN+Du
         OMN2oV106VvIl9boTu/ZntjYyrzNMIL4lngDpwRuKpzNfixQCZHIr8qrZaQOs2p9h2Rq
         r7cYNxBLktcvbZm9v8V/rqW7rjEQpzG1tkGTGApqETx4DZ4mTzHIjy+u/mid+YajbSMj
         kzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bfddTUlKO6se+VLq0VfMnq9Jkt0mYxtKJaFGDRxHeeE=;
        b=KxNyR9mw2ULAGuz2hCbxq1BuWm0/mgxFjqy0Fh+C13FB382AE5AMcNwRAnCaVT6Fz7
         Ggp8FQZBj0VPCPiCQYLxpeRGgcpUFklbchafIvBtBUgz1lfIxF2wKev8qVU/YsaWKKPS
         KlvptX4Oj66CzHmwx2iz7rNWFfgzq2CAWfRFcdBhmVfJUwtk0LFZ8+wuqqJMCRQVsOix
         +p8IHazvDBAPCkwANWVicQbOkbIaMyAktr8W06mbwpjTjzV3ZYHXY/klpJiaILZwU0UW
         SMdAo31VowyjohS3B358nhlb2NuL4D6wLfO8F7xUSIT0r7mfeN68xv4hZvgHX5Zo4VFq
         hwgw==
X-Gm-Message-State: APjAAAU+e7exYnSSWLQTpbiShr7OxZUOF96NTN3as4rOSaldGgE54kIJ
        kih99ZVfJvvnwwoe45JYtEU=
X-Google-Smtp-Source: APXvYqz6/k67NNDcJEI+xl1saj4DMkIhRYpij+ZlCrOe4VQ0oRu6dZ1cuLVObCz6UN9zlWWNeaW1iw==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr13803721pjp.76.1561221675861;
        Sat, 22 Jun 2019 09:41:15 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id u5sm5809161pgp.19.2019.06.22.09.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 09:41:15 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: os_dep: Change return type of rtw_init_default_value() to void
Date:   Sat, 22 Jun 2019 09:40:42 -0700
Message-Id: <ab71fb523942b596da4b7ec3782ce1c1a209b41a.1561220637.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561220637.git.shobhitkukreti@gmail.com>
References: <cover.1561220637.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1561220637.git.shobhitkukreti@gmail.com>
References: <cover.1561220637.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_init_default_value() func always returns a value (u8)_SUCCESS.
Modified return type to void to resolve coccicheck warnings
of unneeded variable.

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 6b26af3..22d4461 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -601,9 +601,8 @@ void rtw_stop_drv_threads (struct adapter *padapter)
 	rtw_hal_stop_thread(padapter);
 }
 
-static u8 rtw_init_default_value(struct adapter *padapter)
+static void rtw_init_default_value(struct adapter *padapter)
 {
-	u8 ret  = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -665,7 +664,6 @@ static u8 rtw_init_default_value(struct adapter *padapter)
 	padapter->driver_ampdu_spacing = 0xFF;
 	padapter->driver_rx_ampdu_factor =  0xFF;
 
-	return ret;
 }
 
 struct dvobj_priv *devobj_init(void)
@@ -749,7 +747,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_init_drv_sw\n"));
 
-	ret8 = rtw_init_default_value(padapter);
+	rtw_init_default_value(padapter);
 
 	rtw_init_hal_com_default_value(padapter);
 
-- 
2.7.4


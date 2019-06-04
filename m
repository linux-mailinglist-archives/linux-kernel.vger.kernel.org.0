Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7034141
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfFDIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 04:12:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40170 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDIMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:12:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so12208442pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XhGxcyl15j2CR0DCz3fMTnLwvj65vTyLrIZ4yDtoYXw=;
        b=hx8KkJt1ABUwHCaJKCcTtgFpDjMGOlolcsa3WknXTuMbOs5AiGX+7L3VsNPquRYtRi
         qvRIL/wRURhc4nlSp2rzKU3kuNBdtw6Ie4HVgoGs85Yx6534SCcy1F45GW6gfX1iim0u
         CiXpCN6d/vXzZYbo81l4NFH3BaSkfPzvfh01iJQ5OnQiJV4uzvkxU2LZzYl88dgckCtP
         WoJ2sIehmhHGDTSrSlYjAlp2J3CFSkeN2kWLGu/nUuqQhN/IoNZngnM6csuWmqvMETZk
         D2uThdtG9dBCqIFyDk7feFvG7DZ/SSWzEWxUUzc3ZiLdRoa7U9ITrnH2Kq8Q+voi7Ir9
         etPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XhGxcyl15j2CR0DCz3fMTnLwvj65vTyLrIZ4yDtoYXw=;
        b=YkpRhpTy0Zr3Vq/4x/jPhUpafhCwM5HM5bt1Tr9jmOvhZCM0jd5+0b8VeYojQ9nMXO
         veRVrEBQ5pIzCWmJsL8w4SqDbOVwNOw5axQ88O6Zlum+zHm++d7G2jpd7pu8LVrIHQpE
         9+5PrKUzzJjP+pLj+jEM2oRQei6RUkoTKggMd+0wo3Pdd5vcEtwpnjiBi1ggMmNR6Jcb
         JP2R2hzTLMvbvPaQbQFn8n8Fto1V9RhQ701jW7iFgWBwuFSHrcp9r6j/UGtybqK5AbJT
         iJBIzE1qe6++zmAeJT5LFVf4MQU5IqKD35/+Y3xnVM+t/C8Q+EHTOwmQbCkPHQtq3PNx
         KGXw==
X-Gm-Message-State: APjAAAV6+XSzOI7YN4WFmXfmJFN0h3V3NE5n4WoypmtV7f6myw/lhLIc
        21pPN1Vb9CoYwssj+5EEygo=
X-Google-Smtp-Source: APXvYqyXqdFotkOUoxeg9MqXtEN/n8FdFxqk8dN3qY3Cp9nhMGifYgXuaC7BiWL3FsFaqilvVW9HCg==
X-Received: by 2002:a63:db4e:: with SMTP id x14mr34782545pgi.119.1559635954667;
        Tue, 04 Jun 2019 01:12:34 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id k22sm6580204pfk.178.2019.06.04.01.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 01:12:34 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, flbue@gmx.de, puranjay12@gmail.com
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: core: Replace function rtw_free_network_nolock
Date:   Tue,  4 Jun 2019 13:42:22 +0530
Message-Id: <20190604081222.12658-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function rtw_free_network_nolock, as all it does is call
_rtw_free_network_nolock, and rename _rtw_free_network_nolock to
rtw_free_network_nolock.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 0abb2df32645..454c5795903d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -159,7 +159,7 @@ static void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *
 	spin_unlock_bh(&free_queue->lock);
 }
 
-void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
+void rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
 {
 	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
@@ -276,12 +276,6 @@ static struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
 	return _rtw_alloc_network(pmlmepriv);
 }
 
-static void rtw_free_network_nolock(struct mlme_priv *pmlmepriv,
-				    struct wlan_network *pnetwork)
-{
-	_rtw_free_network_nolock(pmlmepriv, pnetwork);
-}
-
 int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 {
 	int ret = true;
-- 
2.19.1


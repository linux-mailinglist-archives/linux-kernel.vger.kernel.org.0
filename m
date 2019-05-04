Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1B313BCF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfEDSrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:47:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33190 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfEDSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:47:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so4373213pgh.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l3c6KFF6BsmBy3LVEJIfrDKvV0/RDELn3G8eEmiKxLM=;
        b=FH5gmfmQbT7Z7/f7ibgaYZzoAGT0PM9xBJJDOLN8ljEUxvD53vVI8RJD/m2hdsuvX4
         aRuGjIFon600zbymKxPsy7JArdeJP0XNnLueZd9pdoRJbciHY+5aGmYKTzhBSGK9GxVo
         p6oWdxksOTWSmeDcUinlCds+P2/Q8qn4wzaM6WxP+LKdq5gE5PpR7aKEfCEIzbcJi7bC
         Pch8ZHzyFOljRjmfOpk4bd/7eI1yl3nwbajFVUCQM1cZxbdYxE31M0m9l4UeY4uIphKl
         BsQY8zWeL2egFIc66sciXuUeiAfJG14EkyaJEPJH4ptcBKaSOUCOcEOC+V/abRUhv5XI
         wXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l3c6KFF6BsmBy3LVEJIfrDKvV0/RDELn3G8eEmiKxLM=;
        b=jkHw8MLf5dc6WPhANjKAgs+wUsHnUNIWFXa2AUwsKxmPuSgZiNI301FhjUsaGZX16U
         XcbqbHN5sBvczRIhDQ4LOJZmt12YNQwEYL2RRQrfyjCofgdCZKhN7NnFB+NyBUKDhgtZ
         A7m8QrO2VK0VS+DkvlAy4MbMbeCFxjw+fG9KXJFvpzH5Xp8M+leZ4pTL72Uumw86Lnqu
         S+DDilnXl/up86PcHMyj8ucPn9wYmevO7wa6lLH/I0sFX6EP8GBcWLg4FSbfCgdSE3Ao
         VweRvFpnpLU+Fq0TlT/h07IS3EdPqvQ+nlcyK3/zpMkhc4zq8fKzfcS/oFtm0f1wLI4a
         sTgw==
X-Gm-Message-State: APjAAAXhk97ix4vB1SfkrIbRs8bj8UvmMZWJfs986JY/RWrRfKHu6P+d
        CZE9E7OAzWrMG0DvI4Wr0yXXBi0F
X-Google-Smtp-Source: APXvYqymQKkkxsqq8taEVSzOWaYsFAAvsSK6EKs5rUtEyV71u2gBpBEFW5W/MxiIANly9lBD6Q/cZw==
X-Received: by 2002:a62:27c2:: with SMTP id n185mr20628729pfn.51.1556995633508;
        Sat, 04 May 2019 11:47:13 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id f21sm6989063pfn.30.2019.05.04.11.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:47:12 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hadess@hadess.net, hdegoede@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH 4/7] staging: rtl8723bs: core: Remove unnecessary parentheses.
Date:   Sun,  5 May 2019 00:16:44 +0530
Message-Id: <20190504184644.25988-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses after 'address-of' operator to get rid of
checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 32b66dce99cd..60079532bddd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -277,7 +277,7 @@ void init_mlme_default_rate_set(struct adapter *padapter)
 static void init_mlme_ext_priv_value(struct adapter *padapter)
 {
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	atomic_set(&pmlmeext->event_seq, 0);
 	pmlmeext->mgnt_seq = 0;/* reset to zero when disconnect at client mode */
@@ -464,8 +464,8 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pmlmeext->padapter = padapter;
 
@@ -609,8 +609,8 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
 	unsigned char *p;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex	*cur = &(pmlmeinfo->network);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex	*cur = &pmlmeinfo->network;
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint len = precv_frame->u.hdr.len;
 	u8 is_valid_p2p_probereq = false;
-- 
2.17.1


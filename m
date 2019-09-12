Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320F9B1186
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfILOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 10:54:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44352 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732592AbfILOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:53:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so13604213pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IoVQbDWNnJatefEpHqNwx0WsYWf336HdB6z2aMcmRsw=;
        b=nw349E/CNvfCA91fOtroRLu+ZJo+CKztPvu3Kd+BEV3y/QPUx0cqnfwUrpGXx9uoD/
         qYiY151cKeJ0lhdAL5e7KOAs0ZXVT/aiFrDqZ0wiFE8k43zZtb4Zdczi4e0pPGGId63c
         aXJTcJPQEeGUS7+/cEHLhUGUCQD93FstTWCFv8RCuR7WqavU9q6uwNZ+qBQVtpoFGXJR
         AH/2Lg/fellVghCHMFAz9y3vwKSzXhnhi8ldUgXrkVYLgrVQVe8lrtM9nz3VbN70E6D2
         8ANSwz3VHRbXdizNqgRwUqHapo7PLk+rUKBQxIaQimpvO9bikMLi89M50aKKNMLdUZRV
         3EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IoVQbDWNnJatefEpHqNwx0WsYWf336HdB6z2aMcmRsw=;
        b=BpyUMlm0wD3WOFTsvQ1pbtvBhhYC2rqx09DLqFxnBcVh3nX4MFcY2HFtwMoxlbBaqx
         xRSFf0XCVR4yf5Ik24UKdW2Z2DLuUDahp0iiObpUICISnwLPPQDn+nnYWzKx0u0w2aO5
         EP4u1CBlB6wqhGfjX3ZXu/XUySqK3PJ6CGu/R2vfAyCiEeGU7Gzmc4qfNNMINDj/9/TG
         KH/h9u/qvbOtvERcgJeSRrtN/aWBJAu9+NeAKwqAVVfDaHMQO98JxmW2mqv23FAmf8UG
         Kfg8/+NSjtfN2zRZ3IPWVcAbuNZgR45RQDFlfpXp/ElGP+LIFToNPMV5BUuxbQcpKGxT
         s7dQ==
X-Gm-Message-State: APjAAAVE9iR40o6y/Z3mJ+zWZJpsRUc5OCrvGXcxjlOrYT6w7YUf92fy
        1DOlFqsN93ly+/luRVXW5RDrzsJG
X-Google-Smtp-Source: APXvYqw1F2M79KnIG0E626caFbEoEpZa3O4KYrHAsA4ii2llTtOrrjSee5SYWTpqc46st16qwPZJLQ==
X-Received: by 2002:a62:d4:: with SMTP id 203mr49117982pfa.210.1568300039107;
        Thu, 12 Sep 2019 07:53:59 -0700 (PDT)
Received: from SD.eic.com ([106.222.12.153])
        by smtp.gmail.com with ESMTPSA id x20sm12871036pfa.153.2019.09.12.07.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 07:53:58 -0700 (PDT)
Date:   Thu, 12 Sep 2019 20:23:46 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove unneeded conversion to bool
Message-ID: <20190912145346.GA9013@SD.eic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relational and logical operators evaluate to bool,
explicit conversion is overly verbose and unneeded.

This issue found using - Coccinelle (http://coccinelle.lip6.fr)

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 2128886c9924..3bca37e70f5f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2922,7 +2922,8 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 	int i = 0;
 
 	do {
-		ret = _issue_probereq(padapter, pssid, da, ch, append_wps, wait_ms > 0?true:false);
+		ret = _issue_probereq(padapter, pssid, da, ch, append_wps,
+				      wait_ms > 0);
 
 		i++;
 
@@ -3513,7 +3514,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 	}
 
 	do {
-		ret = _issue_nulldata(padapter, da, power_mode, wait_ms > 0?true:false);
+		ret = _issue_nulldata(padapter, da, power_mode, wait_ms > 0);
 
 		i++;
 
@@ -3661,7 +3662,7 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 		da = get_my_bssid(&(pmlmeinfo->network));
 
 	do {
-		ret = _issue_qos_nulldata(padapter, da, tid, wait_ms > 0?true:false);
+		ret = _issue_qos_nulldata(padapter, da, tid, wait_ms > 0);
 
 		i++;
 
@@ -3769,7 +3770,7 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 	int i = 0;
 
 	do {
-		ret = _issue_deauth(padapter, da, reason, wait_ms > 0?true:false);
+		ret = _issue_deauth(padapter, da, reason, wait_ms > 0);
 
 		i++;
 
-- 
2.20.1


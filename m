Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1CC55F24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 04:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFZCl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 22:41:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33653 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfFZCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:41:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so542851plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8iHzMdYOI0Vlz5bJjh+l/GqT6c2o8S7w8UKOoSsz21M=;
        b=tU729ZIcVWFphWxnLy+Qzf/7C+Pg665dgPb9pkCJxU191+cawtSZxnuBnGImiZAhSy
         MaS+0Q9yPKkib9YynRiw00DVQWBUGlAJoEFCuvT5ENdY+mcpWSugy/Nh0fPRRh2LpXIw
         aqyDUMRpY+y8zvovpOsWdi9vaPuURaBKr/vio5A/dbFmJ7OoM8Z57hqsjJC+/cZdVGRA
         yI5oCGCkYCnK+1pDRoZUSWg9gy6f1DR9d4x1rcPuas8+7a0ZD4p373BZPJfrEU0eJmBR
         GiC42MKtmk9LeranEvRWCUwWlsdyuUkDmItOw+gL6zl8g54vdEcpFXWhjwd/cbDjLwCZ
         FUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8iHzMdYOI0Vlz5bJjh+l/GqT6c2o8S7w8UKOoSsz21M=;
        b=aT1vXvFmwilROBEIm1acouLZcW4VuuQfTjgyWcEMNiMb/OdwzcoSMwDppfc1xak69D
         XM+9W68psVWEOFDT6Ddg/Oh+k6zUSVwRdy4TawLnrK2143sgaloDYF1gWUZN69lMLkyd
         JMThjstBMCHuE9piyXE7G969EDpy/onIiqpx4PIwKDVcNT25ihy0qhw3PPV3dsZbQnSV
         3j0U6WyVgq8U817I9VbQCyuFMyIwOqGaRltgJhNF8XItDtxib7wuG3dKlBYIN9q7pE4l
         9ybRulzFViOkQNo5jqS5oxxSoWK6CG2vwn16xcw/vOo4QiErh8fDLGZkWpEcMuEIKB2B
         kuqA==
X-Gm-Message-State: APjAAAW+X47kaDG3wpDg4wVHpp88OydmkwT1q7N+j13Z61hyASF9LH8Q
        9b9m8l1ncwVJgk2tfEe2IJQ=
X-Google-Smtp-Source: APXvYqwBeGWcBBnwXnUoND1FgWqFavn2cFbMxnlePbuOpNbGPbDp4WYJuqmnvKCYcdFbtfloIDZiqA==
X-Received: by 2002:a17:902:6848:: with SMTP id f8mr2252796pln.102.1561516917272;
        Tue, 25 Jun 2019 19:41:57 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id 5sm15489580pfh.109.2019.06.25.19.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 19:41:56 -0700 (PDT)
Date:   Wed, 26 Jun 2019 08:11:51 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8723bs: hal: hal_btcoex: Using comparison to
 true is error prone
Message-ID: <20190626024151.GA6035@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to true is error prone
CHECK: Using comparison to false is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 66caf34..99e0b91 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -290,7 +290,7 @@ static u8 halbtcoutsrc_IsWifiBusy(struct adapter *padapter)
 	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE) == true) {
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
 			return true;
-		if (true == pmlmepriv->LinkDetectInfo.bBusyTraffic)
+		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
 			return true;
 	}
 
@@ -310,12 +310,12 @@ static u32 _halbtcoutsrc_GetWifiLinkStatus(struct adapter *padapter)
 
 	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE) == true) {
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
-			if (true == bp2p)
+			if (bp2p)
 				portConnectedStatus |= WIFI_P2P_GO_CONNECTED;
 			else
 				portConnectedStatus |= WIFI_AP_CONNECTED;
 		} else {
-			if (true == bp2p)
+			if (bp2p)
 				portConnectedStatus |= WIFI_P2P_GC_CONNECTED;
 			else
 				portConnectedStatus |= WIFI_STA_CONNECTED;
@@ -372,7 +372,7 @@ static u8 halbtcoutsrc_GetWifiScanAPNum(struct adapter *padapter)
 
 	pmlmeext = &padapter->mlmeextpriv;
 
-	if (GLBtcWiFiInScanState == false) {
+	if (!GLBtcWiFiInScanState) {
 		if (pmlmeext->sitesurvey_res.bss_cnt > 0xFF)
 			scan_AP_num = 0xFF;
 		else
@@ -1444,7 +1444,7 @@ void hal_btcoex_IQKNotify(struct adapter *padapter, u8 state)
 
 void hal_btcoex_BtInfoNotify(struct adapter *padapter, u8 length, u8 *tmpBuf)
 {
-	if (GLBtcWiFiInIQKState == true)
+	if (GLBtcWiFiInIQKState)
 		return;
 
 	EXhalbtcoutsrc_BtInfoNotify(&GLBtCoexist, tmpBuf, length);
-- 
2.7.4


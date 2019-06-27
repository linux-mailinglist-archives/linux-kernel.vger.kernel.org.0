Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77158989
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfF0SLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 14:11:44 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35662 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0SLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:11:44 -0400
Received: by mail-pg1-f181.google.com with SMTP id s27so1382595pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sLO/22DEBzZ9YzTHvB2P+aBIyX6ZIdYPZ+AVLvQyXi4=;
        b=HNSET3Kig7XJjnUZ5Ide0hWJLXMNYu4LDZNoOkqz4fD8Nvu7FQ34UkprOrWYo6owJ4
         vTuGd6jnk5DnxXAzUEAjOZFsaTBpnGtMp0x+6ygF+Rdlgxda05fHM00tsY+nCq4+jtzu
         9mJChOYEI8b/UWtbKtKCPmmDYhiryvT8QViNBdB0LQePzpf+yTMiDeimcgpszUDWk82A
         rBq7gNZC8D4FZPeZVAMEiYmSMZH0MummDiSmFg9ThGDsoWt2qNnHjfg5nnIKWlAAINTs
         o6Od8P+zUREbwBetxIzOtRDLIcudV3caDibd2Ou9lFEAjS6fG7wA2hzsFuLz/JWoEHRJ
         ASMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sLO/22DEBzZ9YzTHvB2P+aBIyX6ZIdYPZ+AVLvQyXi4=;
        b=ApGyKtRZeEGBAIemyJx2leRLdYnX17Xr0paWM7qVgiAf3B+XVt5JivCEEEwwOykiZJ
         0RXOXEHYNCameFAItsZ+QMIBBgXMHvQCtkYLsYbk4rVB2wuDl4R2FJjCIqAoba8C8Z4u
         9NueMRalugvsG/CVLHqFnlfK7i28sffsIfTyqv50g6Sm5Yy9fKbSE/X6gPjWbxh9mOcG
         KI3Tj+7EEq5S4ZAirtxqJZI4fgCUCydzVd6vlIe+kNJtfEFBK+iVwfyVEqCp4TFMCeeT
         0gk9tmFenQRdfm+D87XBNLM8vhhvxB+NfY/NB97UgLpERbq2A5EbeX4u4y/FXS7E+6aA
         b1lQ==
X-Gm-Message-State: APjAAAWwsHlNqIAIK4CwvcZVpjDIav1EEo4EiC9zF4ZppsHAwuNNyNFC
        pnSje4xzeNWjPP/niOEZbEyP00Z3
X-Google-Smtp-Source: APXvYqxSatuFQ8yuiFVOeRSZca4Eqd35/lgTnQRyBP+9mFROutEq01OWVr/WY20fT5YHYuHBK60dLg==
X-Received: by 2002:a17:90a:346c:: with SMTP id o99mr7475164pjb.20.1561659103600;
        Thu, 27 Jun 2019 11:11:43 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id j5sm3690249pfi.104.2019.06.27.11.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 11:11:42 -0700 (PDT)
Date:   Thu, 27 Jun 2019 23:41:39 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v3] staging: rtl8723bs: hal: sdio_halinit: Remove set but
 unused varilable pHalData
Message-ID: <20190627181139.GA3503@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unsed variable pHalData in below functions
_InitOperationMode, SetHwReg8723BS.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v2 add clean change log
v3 remove unneeded blank lines
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 4d06ab7..5b72d61 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -606,11 +606,9 @@ static void _initSdioAggregationSetting(struct adapter *padapter)
 
 static void _InitOperationMode(struct adapter *padapter)
 {
-	struct hal_com_data *pHalData;
 	struct mlme_ext_priv *pmlmeext;
 	u8 regBwOpMode = 0;
 
-	pHalData = GET_HAL_DATA(padapter);
 	pmlmeext = &padapter->mlmeextpriv;
 
 	/* 1 This part need to modified according to the rate set we filtered!! */
@@ -1413,7 +1411,6 @@ static void ReadAdapterInfo8723BS(struct adapter *padapter)
  */
 static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 {
-	struct hal_com_data *pHalData;
 	u8 val8;
 
 #if defined(CONFIG_WOWLAN) || defined(CONFIG_AP_WOWLAN)
@@ -1433,8 +1430,6 @@ static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 #endif
 #endif
 
-	pHalData = GET_HAL_DATA(padapter);
-
 	switch (variable) {
 	case HW_VAR_SET_RPWM:
 		/*  rpwm value only use BIT0(clock bit) , BIT6(Ack bit), and BIT7(Toggle bit) */
-- 
2.7.4


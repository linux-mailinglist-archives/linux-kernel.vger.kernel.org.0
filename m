Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2421B49691
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 03:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFRBIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 21:08:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33621 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:08:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so6718457pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 18:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jDZhFmpz9ACudGMzcyLxP8/Ltek/RCeyMDIlR39/+io=;
        b=Q5mwcL9gAL6wL0SeNT77C3DOU2Jbein9PDE6tAd40fiq8M92UHQBwbMGmkDrJOq6As
         8i/2YBUqor6VYnAwU+DDQtIVK+NR6ebN2Y338QxQYx2GqN2s4mIg8R8z3wsLAVnWwhWk
         G02gLQY3euLDp2qJLYVuvXiYjGzNE9lP7Lq8dr8kZmiBe2gNU6JByNIZ3EttsEoA16N4
         csfzR5HfOEztWzfpuaCM64lhMNEbc1jxnxRZBnhbYritB3moE9osW4AIx1/y48nd5Xst
         7voaFAgupNzUpxGKp1xKkhgy1A+THe2BMaTsNgGuna8mC53t9OfgxQhEca+VEK28sY0x
         bWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jDZhFmpz9ACudGMzcyLxP8/Ltek/RCeyMDIlR39/+io=;
        b=nCf19TZysR/z6Lko2DpjR2005QfcbzS1de6d5Hj/fuhXcIsxHi1qOYchvvACq5mxHt
         JC8Toet+6zdXWgfhRGA4+GKpzeomJ/eAkG1Ev5LJwD1uwWlB0x2YqKRlHI51hSUBYoTH
         t82BuY0wIMiPcK3vjGKpwE6HKJWpnoC23+29sahZUMB9ZsKADp07EmiuSmdBgzYuW6Lp
         hZIHcebsVo8+oPL+0PfjuFFdNrsugGjQGDsr7JyqF1RvXdrwIha6sF6o1AF3P4BvVobs
         THA+I+SkVl/M+C5VurGcdp4g1+pz+XTVWLnkmRypm7gOPDlbztV0rokOAI4An1pTCKSt
         LIRg==
X-Gm-Message-State: APjAAAW2RoZmx/kIzOngqZEe/txkNQam2aC7s8GZgj/dHR+5xcvsOxmQ
        OU87smgbbMFQhOPmGYH1nW8=
X-Google-Smtp-Source: APXvYqx4GITob4sPOCuegNHc0uI/jChHmkybsA5ACmagvsSbF+15z731CDZIFqoYJUer3tsS7Ye2Zw==
X-Received: by 2002:a63:8b4c:: with SMTP id j73mr171687pge.15.1560820113039;
        Mon, 17 Jun 2019 18:08:33 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id f7sm11487062pfd.43.2019.06.17.18.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 18:08:32 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:38:28 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8723bs: hal: rtl8723b_hal_init: fix Using
 comparison to true is error prone
Message-ID: <20190618010828.GA7084@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to fix below issues reported by checkpatch

CHECK: Using comparison to true is error prone
CHECK: Using comparison to true is false prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 38 +++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 624188e..b0cc882 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -742,7 +742,7 @@ static void Hal_BT_EfusePowerSwitch(
 )
 {
 	u8 tempval;
-	if (PwrState == true) {
+	if (PwrState) {
 		/*  enable BT power cut */
 		/*  0x6A[14] = 1 */
 		tempval = rtw_read8(padapter, 0x6B);
@@ -783,7 +783,7 @@ static void Hal_EfusePowerSwitch(
 	u16 tmpV16;
 
 
-	if (PwrState == true) {
+	if (PwrState) {
 		/*  To avoid cannot access efuse regsiters after disable/enable several times during DTM test. */
 		/*  Suggested by SD1 IsaacHsu. 2013.07.08, added by tynli. */
 		tempval = rtw_read8(padapter, SDIO_LOCAL_BASE|SDIO_REG_HSUS_CTRL);
@@ -833,7 +833,7 @@ static void Hal_EfusePowerSwitch(
 			rtw_write16(padapter, REG_SYS_CLKR, tmpV16);
 		}
 
-		if (bWrite == true) {
+		if (bWrite) {
 			/*  Enable LDO 2.5V before read/write action */
 			tempval = rtw_read8(padapter, EFUSE_TEST+3);
 			tempval &= 0x0F;
@@ -845,7 +845,7 @@ static void Hal_EfusePowerSwitch(
 	} else {
 		rtw_write8(padapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
 
-		if (bWrite == true) {
+		if (bWrite) {
 			/*  Disable LDO 2.5V after read/write action */
 			tempval = rtw_read8(padapter, EFUSE_TEST+3);
 			rtw_write8(padapter, EFUSE_TEST+3, (tempval & 0x7F));
@@ -2166,7 +2166,7 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 	}
 #endif
 
-	if (pHalData->fw_ractrl == true) {
+	if (pHalData->fw_ractrl) {
 		rtl8723b_set_FwMacIdConfig_cmd(padapter, mac_id, psta->raid, psta->bw_mode, shortGIrate, mask);
 	}
 
@@ -2428,7 +2428,7 @@ void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
-	if (false == pEEPROM->bautoload_fail_flag) { /*  autoload OK. */
+	if (!pEEPROM->bautoload_fail_flag) { /*  autoload OK. */
 		if (!pEEPROM->EepromOrEfuse) {
 			/*  Read EFUSE real map to shadow. */
 			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
@@ -2436,7 +2436,7 @@ void Hal_InitPGData(struct adapter *padapter, u8 *PROMContent)
 		}
 	} else {/* autoload fail */
 		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("AutoLoad Fail reported from CR9346!!\n"));
-		if (false == pEEPROM->EepromOrEfuse)
+		if (!pEEPROM->EepromOrEfuse)
 			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 		memcpy((void *)PROMContent, (void *)pEEPROM->efuse_eeprom_data, HWSET_MAX_SIZE_8723B);
 	}
@@ -2842,12 +2842,12 @@ void Hal_EfuseParseThermalMeter_8723B(
 	/*  */
 	/*  ThermalMeter from EEPROM */
 	/*  */
-	if (false == AutoLoadFail)
+	if (!AutoLoadFail)
 		pHalData->EEPROMThermalMeter = PROMContent[EEPROM_THERMAL_METER_8723B];
 	else
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_8723B;
 
-	if ((pHalData->EEPROMThermalMeter == 0xff) || (true == AutoLoadFail)) {
+	if ((pHalData->EEPROMThermalMeter == 0xff) || AutoLoadFail) {
 		pHalData->bAPKThermalMeterIgnore = true;
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_8723B;
 	}
@@ -3094,12 +3094,12 @@ static void rtl8723b_fill_default_txdesc(
 			(pattrib->dhcp_pkt != 1) &&
 			(drv_userate != 1)
 #ifdef CONFIG_AUTO_AP_MODE
-			&& (pattrib->pctrl != true)
+			&& (!pattrib->pctrl)
 #endif
 		) {
 			/*  Non EAP & ARP & DHCP type data packet */
 
-			if (pattrib->ampdu_en == true) {
+			if (pattrib->ampdu_en) {
 				ptxdesc->agg_en = 1; /*  AGG EN */
 				ptxdesc->max_agg_num = 0x1f;
 				ptxdesc->ampdu_density = pattrib->ampdu_spacing;
@@ -3110,7 +3110,7 @@ static void rtl8723b_fill_default_txdesc(
 
 			ptxdesc->data_ratefb_lmt = 0x1F;
 
-			if (pHalData->fw_ractrl == false) {
+			if (!pHalData->fw_ractrl) {
 				ptxdesc->userate = 1;
 
 				if (pHalData->dmpriv.INIDATA_RATE[pattrib->mac_id] & BIT(7))
@@ -3162,7 +3162,7 @@ static void rtl8723b_fill_default_txdesc(
 		ptxdesc->mbssid = pattrib->mbssid & 0xF;
 
 		ptxdesc->rty_lmt_en = 1; /*  retry limit enable */
-		if (pattrib->retry_ctrl == true) {
+		if (pattrib->retry_ctrl) {
 			ptxdesc->data_rt_lmt = 6;
 		} else {
 			ptxdesc->data_rt_lmt = 12;
@@ -3265,14 +3265,14 @@ void rtl8723b_fill_fake_txdesc(
 	SET_TX_DESC_QUEUE_SEL_8723B(pDesc, QSLT_MGNT); /*  Fixed queue of Mgnt queue */
 
 	/*  Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error vlaue by Hw. */
-	if (true == IsPsPoll) {
+	if (IsPsPoll) {
 		SET_TX_DESC_NAV_USE_HDR_8723B(pDesc, 1);
 	} else {
 		SET_TX_DESC_HWSEQ_EN_8723B(pDesc, 1); /*  Hw set sequence number */
 		SET_TX_DESC_HWSEQ_SEL_8723B(pDesc, 0);
 	}
 
-	if (true == IsBTQosNull) {
+	if (IsBTQosNull) {
 		SET_TX_DESC_BT_INT_8723B(pDesc, 1);
 	}
 
@@ -3284,7 +3284,7 @@ void rtl8723b_fill_fake_txdesc(
 	/*  */
 	/*  Encrypt the data frame if under security mode excepct null data. Suggested by CCW. */
 	/*  */
-	if (true == bDataFrame) {
+	if (bDataFrame) {
 		u32 EncAlg;
 
 		EncAlg = padapter->securitypriv.dot11PrivacyAlgrthm;
@@ -3759,7 +3759,7 @@ void C2HPacketHandler_8723B(struct adapter *padapter, u8 *pbuffer, u16 length)
 #ifdef CONFIG_WOWLAN
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
 
-	if (pwrpriv->wowlan_mode == true) {
+	if (pwrpriv->wowlan_mode) {
 		DBG_871X("%s(): return because wowolan_mode ==true! CMDID =%d\n", __func__, pbuffer[0]);
 		return;
 	}
@@ -4119,7 +4119,7 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 			/*  keep sn */
 			padapter->xmitpriv.nqos_ssn = rtw_read16(padapter, REG_NQOS_SEQ);
 
-			if (pwrpriv->bkeepfwalive != true) {
+			if (!pwrpriv->bkeepfwalive) {
 				/* RX DMA stop */
 				val32 = rtw_read32(padapter, REG_RXPKT_NUM);
 				val32 |= RW_RELEASE_EN;
@@ -4274,7 +4274,7 @@ void GetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 			u32 valRCR;
 
 			if (
-				(padapter->bSurpriseRemoved == true) ||
+				padapter->bSurpriseRemoved  ||
 				(adapter_to_pwrctl(padapter)->rf_pwrstate == rf_off)
 			) {
 				/*  If it is in HW/SW Radio OFF or IPS state, we do not check Fw LPS Leave, */
-- 
2.7.4


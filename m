Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41484D1EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 05:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbfJJDkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 23:40:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44910 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfJJDkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:40:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id u12so2730978pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLjqcWxC5TPYbxiDmod0GjUGNGhzRXkDCxMiP0k/y4M=;
        b=RoMUnnrHlnveYX/jZlQAtR+6FbS045mU0V5Kg/SdIe/ZvAwRztUSkAqu7pd2ZfZT6n
         iL5u/9HIP+vCod9ya4u8h2xdcOhcMvf8YxibluipVNx/hsY2XLNshpNYiBiUnnjT0N07
         ifOuE19wz+XjmHCx4dZTTgTK6j6KqvOudKHpSf41X6XcVHDF56kp6C1kxA3XEyIXlwOV
         MR0tX3C193Ef6jXR7Tm/nFE6VMMA11kdttc1JK/A9hC1+HZVChrJACwYQ3+hYCOmRrly
         lvCZkSKo9NKeGrmIOhVh/tlBpX2aDgcyEX/SACWGx35t+Ttqn0096H0fDTSwIaJHxdm7
         VXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLjqcWxC5TPYbxiDmod0GjUGNGhzRXkDCxMiP0k/y4M=;
        b=FmM96DHGcNH9T/uBOw/C4x2IwsuUsxlCWq/ePmTgfs+xAMiel+HVTIjY79RLBeKgxM
         S+u/lT6hTO9ThNKh5mqHjtvUgRECX23F1sszUHyFafmItHWGqtyQn/t/4EdDa2Q62DlW
         DEpMaBN6x6b+NZ6JyeQTmJ7fXZipzXv/jhYNCF2BzOEjmOezdEknkaErsoxX7VpD09yd
         egOKDkdnBdJIfCMGD5pWc4UVHvJgOF5DSdlPqBBgHNKaA9zuVGJMTbiE8X6PyQugCEGl
         GGJnAaJVGmn4GVSQckpTfGsZtpgW3PmtvfaDGt+yLpvuftKSCEZfdF8UHYyGfFdKn3rg
         HqGg==
X-Gm-Message-State: APjAAAUWqSBe8dr9wlYWvIOlUatzmb7R+kErwF3+ypCEDTrBGgu/lveE
        UfUlnON3rNL9lMbi/WrFVm8=
X-Google-Smtp-Source: APXvYqxLod/We8ppMVvuRMQe371coWjhxlgxX1f69PDtnQFqJPV4zvMUeETTrtGnN7jHXX7Te2pTOg==
X-Received: by 2002:a62:60c6:: with SMTP id u189mr7722702pfb.85.1570678823784;
        Wed, 09 Oct 2019 20:40:23 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id k95sm3517741pje.10.2019.10.09.20.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 20:40:23 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH 1/4] staging: rtl8723bs: Remove comparisons to NULL in conditionals
Date:   Thu, 10 Oct 2019 06:39:21 +0300
Message-Id: <da71920fa80298badcced3519f2b84afbdd28a7e.1570678371.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570678371.git.wambui.karugax@gmail.com>
References: <cover.1570678371.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove most comparisons to NULL in conditionals in
drivers/staging/rtl8723bs/core/rtw_mlme.c
Issues reported by checkpatch.pl as:
CHECK: Comparison to NULL could be written

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 46 +++++++++++------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 0ac7712223af..7f27287223e8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -40,7 +40,7 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 
 	pbuf = vzalloc(array_size(MAX_BSS_CNT, sizeof(struct wlan_network)));
 
-	if (pbuf == NULL) {
+	if (!pbuf) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -185,7 +185,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 /* 	_irqL irqL; */
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
-	if (pnetwork == NULL)
+	if (!pnetwork)
 		return;
 
 	if (pnetwork->fixed == true)
@@ -220,7 +220,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
-	if (pnetwork == NULL)
+	if (!pnetwork)
 		return;
 
 	if (pnetwork->fixed == true)
@@ -633,7 +633,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 			/* If there are no more slots, expire the oldest */
 			/* list_del_init(&oldest->list); */
 			pnetwork = oldest;
-			if (pnetwork == NULL) {
+			if (!pnetwork) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
 				goto exit;
 			}
@@ -654,7 +654,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
-			if (pnetwork == NULL) {
+			if (!pnetwork) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
 				goto exit;
 			}
@@ -738,7 +738,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	privacy = pnetwork->network.Privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen) != NULL)
+		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -1166,7 +1166,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	psta = rtw_get_stainfo(pstapriv, pnetwork->network.MacAddress);
-	if (psta == NULL) {
+	if (!psta) {
 		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
 	}
 
@@ -1413,7 +1413,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			/* s3. find ptarget_sta & update ptarget_sta after update cur_network only for station mode */
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
-				if (ptarget_sta == NULL) {
+				if (!ptarget_sta) {
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
 					spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 					goto ignore_joinbss_callback;
@@ -1503,7 +1503,7 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta, u3
 {
 	u16 media_status_rpt;
 
-	if (psta == NULL)
+	if (!psta)
 		return;
 
 	media_status_rpt = (u16)((psta->mac_id<<8)|mstatus); /*   MACID|OPMODE:1 connect */
@@ -1561,7 +1561,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 
 	/* for AD-HOC mode */
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta != NULL) {
+	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
 
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
@@ -1570,7 +1570,7 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	}
 
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta == NULL) {
+	if (!psta) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
 		return;
 	}
@@ -1993,7 +1993,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
 
-	if (mlme->cur_network_scanned == NULL) {
+	if (!mlme->cur_network_scanned) {
 		rtw_warn_on(1);
 		return ret;
 	}
@@ -2006,7 +2006,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 	while (phead != mlme->pscanned) {
 
 		pnetwork = LIST_CONTAINOR(mlme->pscanned, struct wlan_network, list);
-		if (pnetwork == NULL) {
+		if (!pnetwork) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
@@ -2024,7 +2024,7 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 
 	}
 
-	if (candidate == NULL) {
+	if (!candidate) {
 		DBG_871X("%s: return _FAIL(candidate == NULL)\n", __func__);
 		ret = _FAIL;
 		goto exit;
@@ -2141,7 +2141,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	while (phead != pmlmepriv->pscanned) {
 
 		pnetwork = LIST_CONTAINOR(pmlmepriv->pscanned, struct wlan_network, list);
-		if (pnetwork == NULL) {
+		if (!pnetwork) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork == NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
@@ -2159,7 +2159,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 	}
 
-	if (candidate == NULL) {
+	if (!candidate) {
 		DBG_871X("%s: return _FAIL(candidate == NULL)\n", __func__);
 #ifdef CONFIG_WOWLAN
 		_clr_fwstate_(pmlmepriv, _FW_LINKED|_FW_UNDER_LINKING);
@@ -2200,13 +2200,13 @@ sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 	sint		res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
 
 	psetauthparm = rtw_zmalloc(sizeof(struct setauth_parm));
-	if (psetauthparm == NULL) {
+	if (!psetauthparm) {
 		kfree((unsigned char *)pcmd);
 		res = _FAIL;
 		goto exit;
@@ -2240,7 +2240,7 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
 	sint	res = _SUCCESS;
 
 	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
-	if (psetkeyparm == NULL) {
+	if (!psetkeyparm) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -2291,7 +2291,7 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
 
 	if (enqueue) {
 		pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
-		if (pcmd == NULL) {
+		if (!pcmd) {
 			kfree((unsigned char *)psetkeyparm);
 			res = _FAIL;  /* try again */
 			goto exit;
@@ -2672,7 +2672,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_SGI_20);
 
 	/* Get HT BW */
-	if (in_ie == NULL) {
+	if (!in_ie) {
 		/* TDLS: TODO 20/40 issue */
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 			operation_bw = padapter->mlmeextpriv.cur_bwmode;
@@ -2787,7 +2787,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	phtpriv->ht_option = true;
 
-	if (in_ie != NULL) {
+	if (in_ie) {
 		p = rtw_get_ie(in_ie, _HT_ADD_INFO_IE_, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			out_len = *pout_len;
@@ -2954,7 +2954,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		return;
 	}
 
-	if (psta == NULL) {
+	if (!psta) {
 		DBG_871X("%s, psta ==NUL\n", __func__);
 		return;
 	}
-- 
2.23.0


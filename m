Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F894DC309
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404240AbfJRKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 06:48:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54021 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfJRKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:48:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so5684755wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hMmhoG1hFboF7DXkU4ekkYimIsKSAcCusM/Xte7xdI8=;
        b=lgdlRz+uSVGQVaS3PxFgm2wIGiadmtRDfXH4cABLh/YbO7etdfmz5DmXZB5Bx5qV1v
         KNDekQflg+C0kb0PfbI807MJXfTfnMesPIP3j8PbUAn90aiwpUruLOm/FOtRYhieCvMg
         w5zFrYpSZqIRiuI95nwo57sPAqvLCsiZGTQeiRzzHsziQYrlVfSfyKiVOOoJv1R5BJD3
         RVCtCXjDfkZl2Dqc9++XDZYIWfIFoeTAvKw+FKnzs38pIxJhXwGo8BiEJNfXkjdeSTK3
         ZhiKQh+MtqupHax5yYUza9WO9RKgGdTBFyQT3WfFSuHwKJ07PM7AaN8ncUY7k03XCESB
         HxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hMmhoG1hFboF7DXkU4ekkYimIsKSAcCusM/Xte7xdI8=;
        b=hFlnnxf+SdVofgCRfmoldvi4ZydKciEefnF7jDGo/RM5dbGc8xYUIuoG1U+BgNcpky
         M7plZbc2dqmSTj0MWfIActrjxNR+ve+/ocRLenOqh2qH3shl5T8mcWDbYtgamnKs1xSS
         NhN1yoSF/w6gxHgft9y52Wnb4COC00pPIXOVnAmrEpmGEer/7je0mlsRTAqZCFTImjJ1
         ORl7ffPypQ8VXj4y05X91PtknvyjDPat1+TdAtaLKsWhSwuxj4a2TsTwuE/e0eDfgCdt
         r/HFYc5Bboh5xEUe3e5Szo1KiEJw/Os3dyYwXBF6PPzyoylXR5mLrnjy3hzvGl58hjSC
         Lk7w==
X-Gm-Message-State: APjAAAUdSyvBP5x4LbtKxN55cqYi8UB22HdL5V/1gO2bLtNMiPhaziiV
        Ghr/z2HU1Gj+s952+6CDBi0=
X-Google-Smtp-Source: APXvYqywrEmGtcfgiQCvsqP6fhxcZBflw6vimfyggHqVCGb4ju5EOaYdktfQNQtHNaT+OeGvm2eXMA==
X-Received: by 2002:a1c:6089:: with SMTP id u131mr7149905wmb.60.1571395719401;
        Fri, 18 Oct 2019 03:48:39 -0700 (PDT)
Received: from debian.office.codethink.co.uk. ([78.40.148.180])
        by smtp.gmail.com with ESMTPSA id z13sm4894356wrq.51.2019.10.18.03.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 03:48:38 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] staging: rtl8723bs: reduce stack usage of rtw_cfg80211_unlink_bss
Date:   Fri, 18 Oct 2019 11:48:37 +0100
Message-Id: <20191018104837.23246-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build of xtensa allmodconfig gives warning of:
In function 'rtw_cfg80211_unlink_bss':
warning: the frame size of 1136 bytes is larger than 1024 bytes

Instead of having 'select_network' structure as a variable use it as a
pointer.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 59ea4fce9a08..a25c535b6b4f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1410,16 +1410,17 @@ void rtw_cfg80211_unlink_bss(struct adapter *padapter, struct wlan_network *pnet
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 	struct wiphy *wiphy = pwdev->wiphy;
 	struct cfg80211_bss *bss = NULL;
-	struct wlan_bssid_ex select_network = pnetwork->network;
+	struct wlan_bssid_ex *select_network = &pnetwork->network;
 
 	bss = cfg80211_get_bss(wiphy, NULL/*notify_channel*/,
-		select_network.MacAddress, select_network.Ssid.Ssid,
-		select_network.Ssid.SsidLength, 0/*WLAN_CAPABILITY_ESS*/,
+		select_network->MacAddress, select_network->Ssid.Ssid,
+		select_network->Ssid.SsidLength, 0/*WLAN_CAPABILITY_ESS*/,
 		0/*WLAN_CAPABILITY_ESS*/);
 
 	if (bss) {
 		cfg80211_unlink_bss(wiphy, bss);
-		DBG_8192C("%s(): cfg80211_unlink %s!! () ", __func__, select_network.Ssid.Ssid);
+		DBG_8192C("%s(): cfg80211_unlink %s!! () ", __func__,
+			  select_network->Ssid.Ssid);
 		cfg80211_put_bss(padapter->rtw_wdev->wiphy, bss);
 	}
 }
-- 
2.11.0


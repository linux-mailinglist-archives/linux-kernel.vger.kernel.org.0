Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37961495F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jan 2020 14:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAYNer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jan 2020 08:34:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45991 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:34:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2541933pfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tNpax35bpayHCHzZcmmIYibH2bvx/xD5uxze2SDaHUw=;
        b=syjGSNlfVZKnp2hxifURfMNCVAmZ1supGURNmPeuMwlDw0hQEgG4fdbPE7TrxrzbPp
         MgDqfF1859dOucZ+WKIScH0BVSAfzJ2boQJuWduL6vV7IGsD0CGCR0tqYJNfOpsia5F4
         GWvRDzaff4rSKh7NweagYFgGdpGPsglwYBmc+mf2HAbm+vTDVmNQzO2yAVKZzREu+GTO
         NDeX3UaCwwDviMviMJONqnkQ6NCq0RUpOh/UgUPu6buwTEPHa3bkKgoWzYRmAq+HeExj
         OKbtChVFVNcxwK9Noc/X8WbWQmeM6ZTLI8Hdv4CdsAhL9U7wH+qwiLzGrgV0A+b0n4JY
         JzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tNpax35bpayHCHzZcmmIYibH2bvx/xD5uxze2SDaHUw=;
        b=eGoqjjz+7FRMWDu7RKUB+UGkOJ9/vlrephd0mwN8oclrSwRmBwsUGr9cdbJVPRtsDC
         0Pwlc0kZRL5dIUrbdzpv8wgr5IzGMwiiPOhM9bh+ZPDdry8lIViCo8mC9CJFLfkKnWMM
         o0PFLdjTRzdOXnKTD+sKGphd/JoeJJE6ObgNfrSszyf9TA9NMxIduZRcGtlc0gntVtU/
         pq8EaHkPRTulU8JWsi4dpEOeLQt62gvP9dXYqWk8kFM6xRaSISv+l0ut0oHzeBe/llVN
         oe9HmDj1aiCRXvDNE2ziosxCVsjTBfsEB/w9TD6oskRmXrLrjJyTkNPtUVWTXo1uLsMg
         PyWw==
X-Gm-Message-State: APjAAAX/EuB0nMvC+O+V8nFvyQScB39xmv9P2LCtT9qyDc++NR0AtqOv
        ppl6n/MlNueUXltlD+B7y+o=
X-Google-Smtp-Source: APXvYqw37uxMtb0KLfugrMcUPIi36U6kK68Otehdjy5yDKWFy5ta6tTHXjA06yr31iAPKGeIndec4w==
X-Received: by 2002:a63:1d5f:: with SMTP id d31mr2144271pgm.159.1579959286506;
        Sat, 25 Jan 2020 05:34:46 -0800 (PST)
Received: from google.com ([123.201.163.7])
        by smtp.gmail.com with ESMTPSA id i3sm10212006pfo.72.2020.01.25.05.34.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Jan 2020 05:34:45 -0800 (PST)
Date:   Sat, 25 Jan 2020 19:04:38 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, nishkadg.linux@gmail.com,
        wambui.karugax@gmail.com, julia.lawall@lip6.fr,
        benniciemanuel78@gmail.com, saurav.girepunje@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: core: fix condition with no effect
Message-ID: <20200125133438.GA4211@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix warning reorted by coccicheck
WARNING: possible condition with no effect (if == else)

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
  drivers/staging/rtl8723bs/core/rtw_mlme.c | 14 ++------------
  1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 71fcb46..5f110c3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2771,18 +2771,8 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
  	DBG_871X("+rtw_update_ht_cap()\n");
  
  	/* maybe needs check if ap supports rx ampdu. */
-	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1) {
-		if (pregistrypriv->wifi_spec == 1) {
-			/* remove this part because testbed AP should disable RX AMPDU */
-			/* phtpriv->ampdu_enable = false; */
-			phtpriv->ampdu_enable = true;
-		} else {
-			phtpriv->ampdu_enable = true;
-		}
-	} else if (pregistrypriv->ampdu_enable == 2) {
-		/* remove this part because testbed AP should disable RX AMPDU */
-		/* phtpriv->ampdu_enable = true; */
-	}
+	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1)
+		phtpriv->ampdu_enable = true;
  
  	/* check Max Rx A-MPDU Size */
  	len = 0;
-- 
1.9.1


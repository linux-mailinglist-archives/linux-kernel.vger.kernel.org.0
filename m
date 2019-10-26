Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA86E5A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 14:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfJZMMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 08:12:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40474 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfJZML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:11:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so4610878wmm.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sv48Bpld+S8ENWGw0IO9+9etbMm5gapIqiSKDckP1q0=;
        b=PMTXYAG2F+dIWW1dp/rANy+vW/rCk05UQ4NxwIHricgk80t0jgrQwdrFVZC9xILtdL
         DtY2BnQMx6/iAN/qcfVeusxe4whV7lbjZ5r8NgWWG6+MHAFTcyi8kmobRmGHGvM4OfKy
         mhoBAPPGD+fw1d76X8dea9nFH4L+T1cxU7xsoxjzqQEEZyA2PHOpOGCMuO78rFgDdhHb
         XvIizagsosP4iWNv6JVbGOimaI3dIclzOpR9udq5K3RyliiWp6wrm2kgW9b9JFOMLzvi
         cCn32cpknHWjwTkIjxLaDOPvjz8G3VxCe1OMJzu/P3zuBHHUshu97hpmO6Td/hXlg8jl
         qcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sv48Bpld+S8ENWGw0IO9+9etbMm5gapIqiSKDckP1q0=;
        b=MnM6UFnU7hpM+0PLX2yxev8MKGWS7w+RlM1T99StfXylrzUqMNiuqBM42VXJEBKRxz
         n/ikvRObRRPY223i8eD6LoNhHWyPxz3s/BS/h3kAfP7TPstfpCmza/wdskyp5kpgdloj
         /wQ44csIuhryVCLhQQLp5wZIdchgKIlPWbZ6pNgOJB1NLAveA22pJJOH6aLkIZs+bRVq
         Pxn2OxbyAnibZ+3mFwFZFtShmHZW+DWc8p7+f2RR4jOPjwfH93nrkNIDZyMkACgjdENe
         OpNlonIuvRsK1/vcUOvvCc+kvjcTtMrl7Sgh2SZllDYrgRaWau+b3n2V6Mw3vulRGyrd
         rcZg==
X-Gm-Message-State: APjAAAXyYq62tbd81m2CGRvg9leIk33fTQKHhm1cw95mO4V1hTkyaDit
        y09irFHiT2Ce3yVNAsUjJyr2rnTq
X-Google-Smtp-Source: APXvYqxoAC2iy/8fqgTsidv12j+N6zvpRu5Z6WZQ/dD7eJ73TYwYPSZ2XlM5Ro6No4yIPlUyakkMMQ==
X-Received: by 2002:a1c:39c1:: with SMTP id g184mr7639457wma.75.1572091915456;
        Sat, 26 Oct 2019 05:11:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id v8sm5789906wra.79.2019.10.26.05.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 05:11:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: rtl8188eu: remove ternary operator
Date:   Sat, 26 Oct 2019 14:11:33 +0200
Message-Id: <20191026121135.181897-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026121135.181897-1-straube.linux@gmail.com>
References: <20191026121135.181897-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using ternary operator to set variable res, use the value
of variable match (or the negation) directly to simplify the code and
improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 282c835a635c..3cadc46836e1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -504,9 +504,9 @@ bool rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 	spin_unlock_bh(&pacl_node_q->lock);
 
 	if (pacl_list->mode == 1)/* accept unless in deny list */
-		res = (match) ? false : true;
+		res = !match;
 	else if (pacl_list->mode == 2)/* deny unless in accept list */
-		res = (match) ? true : false;
+		res = match;
 	else
 		res = true;
 
-- 
2.23.0


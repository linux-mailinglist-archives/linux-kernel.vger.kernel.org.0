Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C69E5A6A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfJZMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 08:11:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50652 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfJZMLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:11:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so4860731wmk.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrtKL5FLpbI/Kv7Prf5m0FfT7aQNnb/mhwX9jm5QzjY=;
        b=H1bmO+672auiRTfi8IzBBR6BG5Jt5CFw062RwUFwDum/lcoEs9XE23YdzDFaAqaMSF
         YLMPnz5YbAcFNzy2VJFwAwhgFaQFMR5QpkPjN1b2id87MGj3/DstA3VA50XDtBjCuFoq
         aI0uNLnmGn2o6unYPsaelDgvS1/DZz1862Pp5d02/mBSZw9uhTPU9Wulp7zovuiqg8Rb
         VSxuJTfxuo0MpxvuhaK2oqEsFG7LScgAgh5KfS0FdipzVJDtJHHKAt/eQ5AyMUxtBDdn
         b61wvgww0H06JQxW0nCPFlTIWf3zm66/ox5p4Nl3PMVFkBnCioiZF/Mc3lmHIdv5bRJO
         pDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrtKL5FLpbI/Kv7Prf5m0FfT7aQNnb/mhwX9jm5QzjY=;
        b=m3t60BuTsa2vgCgOJvTzevDe5oeP0llQA+cmKKeASCNazHHZUC6PCdFMbwp2i1J7k+
         75Iow5X++ElPr04EJN0jbWfJc7przCSpWKRQnQQd19Go8EV4yvnD+wt+j8JhJN+LjbkX
         B7r1wxDQ9peWblQwX68U+vNz7h+sdOavW73DcqqycW2DKef7NrxbWMDKXUG+NXu9sVER
         koPnFqdZpmRGFkPMRcRDGs8BqOyDUlRjOXGB5HzhNZpiu2Ik69u/7ci65aZm4GIe2UCp
         V5j9Y/EnZK9vYsBmTWnDNA7inkJ7+sTmTx0Pw8DBGO2ReBtv5idMbsc8Cq2aRMigpG8p
         0qaQ==
X-Gm-Message-State: APjAAAXtpy/uMATJ9eIIb+TDfrnpOEpsh5tTIt9kSe02++o4kmFOl3Ny
        Mdm6SAnpMZ+qG1gQEke+Xdk=
X-Google-Smtp-Source: APXvYqxZ5yzfpPVbuUPCYjGomhgeFgFlBsrzZPBDEVPojOXP6teEwPbm5tR+XMI+HsB5KNkTFkZw0g==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr4218343wmi.109.1572091913616;
        Sat, 26 Oct 2019 05:11:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id v8sm5789906wra.79.2019.10.26.05.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 05:11:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/7] staging: rtl8188eu: rename array bcast_addr
Date:   Sat, 26 Oct 2019 14:11:31 +0200
Message-Id: <20191026121135.181897-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026121135.181897-1-straube.linux@gmail.com>
References: <20191026121135.181897-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename array bcast_addr to be more consistent in variable naming.
In other places in this file buffers for broadcast addresses are
named bc_addr as well.

bcast_addr -> bc_addr

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 394b887a8bde..157ae2f355ff 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -450,10 +450,10 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 {
 	struct sta_info *psta;
 	u32 res = _SUCCESS;
-	u8 bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	psta = rtw_alloc_stainfo(pstapriv, bcast_addr);
+	psta = rtw_alloc_stainfo(pstapriv, bc_addr);
 
 	if (!psta) {
 		res = _FAIL;
-- 
2.23.0


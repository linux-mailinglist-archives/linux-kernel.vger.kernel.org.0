Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4D1309B3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jan 2020 20:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgAETuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 14:50:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41176 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgAETuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:50:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so47430269wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 11:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHs7aC8wKxxQ1KYTS0Lt8AmWzqctfuFR0vRBtJMaHp0=;
        b=u9UGmjI98W4SbE+8AR6XF5UlmeEnahbrKOcABdVsge/5rqrJZ9L9GmsCn9bjockgSe
         e5hHKK61RlZj8/vKNJrSQd3CgojDSFcvDXTAuVZdewzM15+Pl593YSmWF+Gza9VO9+66
         S/K1abLY2ux0jcMaEN/WLshwqUbLXhg3qT2ITBc2zuL84hRJysMNuiz2pO17uNsxwwN7
         XJ3s5AJu9xaG4MhC9QX87Q6Ie3PTfoD7ZC+9HOj7Bo9lk064KCGEf4G1JxiMI4Cf17Fp
         lMCjbJ8yGzzpo0XC2qNrvd5DnjNdSp6/U8uWQcwOYWItefrEgM2AB68sYBTGcByx5bFi
         LXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHs7aC8wKxxQ1KYTS0Lt8AmWzqctfuFR0vRBtJMaHp0=;
        b=D8WWR6THAxk85KutziHf07xzlOtyDD27vsXiqZ9asG1vgQBUaq27+vdjs5NZ1lhrbC
         ZQYHNCDTqx01I+L9sGTx1wJxgcD/IC4qA8MP7KUvFpKf292bQvbLGk4595TRXVri5sv1
         Hr4NdrKkmdmmB+jYoM3VMqICc9wl57epvwmwKWk3ojQRViLzYDRIVz80i9dxexBhS3DR
         nOCOgh3rOOW/QsaRg9k/eNga9RkIa+dsc10FLEedHBw4G5ZkK4yNbDHx6KdJHRDLf3wp
         fUHKGuEftP3rGzIt/6VmPmyYZUanZ5VESUdluzCE8WFZsXWtu36vqf+IBucVrzyhBXtZ
         i90Q==
X-Gm-Message-State: APjAAAXVsByDLEXruH6/8jaZlTB/DHCHreT97YJ6Ggl0idgDI35mKWXn
        hF0Mw4nblhjlK768uU9PAfI=
X-Google-Smtp-Source: APXvYqyCLkyjUR73TqjhKU80IrH5ADa98gj+c1NFLXI7ZYwKTse0DbqwxBCDe3Oq/BBi5d425rP5Bw==
X-Received: by 2002:adf:f288:: with SMTP id k8mr105177993wro.301.1578253807894;
        Sun, 05 Jan 2020 11:50:07 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-140-065.002.204.pools.vodafone-ip.de. [2.204.140.65])
        by smtp.gmail.com with ESMTPSA id s3sm20549653wmh.25.2020.01.05.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 11:50:07 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: refactor rtl88eu_dm_update_rx_idle_ant()
Date:   Sun,  5 Jan 2020 20:49:36 +0100
Message-Id: <20200105194936.5477-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200105194936.5477-1-straube.linux@gmail.com>
References: <20200105194936.5477-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor rtl88eu_dm_update_rx_idle_ant() to reduce indentation level
and clear line over 80 characters checkpatch warnings.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c | 56 ++++++++++----------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
index 7bfba7692ab8..a55a0d8b9fb7 100644
--- a/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
+++ b/drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
@@ -154,35 +154,37 @@ void rtl88eu_dm_update_rx_idle_ant(struct odm_dm_struct *dm_odm, u8 ant)
 	struct adapter *adapter = dm_odm->Adapter;
 	u32 default_ant, optional_ant;
 
-	if (dm_fat_tbl->RxIdleAnt != ant) {
-		if (ant == MAIN_ANT) {
-			default_ant = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ?
-				       MAIN_ANT_CG_TRX : MAIN_ANT_CGCS_RX;
-			optional_ant = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ?
-					AUX_ANT_CG_TRX : AUX_ANT_CGCS_RX;
-		} else {
-			default_ant = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ?
-				       AUX_ANT_CG_TRX : AUX_ANT_CGCS_RX;
-			optional_ant = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ?
-					MAIN_ANT_CG_TRX : MAIN_ANT_CGCS_RX;
-		}
+	if (dm_fat_tbl->RxIdleAnt == ant)
+		return;
 
-		if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
-			phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
-				       BIT(5) | BIT(4) | BIT(3), default_ant);
-			phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
-				       BIT(8) | BIT(7) | BIT(6), optional_ant);
-			phy_set_bb_reg(adapter, ODM_REG_ANTSEL_CTRL_11N,
-				       BIT(14) | BIT(13) | BIT(12), default_ant);
-			phy_set_bb_reg(adapter, ODM_REG_RESP_TX_11N,
-				       BIT(6) | BIT(7), default_ant);
-		} else if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV) {
-			phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
-				       BIT(5) | BIT(4) | BIT(3), default_ant);
-			phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
-				       BIT(8) | BIT(7) | BIT(6), optional_ant);
-		}
+	if (ant == MAIN_ANT) {
+		default_ant = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ?
+			       MAIN_ANT_CG_TRX : MAIN_ANT_CGCS_RX;
+		optional_ant = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ?
+				AUX_ANT_CG_TRX : AUX_ANT_CGCS_RX;
+	} else {
+		default_ant = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ?
+			       AUX_ANT_CG_TRX : AUX_ANT_CGCS_RX;
+		optional_ant = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ?
+				MAIN_ANT_CG_TRX : MAIN_ANT_CGCS_RX;
 	}
+
+	if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
+		phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
+			       BIT(5) | BIT(4) | BIT(3), default_ant);
+		phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
+			       BIT(8) | BIT(7) | BIT(6), optional_ant);
+		phy_set_bb_reg(adapter, ODM_REG_ANTSEL_CTRL_11N,
+			       BIT(14) | BIT(13) | BIT(12), default_ant);
+		phy_set_bb_reg(adapter, ODM_REG_RESP_TX_11N,
+			       BIT(6) | BIT(7), default_ant);
+	} else if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV) {
+		phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
+			       BIT(5) | BIT(4) | BIT(3), default_ant);
+		phy_set_bb_reg(adapter, ODM_REG_RX_ANT_CTRL_11N,
+			       BIT(8) | BIT(7) | BIT(6), optional_ant);
+	}
+
 	dm_fat_tbl->RxIdleAnt = ant;
 }
 
-- 
2.24.1


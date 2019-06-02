Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDEB322F9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 12:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfFBK0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 06:26:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41415 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfFBK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 06:26:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so8871642pfq.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jy5f39JtoflmsGwijkPz6ujk/wlkmv8ts/C2dFv0hM8=;
        b=m7mhJyccioQMpG23q1CTQaP/EX2tcJhFGJRPNKwzO3Aghoupag2/KiG2H9nSLwqsfu
         pxWJrKq3LyzOZiIsWa2EJotSjLGJd4J0kKgZ6VWEDR4ir2nkdPA/0/ydp1M25GEUxV9j
         dNBYGkvxf6R0ZFRcLPLf86xClu4UsGyCU3TslqlRefH5z5fpZegeuy3DocvsJ+BV9ygh
         vVRQnt9KcncFpL0rXtDkaPn79E+l/BP9ymqXYECYh7DyI/o4yuyJWMWbPGCVmLX4/FaL
         i0gTBDB2t3+m0YWIUQLCoTD2kxtxrNrY0LHltQ9vYZsleX3rzkDq1ewniytq/4D2yybP
         TUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jy5f39JtoflmsGwijkPz6ujk/wlkmv8ts/C2dFv0hM8=;
        b=DBTCXNA3u1lgs59BymqM6IFOnGsKyTUJVVLQ4hPiCMDhI8pyY4qK5Ds61Vl+pFiaCp
         ea5CYbd2lOfsHHJ7hi1ubh0CSxTzs1Fj6YgIwVi5xSCr1pq8cOKLN9RsuBQ2mNGodlyd
         RwcUkW51eB7jspjakCRmtIH6jGp+4W6Cv+ggw2K2Sfl9jnMi1mxt06BfXqgyl6dA2dTL
         N/4mO6dl8UZLiWDx/pyPQqVcIPvjGEARleaI/Smo05mCpeH6Js5QgH+gC+JI+8jluCem
         9qvXm/x1GWXyse+8LgP+Uysau9jPdlhG82QqNEYQsLU6gT3b7eDhG9ej8FsyW3buRsTc
         bd5Q==
X-Gm-Message-State: APjAAAU0kGyQrbqbP1Tm9fDvSmmQ+I+4fJWpGO/r6meiO5DUy7+mIUpQ
        JPYC4Gx11pv9zgbqTp958YzaE1BD
X-Google-Smtp-Source: APXvYqxhSGEFAWDmTRJ1HfYXhanq+dvFmUABUlEPn574evtQFbYt14PO8dZWVcGG8ttdkLAYIzkPdw==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr20813846pgp.56.1559471204488;
        Sun, 02 Jun 2019 03:26:44 -0700 (PDT)
Received: from localhost.localdomain ([117.192.23.157])
        by smtp.googlemail.com with ESMTPSA id j13sm12221099pfh.13.2019.06.02.03.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 03:26:44 -0700 (PDT)
From:   Deepak Mishra <linux.dkm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux.dkm@gmail.com, himadri18.07@gmail.com,
        straube.linux@gmail.com
Subject: [PATCH v2 5/9] staging: rtl8712: Fixed CamelCase renames IsrContent to isr_content
Date:   Sun,  2 Jun 2019 15:55:34 +0530
Message-Id: <c56907d81f9452eec28f7b26eac54df185fb5735.1559470738.git.linux.dkm@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559470737.git.linux.dkm@gmail.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes CamelCase IsrContent to isr_content as suggested by
checkpatch.pl

Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
---
 drivers/staging/rtl8712/drv_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 5360f049088a..a5060a020b2b 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -148,7 +148,7 @@ struct _adapter {
 	bool	driver_stopped;
 	bool	surprise_removed;
 	bool	suspended;
-	u32	IsrContent;
+	u32	isr_content;
 	u32	imr_content;
 	u8	eeprom_address_size;
 	u8	hw_init_completed;
-- 
2.19.1


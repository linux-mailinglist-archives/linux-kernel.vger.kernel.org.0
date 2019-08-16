Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1C8FFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfHPKKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 06:10:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46449 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfHPKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:10:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so2123521pgv.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BziYCDS7YU8vYUQWJ4hyE7rgzHXY7u3/I6t4rVAc7Js=;
        b=R/BjKxui66lKaPED3pI5oRmo9WbpFno/jivG60cueCwZVAbNmgMlimnp5k74+OJjib
         5abcqYanAtnFBMcE0+mg/qAV5bloh75/Ek0FeTy7Wqu/rhr0tuscqHCDZONoXcx/7Exk
         hlrykyaUzQRJtq5FXMPPmdgOnepFMvmi24yFmrH67dC/8TvYXuf9nwS3xJk2eeR4J1+v
         S2m0BvtEImg1hR2oq6/tFHqZ0mJ6ErE7NBiTCOp8lWgSwfwWmSwNAI9sPLsyImio9YhD
         WQw00PA5Pn9G2m7YusEMEehyFAcmEfWRsxDFunYRiEw+4H+DMF2cx302fdEBCAArohL5
         McUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BziYCDS7YU8vYUQWJ4hyE7rgzHXY7u3/I6t4rVAc7Js=;
        b=KRb8Cw+X9cYOKnh3B2PFpmdWfZsBxUeb88utP+qgroXsTvFehYrQ5SYct9WqLf4Tt+
         NT0xJAOE4sLGYq96bCIXdorFoMRLPmFnt9J+RDQPOaGM0x3Q6n7IJfauAMk+wJgXw1nb
         tkB/3LBMj7KsVtt/t3AzdGegP2gjykctLcdi6oKQLhKta8YbJ6QMT1DbAJQoPWxcvofm
         ssInXoP5xs/w8wC35vxD6WukPJysXyXAtIceny199ZlQWR6TKcCNfpLv6MRqOTb+MuGX
         SaHYvkvhiR5Pg3CaC3Bw3xpHjOOOaaw6DOGaVrjJBNlPdW4oqZ4Q3wSiNAsThb/iNhzJ
         50gg==
X-Gm-Message-State: APjAAAVvpoPYadsg8GQX87mI5Qbi3ajsfcFq/abhkgs4EGu2HcTFx/yp
        R3/EkIufNkkhBsrwNYe8JV+shw==
X-Google-Smtp-Source: APXvYqxFJrZW6vR3K7MQzvy2yqkjKQMoEqS27lWzPrzxB2qLPWBt40nkwWhFIYENuxo4iYIo5SoWOA==
X-Received: by 2002:a17:90a:8081:: with SMTP id c1mr6584848pjn.62.1565950236764;
        Fri, 16 Aug 2019 03:10:36 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id r75sm6230043pfc.18.2019.08.16.03.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 03:10:36 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2] rtw88: pci: Move a mass of jobs in hw IRQ to soft IRQ
Date:   Fri, 16 Aug 2019 18:09:04 +0800
Message-Id: <20190816100903.7549-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAPpJ_edibR0bxO0Pg=NAaRU8fGYheyN8NTv-gVyTDCJhE-iG5Q@mail.gmail.com>
References: <CAPpJ_edibR0bxO0Pg=NAaRU8fGYheyN8NTv-gVyTDCJhE-iG5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a mass of jobs between spin lock and unlock in the hardware
IRQ which will occupy much time originally. To make system work more
efficiently, this patch moves the jobs to the soft IRQ (bottom half) to
reduce the time in hardware IRQ.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
v2:
 Change the spin_lock_irqsave/unlock_irqrestore to spin_lock/unlock in
 rtw_pci_interrupt_handler. Because the interrupts are already disabled
 in the hardware interrupt handler.

 drivers/net/wireless/realtek/rtw88/pci.c | 33 +++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 00ef229552d5..0740140d7e46 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -866,12 +866,28 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 {
 	struct rtw_dev *rtwdev = dev;
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	u32 irq_status[4];
 
 	spin_lock(&rtwpci->irq_lock);
 	if (!rtwpci->irq_enabled)
 		goto out;
 
+	/* disable RTW PCI interrupt to avoid more interrupts before the end of
+	 * thread function
+	 */
+	rtw_pci_disable_interrupt(rtwdev, rtwpci);
+out:
+	spin_unlock(&rtwpci->irq_lock);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
+{
+	struct rtw_dev *rtwdev = dev;
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	unsigned long flags;
+	u32 irq_status[4];
+
 	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
 
 	if (irq_status[0] & IMR_MGNTDOK)
@@ -891,8 +907,11 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	if (irq_status[0] & IMR_ROK)
 		rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
 
-out:
-	spin_unlock(&rtwpci->irq_lock);
+	/* all of the jobs for this interrupt have been done */
+	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	if (rtw_flag_check(rtwdev, RTW_FLAG_RUNNING))
+		rtw_pci_enable_interrupt(rtwdev, rtwpci);
+	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -1152,8 +1171,10 @@ static int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_destroy_pci;
 	}
 
-	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler,
-			  IRQF_SHARED, KBUILD_MODNAME, rtwdev);
+	ret = devm_request_threaded_irq(rtwdev->dev, pdev->irq,
+					rtw_pci_interrupt_handler,
+					rtw_pci_interrupt_threadfn,
+					IRQF_SHARED, KBUILD_MODNAME, rtwdev);
 	if (ret) {
 		ieee80211_unregister_hw(hw);
 		goto err_destroy_pci;
@@ -1192,7 +1213,7 @@ static void rtw_pci_remove(struct pci_dev *pdev)
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_destroy(rtwdev, pdev);
 	rtw_pci_declaim(rtwdev, pdev);
-	free_irq(rtwpci->pdev->irq, rtwdev);
+	devm_free_irq(rtwdev->dev, rtwpci->pdev->irq, rtwdev);
 	rtw_core_deinit(rtwdev);
 	ieee80211_free_hw(hw);
 }
-- 
2.20.1


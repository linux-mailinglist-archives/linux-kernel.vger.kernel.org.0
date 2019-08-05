Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF9D80C03
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfHDSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 14:32:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39043 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfHDSc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 14:32:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so38501039pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1Gvzhgkq3uypUYE0BK54gI1jvg+vB6OQn9HgeGo1C4=;
        b=uiKScfPaDZyKdF3E6bF2WUbY+A+cK/IXsc+XjPVPHuEMba1IHc3yHGjLEEb8tFDXxk
         6w9dLIIM9ET/Jvg16knHG0mFyUtY+Wil9NBk0zaTDEsddqGYiZ8VErWwIkH3eiiVYjpS
         O0sSpV3nAk8yTHmT3RuOTVdRBotUYbvdfIK5UFDG8DB9dSuam1rdkJEVoI0yum5SEsV1
         mfAWuIm80AIwxHVOawLgisIxUtyvkcTbJdQCDRLNcvtVFdQcGNrqtDLu62tEvgoSwr+J
         eq9tv+iNUiFF2MQR+jbPDHa/bAFOGaix0l92loEPvock4Pksc0WW81rw+vyw7bNd/tXR
         SwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1Gvzhgkq3uypUYE0BK54gI1jvg+vB6OQn9HgeGo1C4=;
        b=GzeTB4xpUukRonKNQOQfZYweDfn5P4z3flO98CZirZFwurPXuiy8E3HkAOqXxw40wv
         ZA2ivvxxL2Y5yxBYGxiLfJfiyFwv9pcQcGIRKWA3UfHUYRSUf6GiX8QX04n7lQ9auv1v
         +jIHkXG98LlgOWDtX2xdcqrEYKUmcNgbQBGm+RoxG386rGJe2jwbWyOwXzDn6bK7JNaV
         eduiXSKgGzAeVIL4odiRzhuCJ9lTxqZ/eKJkorXsCB8qXiUJ/ePid0LyBaiSB9HHNZAj
         oBJ2EKaMhlljylGvmhUMuklx5IZQySWK6UscETcHTYilrmnIGdGnkHCLTgfSIG/MNB5I
         uS3g==
X-Gm-Message-State: APjAAAXju/5e/K3yLOwDUlaPiFkxIMm0n9uA1BApiek+SfH/NfD5BBmn
        IuVmL4sLKcn8iiKwjus/Q9A=
X-Google-Smtp-Source: APXvYqwK5WbGPiyo0oQxjvJnrjYzvciabM3qjZqtVBvYB0ircVXV3sf8ELBElcx0XW2M0wHMW+pPVw==
X-Received: by 2002:a62:1ccd:: with SMTP id c196mr70133403pfc.102.1564943577435;
        Sun, 04 Aug 2019 11:32:57 -0700 (PDT)
Received: from localhost.localdomain ([116.75.76.55])
        by smtp.gmail.com with ESMTPSA id w2sm71009773pgc.32.2019.08.04.11.32.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 11:32:56 -0700 (PDT)
From:   Giridhar Prasath R <cristianoprasath@gmail.com>
Cc:     Giridhar Prasath R <cristianoprasath@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433 line over 80 characters in multiple places
Date:   Mon,  5 Aug 2019 05:32:45 +0530
Message-Id: <20190805000248.4902-1-cristianoprasath@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warnings:

WARNING: line over 80 characters
FILE: drivers/staging/pi433/pi433_if.h

Signed-off-by: Giridhar Prasath R <cristianoprasath@gmail.com>
---
 drivers/staging/pi433/pi433_if.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
index 9feb95c431cb..915bd96910c6 100644
--- a/drivers/staging/pi433/pi433_if.h
+++ b/drivers/staging/pi433/pi433_if.h
@@ -117,9 +117,14 @@ struct pi433_rx_cfg {
 
 	/* packet format */
 	enum option_on_off	enable_sync;
-	enum option_on_off	enable_length_byte;	  /* should be used in combination with sync, only */
-	enum address_filtering	enable_address_filtering; /* operational with sync, only */
-	enum option_on_off	enable_crc;		  /* only operational, if sync on and fixed length or length byte is used */
+	/* should be used in combination with sync, only */
+	enum option_on_off	enable_length_byte;
+	/* operational with sync, only */
+	enum address_filtering	enable_address_filtering;
+	/* only operational,
+	 * if sync on and fixed length or length byte is used
+	 */
+	enum option_on_off	enable_crc;
 
 	__u8			sync_length;
 	__u8			fixed_message_length;
@@ -132,10 +137,14 @@ struct pi433_rx_cfg {
 
 #define PI433_IOC_MAGIC			'r'
 
-#define PI433_IOC_RD_TX_CFG	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
-#define PI433_IOC_WR_TX_CFG	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR, char[sizeof(struct pi433_tx_cfg)])
+#define PI433_IOC_RD_TX_CFG	_IOR(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_tx_cfg)])
+#define PI433_IOC_WR_TX_CFG	_IOW(PI433_IOC_MAGIC, PI433_TX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_tx_cfg)])
 
-#define PI433_IOC_RD_RX_CFG	_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
-#define PI433_IOC_WR_RX_CFG	_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR, char[sizeof(struct pi433_rx_cfg)])
+#define PI433_IOC_RD_RX_CFG	_IOR(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_rx_cfg)])
+#define PI433_IOC_WR_RX_CFG	_IOW(PI433_IOC_MAGIC, PI433_RX_CFG_IOCTL_NR,\
+char[sizeof(struct pi433_rx_cfg)])
 
 #endif /* PI433_H */
-- 
2.22.0


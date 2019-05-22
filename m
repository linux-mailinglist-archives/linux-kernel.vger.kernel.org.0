Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166E525B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 02:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfEVArR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 20:47:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36907 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 20:47:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id d10so439636qko.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hBzsh7RjbZaBI7Dj1vWsPMY7clgyplPvG9IzYiE5AEw=;
        b=a9Xkv9PsmxK0qiE5pYsPclh6XiPQ/3PJ9Y2thxmu1/No9l6v/LNogVR5SIVLIditxT
         pBhPWnmlBpKxNiOPYTKOuFpk7Hq3vSny9pTYD9LphgX9HtsCUnv7a4nytSj9gspyGVaF
         2lu/Wl/L3QcabvKMWImNubBwnybtRQN9+k78kMUGbfFSlxpnda3jaE125+m7cb6MhE0o
         oDiOXLO/wKbcrhh89hdePula6L/+G22VIq8PBRoBrg757pLV9ET0VxamM/a9yF8IVyLE
         0c4ba4/B3/Ud9CUA6Te0/A9Dvy88Lun3+CS7pGGasHW6OauJbIfNvyaRCbaR/Pd2KArX
         DYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hBzsh7RjbZaBI7Dj1vWsPMY7clgyplPvG9IzYiE5AEw=;
        b=SLLfGTMfPTpxyVY+WIeIbFZfi8qZ1Qc+lcG+Ozz9hCbtyELUQjrrd8qhPlJL52SDIZ
         jAtlciSiak80Nm36PwouXs9XGWRBP5UMCOxPQJcJe98grdr5lvNOSNSatN5XNNURYfGq
         F1A0Bk8KcgCcme2v9Yb+Uy4y+uSsS841BxBUOyiM5ZAeuVu+xpsT7TeVqaIASUhBbTsS
         Rx/bo5s8kQShBpMEJxSqJz3ZGD85q2RJT8iu96jeiUYfAS7TS0TDP65BRzZW9g8TOssh
         nszXZVFu9EzqE/N84MPIXE8nwp0TcHt5x/BK//Q2Pw6aTes/mL6UJFqUbA5513Fxqx87
         UBpw==
X-Gm-Message-State: APjAAAUVdSsb6gwBHqtlfKlFneeT++wQrT2J7/XbyM/GaD1EYJeb7OKw
        L67CH4IxoGdbV/ugr00+l0c=
X-Google-Smtp-Source: APXvYqxLc1VNx9VHbbR7lt5FbsTJZmCD6LNmgr8UeGXzyvS5HPcB4jztdQ6n5uCcRtESWokWmIn2Tw==
X-Received: by 2002:a05:620a:3:: with SMTP id j3mr47497441qki.95.1558486035768;
        Tue, 21 May 2019 17:47:15 -0700 (PDT)
Received: from Void.ic.unicamp.br (wifi-177-220-85-147.wifi.ic.unicamp.br. [177.220.85.147])
        by smtp.gmail.com with ESMTPSA id o10sm10115269qtg.5.2019.05.21.17.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 17:47:14 -0700 (PDT)
From:   Fabio Lima <fabiolima39@gmail.com>
To:     gregkh@linuxfoundation.org, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Fabio Lima <fabiolima39@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Add missing blank lines
Date:   Tue, 21 May 2019 21:46:55 -0300
Message-Id: <20190522004655.20138-1-fabiolima39@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves the following warning from checkpatch.pl
WARNING: Missing a blank line after declarations

Signed-off-by: Fabio Lima <fabiolima39@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 9f8446ccf..853362381 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -382,6 +382,7 @@ ssize_t proc_set_roam_tgt_addr(struct file *file, const char __user *buffer, siz
 	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
 
 		int num = sscanf(tmp, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", addr, addr+1, addr+2, addr+3, addr+4, addr+5);
+
 		if (num == 6)
 			memcpy(adapter->mlmepriv.roam_tgt_addr, addr, ETH_ALEN);
 
@@ -1348,6 +1349,7 @@ int proc_get_btcoex_dbg(struct seq_file *m, void *v)
 	struct net_device *dev = m->private;
 	struct adapter *padapter;
 	char buf[512] = {0};
+
 	padapter = (struct adapter *)rtw_netdev_priv(dev);
 
 	rtw_btcoex_GetDBG(padapter, buf, 512);
-- 
2.11.0


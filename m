Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78A75CA18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGBH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 03:57:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33934 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBH5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:57:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so7860532pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xRxgUpoXT1ALTuAFgtLyhDcF8m82X8iHnPfbbq6cJwI=;
        b=q6tXprmBUuV+ReG3S2QN32JZYZLMw0FgSBTzRhhwb8mQ0Z9B80tUs2NRedze1LvfHX
         qTA9kdxkhhE59hOmJXu20GGr9jeCz55G+EdAZsW1pYtodOzafAjsCediWSBdxoPS2FkZ
         /nWbspb52M9vG/fiOUPTcBWvODgs1u5HCp3E0GyLfZSmjf4Ff9MaxlajLEzwXBc8JM5N
         T8OWsnRCqJ2uagmbTAkue+/PvJT5JrldY8ZVvq5EraEu8Fb0d84IN31FfKifux66dQoV
         b44LZNxEBNhj/0BnXw2Faht68+E43LTZrHMY/v/0g/r/5wqh4PnImWbaIdj+aSQPxKKG
         jukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xRxgUpoXT1ALTuAFgtLyhDcF8m82X8iHnPfbbq6cJwI=;
        b=NpNOScPL82TwFaxPWH7vUGEauArR8aMg0ZWGP1AQYoc9cpI9dJbznb27IWgsIypPaT
         HfIn97YXrzsquoza6b2cRD5zDpIxvl6Be9wos2+s3Q39JwuelLrhyYmDFRG9TOe5baXW
         2dXGP41TzitDHZirQpMYELQas8lAgHSxQtNUFcn5tCUxqCob3Qs0Xc5hNrnFvbPv9nzg
         ldTwhQzYKnOtPm8NcbMNImknWooePD1PM2bN814T45fakQbmP211z7cebIdU7xHm1xuO
         xu3Enp2bVRdBDk2LdmZPkIHmadVCuCt4mDTK+2ZO8f9vfQgvLp2tMQN8D1stJG3jUl80
         pVnQ==
X-Gm-Message-State: APjAAAX4lAbvmQ9PfEvQgoPv1VCKG4LMBMmKhe/c5hhwhIjhKGLNu7/o
        d/lU2HKvE30OaTpEeM6dQugXNfNI/Io=
X-Google-Smtp-Source: APXvYqzzXnIfyFzUIeSN451jsMB7+VHqB2M0rFVAb+4USZAiPCbRiWNRyxmmSMZCmds9Evs3MjRqeQ==
X-Received: by 2002:a17:90a:cf0d:: with SMTP id h13mr4036939pju.63.1562054225157;
        Tue, 02 Jul 2019 00:57:05 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id e10sm13322608pfi.173.2019.07.02.00.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:57:04 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 03/27] atm: idt77252: remove memset after dma_alloc_coherent
Date:   Tue,  2 Jul 2019 15:56:58 +0800
Message-Id: <20190702075658.23648-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/atm/idt77252.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 43a14579e80e..df51680e8931 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -1379,7 +1379,6 @@ init_tsq(struct idt77252_dev *card)
 		printk("%s: can't allocate TSQ.\n", card->name);
 		return -1;
 	}
-	memset(card->tsq.base, 0, TSQSIZE);
 
 	card->tsq.last = card->tsq.base + TSQ_NUM_ENTRIES - 1;
 	card->tsq.next = card->tsq.last;
-- 
2.11.0


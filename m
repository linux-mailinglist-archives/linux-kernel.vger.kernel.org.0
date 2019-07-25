Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710EA74760
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 08:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfGYGhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 02:37:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32822 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYGhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:37:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so33766561lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 23:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qDTb1Rzvoo33PFd/6lloqawvXmbYh3nthJRHEPH6N/I=;
        b=Z+NyyiM46NCiDn9Xz14fDBt92EzUlU0sS9f0c3Qpxvo7/bxSgd9eK5k4ZM8+uz2sdZ
         cgzUEW8yQ9xBLh/iQYPeg7TAQm/fpWVDshF5+25qNqfkwEzfdD/des6RccrpIveoLF27
         8bPGfCPWXlglGcsPBNdJLyJ93pLrWP0C5CNXSwRZ3hiIGusRlEmZVDznSDklUYSaG7BC
         CMhyHrQcV1wXVMX1hgJPSGXnVqUGZ5vfKb3+YsJcAgAwWwg+TL15sbb0kI4GSMGq37Bo
         U0IV4/NWb2nXzJ8dhcdnAlCSWK5mpCHY70iX22NQhG/hNQfdS153kVcrydEUfVdhivF4
         WESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qDTb1Rzvoo33PFd/6lloqawvXmbYh3nthJRHEPH6N/I=;
        b=rNhfu5j3ByLhVC7d/jzsTFhFyryikxagZw/hm0W8ds5fBlkyY04HqBp8SST2r3PjJ6
         DV6z5hc2N4ks93d+5QHjV1jhFfTCrv5yUh4ZEMQB3cIzN5D80VYPCEJz02JkhqD5Bgeo
         /owHgdFTgt9mHJocDcm7pi+WyOdJfPL/AaycG54wZVqt+TRRjh8dtk2Et3VolDTouGNq
         Qb4TrpVpX9oONLWv9PdiSdPCLwwd7wc4FDrxs0U1oEGTneudZ7jvCv7tnPH4lrUHCtXJ
         FWAzqBzhANsGRHSe0L+u31UwNIEkHdy8cc689RwexrW2BNO+zxetd6gMf73/muQVtM+j
         M0Ww==
X-Gm-Message-State: APjAAAXWQ+/fRI7CEJgSVTRCM6uQzSyATUEWvVN6A4kBy6AXOD/Mrrq7
        zC1A7nLaoPiLCcrytdzbZF4=
X-Google-Smtp-Source: APXvYqztE++sqKGUYnk/u9NoziT3TMGtt/I1dphNbalrSC8mCoB+bsYNUUscD4RccgBvp3NpRah3gg==
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr9593065lfm.120.1564036618243;
        Wed, 24 Jul 2019 23:36:58 -0700 (PDT)
Received: from ul001888.eu.tieto.com ([91.198.246.10])
        by smtp.gmail.com with ESMTPSA id m9sm8342294lfo.45.2019.07.24.23.36.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 23:36:57 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        myungjoo.ham@samsung.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: max77693: Add extra IRQF_ONESHOT
Date:   Thu, 25 Jul 2019 08:36:44 +0200
Message-Id: <20190725063644.5982-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not fire irq again until thread done
This issue was found by code inspection
Coccicheck irqf_oneshot.cocci

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/extcon/extcon-max77693.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 32fc5a66ffa9..68e42cd87e98 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1142,7 +1142,7 @@ static int max77693_muic_probe(struct platform_device *pdev)
 
 		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
 				max77693_muic_irq_handler,
-				IRQF_NO_SUSPEND,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
-- 
2.17.1


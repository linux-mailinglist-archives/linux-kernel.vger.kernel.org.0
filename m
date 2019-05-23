Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41A927BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfEWLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 07:37:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45766 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfEWLgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id n22so4120827lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QiCsrho382mVfN9QoMcKC8bcTWEDEiAa9/EpPshWZI=;
        b=pDlCeVS9exGipdSjuhH11kdXCHpgAp/d76d939LbnDhCOvMvVrryam02jBgRsoZpVL
         Drl9xXZ+6J9OuuwgCk7wz0Qt/8NZJmxZ3iYwpOnOGV+7XqwDJA2T+xl+xY7RWB1OkCT/
         6aqBSwinL66YB8yQTsQ1OkdmUyhPHBNwXwcFksn9mnbBkPGokmFWtiijLLtpt3uH768A
         om+0aEZHEvYM2e8S2CA+SQO7gV7P2reFkBTupEgatDrP8ALubNx13rgiBirDp29cha4c
         HTo1cMwmHPada9dsUiZP10jj9DDuqE+z1AQ50GEFeN63HJnh99PbVUNPyIj2zkvq7/nD
         RqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QiCsrho382mVfN9QoMcKC8bcTWEDEiAa9/EpPshWZI=;
        b=UfVOniWTFZX+uKD2nk2CTQimq5HRP8UiY9dxpIowzzuksjofRxsbJIkQ25cRHKR8fR
         D7X2TyzS+jKUifvuqSHnfZT3Tw4cVKvRkaomYWvVLbY6qiQGTqfUdsPt8Uxgv5w12Yia
         MyNoIJB+UyyDa4B+a5cSuw8GwKayCtJEXhifqankG14GWB4Gcby8YlvqCqH+MHp8sTY+
         lB5HPHFpemfZd8aBFPYWsPZXkzNPsZw/J4JHYW0siABiMcF+og36YqMOF2uN8F0ZVACA
         62mg28C5DtUzo/5Ty8rIpKjW3xGmTqukGXnDN6ROCKnEjN4UtKsx6MwjF1uP2I86oKiI
         YbaQ==
X-Gm-Message-State: APjAAAU7MkRoctkZSOMej64lydgORnJBDPUHTtoBUFCY2mJmUhSp9C48
        JHgawhgkN0kHUgo5sQMa5F5zSgMM4vBv+g==
X-Google-Smtp-Source: APXvYqzqAb4IBQARyp9SkNwQ0znYVC7QGSn/jZSJlCPeM2voiYM2+zejwW+FjWOpQFKKBQNfZq0qFw==
X-Received: by 2002:a19:2005:: with SMTP id g5mr8702206lfg.157.1558611393498;
        Thu, 23 May 2019 04:36:33 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:32 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: kpc2000: add missing asterisk in comment
Date:   Thu, 23 May 2019 13:36:08 +0200
Message-Id: <20190523113613.28342-4-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523113613.28342-1-simon@nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl error "code indent should use tabs where possible".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 7b850f3e808b..c4015c62686f 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -25,7 +25,7 @@
  *                                                              D                   C2S DMA Present
  *                                                               DDD                C2S DMA Channel Number    [up to 8 channels]
  *                                                                  II              IRQ Count [0 to 3 IRQs per core]
-                                                                      1111111000
+ *                                                                    1111111000
  *                                                                    IIIIIII       IRQ Base Number [up to 128 IRQs per card]
  *                                                                           ___    Spare
  *
-- 
2.20.1


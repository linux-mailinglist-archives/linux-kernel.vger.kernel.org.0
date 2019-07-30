Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980E87B164
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfG3SQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:16:11 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37454 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfG3SQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:05 -0400
Received: by mail-pg1-f180.google.com with SMTP id i70so19736705pgd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dV2FBRE428VEXIw34vqUyE1reej3GG1J5+23fb3pWDg=;
        b=hIdDJTyQnv2sCvpPPj8uG/bm1NM6+QP8RWrDpJCdYuITk3aToBDBc6jYhD/rrps3JH
         1jFKO6Nr35YFOIqsQo4yvntlJkBWSGAZ+KU9YVAx3Mu7wuQH2Jhd6gknbUzE2Y4deSug
         XdppPOLMLj/r7fNj787tddVekWLSasaxnvglQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dV2FBRE428VEXIw34vqUyE1reej3GG1J5+23fb3pWDg=;
        b=p2Ugn5vhiesWqw0t3d/7Lr+XWAJi7fwQUl7iqpxQTSEYotpDWBBQJCBTlHC1LAVfKi
         r+UmxmLNUfsgQKRmFAOrVH8esXtRU9jlYAYSJjmOJyUXsh4AsxQpzXsihuYYQFrh1xyQ
         eL9054YJSt8/6GfC9DlWt/lR7kZyqC7yJNELZWOlC7YeUJUl22WAsAzyvoVKqnV3bjWP
         XCluvtZwvlkqgOhOZdzYc8lzTrRjWodrOZ++RX1+sG7CkR77s6mc7+N2B/2Dba9V43Vp
         V9rmRIDWe9Kbb6egQqhXqaMM6nHpNKBU5dQsBte0D0VsMXqsGUmjEHTZHX42vOzXGShY
         lgFA==
X-Gm-Message-State: APjAAAXIIy80ZubI03VnSSpAZ2LkJsnXlL+EMKiH5RhaU9op7Uvx62AB
        Z8nPYs1HVyyRg/JH5RQ6KYzs7209XD4=
X-Google-Smtp-Source: APXvYqx2Pqv5uDlrdziTUf03ket19wq3XsklTtQ40rrDwc4TnzRTamQqtGiQjDRMH9JAhWTfXXOa0Q==
X-Received: by 2002:a63:6c4:: with SMTP id 187mr103277632pgg.401.1564510563865;
        Tue, 30 Jul 2019 11:16:03 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:03 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 06/57] cpufreq: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:06 -0700
Message-Id: <20190730181557.90391-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d0fb13..27057c8bf035 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -538,8 +538,6 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 
 	host_irq = platform_get_irq_byname(pdev, BRCM_AVS_HOST_INTR);
 	if (host_irq < 0) {
-		dev_err(dev, "Couldn't find interrupt %s -- %d\n",
-			BRCM_AVS_HOST_INTR, host_irq);
 		ret = host_irq;
 		goto unmap_intr_base;
 	}
-- 
Sent by a computer through tubes


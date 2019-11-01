Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED50EBE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 08:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfKAHpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 03:45:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41446 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKAHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so8787952wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZmXO5ePw27XXjmw9aqXqaRd2VOTfPGeZBWp3iFdesM=;
        b=tbCJuYLob+0SWNE/H/aeNZaYlGi3cJ/mzfR3bgtLr1RoF0bzCFs3kcYakZXCwCnEnd
         MnLJgV1VtNOLom7eF3xRGzmxN00x8pt3aNMSyx8IlHnxSN+vGoNCz8lnWXF/E2LeLRvn
         XuvG3bchUwfbZm8phPQsjEYu6akLSU2CDD+qS4olY3VNarH3zFRwoe+XEwYQbqJlBfzq
         tQ9kT8oAkB6fwztc9zSR4if6OpgunzPPqsW0tCdlEdG5uSZMnTh0Nv5cpGDx/fojiR1p
         1zIVuPoGmrTObZd6uVv0z7p0Xg2J9lR6gL1Fj/BLXh7mzPJPAim6tOvqoSDnWlzZRh8C
         /1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZmXO5ePw27XXjmw9aqXqaRd2VOTfPGeZBWp3iFdesM=;
        b=GhEYHeggpjnGdYamNXaIPjH00a00NKe4Ks1EvIzTo6BWXerh2qdil2hqVpQnXJFMWD
         AEALMUP57a9pJUNh2ej9pWtyPHcBjOWniR2K4+I/TP71m0or3rTg7c/mBF6YUGiH1JK4
         8hVVecDCgtVC+UV6LYBsMt/WSw6yELlShkmd8glL/KMcOpdDlgQjUvREYzgCLkG67q+I
         NyZNcJ2fFCLOiJh+VtAGg0dtYKz+U8OdOYEqKsKxAfcZn8yWruCJ9XkwP0ANMpcSe0AL
         cRnNM2j7WmLh8DGv1hoee7fYX8v9BJt6e3bqSe37XR2Ehslk2ujBfjlkB6MIcShRQvEM
         6zEw==
X-Gm-Message-State: APjAAAU4i/zPlTRxSU15HKVOwR1qRBEXFZkq9v3di1p9ySo8bPUTzylS
        y5ek5exMGxYvFQHXNNQDkZUJJQ==
X-Google-Smtp-Source: APXvYqzAhKI9QO7+uHq0jZZwhl3O0BW/SI4JcZ57GySMVZs/utC1/kufLJ8AWDWrDLnPbWRV/GVe2w==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr5175902wrn.225.1572594322417;
        Fri, 01 Nov 2019 00:45:22 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 01/10] mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
Date:   Fri,  1 Nov 2019 07:45:09 +0000
Message-Id: <20191101074518.26228-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most contexts '-1' doesn't really mean much to the casual observer.
In almost all cases, it's better to use a human readable define.  In
this case PLATFORM_DEVID_* defines have already been provided for this
purpose.

While we're here, let's be specific about the 'MFD devices' which
failed.  It will help when trying to distinguish which of the 2 sets
of sub-devices we actually failed to register.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index f1825c0ccbd0..cda7f5b942e7 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -127,10 +127,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		cs5535_mfd_cells[i].id = 0;
 	}
 
-	err = mfd_add_devices(&pdev->dev, -1, cs5535_mfd_cells,
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
 			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
 	if (err) {
-		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
+		dev_err(&pdev->dev,
+			"Failed to add CS5535 sub-devices: %d\n", err);
 		goto err_disable;
 	}
 
-- 
2.17.1


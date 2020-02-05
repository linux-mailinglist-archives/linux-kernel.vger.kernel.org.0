Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1967715311A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBEMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 07:51:26 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50859 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgBEMvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:51:25 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so954234pjb.0;
        Wed, 05 Feb 2020 04:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=p4o6nUOGxNPuRPSrNBregTBA8bwmvTg5CUl0u2z528Q=;
        b=fbNGETkV3yePdfOPkkretpz/hHkJaTfR9FtEV44umuMjmWjiSP4KwUy85KHD5vWFMM
         k08UG0ivgazlOCXXwx0uzSviXrifB+a1cvgQSXZpLuTQTDqR2SHs19Kx6HecK1J2Dksx
         oCdml0BtSgbx+B5wK5EhnXCYYfFnYNhBBwnBpLFuQYMQjBnYGiw5eESm3HJBFoazO3oq
         1mVsem66t2Izi8pvp9eP8o83i1aCKEx5GJn5VTy3w1yjIpdTgYz+34eOy/5fzNSKjbVC
         qTm3dTiHbUyYtGn/LTfYkOItlGFeS3zq0LVexbdrwKyHzDVP9JCSzW+AmaSkvtXKKz1r
         vH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=p4o6nUOGxNPuRPSrNBregTBA8bwmvTg5CUl0u2z528Q=;
        b=GFZGkousOn9FrT0tUqIRWL5c/cq8kiWpaili6Evb72mv8/tmFndcC4h3gMuQGcADbK
         ebi8AnkKkMLlAMiZHmyLryxw2Ky758WBY7eF1ClCvVyP1qGUc/dH6RV2BAVm2MI5Fz4I
         WZ6vLKu8Nv0g3QLqNFZRiPcVuBWcBZP6fqcFB8u5jNODDIjg6fJG9IXgfmofTeiapFmB
         gQgdKWUyAmL/gdcM9jgPn5ftRNlbvFILpkY5QyyJUOHI6rcOtJ1e5Mo9EnK3TJIiyUIr
         NheXUpwrTXE+sNb1/1kIn2uA3kAHjPCTMKqi45Flw+qc2sTiasZtjQehupUim1lS0pkZ
         z4hw==
X-Gm-Message-State: APjAAAUH7UXTkDMBriet4paA0O1WqlwWfMlCcUoEsMvd1QNzbpFjFa0e
        w/SnWLMfSJKSSpXYKe+od9o=
X-Google-Smtp-Source: APXvYqzTrsVY+JCK2jDAhzccvTSDjze99dIgbA83iOUDSRGNMdW2P2/zXjPYHf1DwPAwSaRbU1O64w==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr5701197pjo.58.1580907084424;
        Wed, 05 Feb 2020 04:51:24 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y127sm22864784pfg.22.2020.02.05.04.51.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Feb 2020 04:51:24 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/5] mmc: core: Enable the MMC host software queue for the SD card
Date:   Wed,  5 Feb 2020 20:50:29 +0800
Message-Id: <0dc2be36722232c07ad9bd61ca285ed1553fe3c9.1580894083.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1580894083.git.baolin.wang7@gmail.com>
References: <cover.1580894083.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1580894083.git.baolin.wang7@gmail.com>
References: <cover.1580894083.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Enable the MMC host software queue for the SD card if the host controller
supports the MMC host software queue.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/core/sd.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fe914ff..76c7add 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1082,6 +1082,16 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
+	if (host->cqe_ops && !host->cqe_enabled) {
+		err = host->cqe_ops->cqe_enable(host, card);
+		if (!err) {
+			host->cqe_enabled = true;
+			host->hsq_enabled = true;
+			pr_info("%s: Host Software Queue enabled\n",
+				mmc_hostname(host));
+		}
+	}
+
 	if (host->caps2 & MMC_CAP2_AVOID_3_3V &&
 	    host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
 		pr_err("%s: Host failed to negotiate down from 3.3V\n",
-- 
1.7.9.5


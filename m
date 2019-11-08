Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18035F4C80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 14:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfKHNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 08:03:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43797 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfKHNCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id y23so6103217ljh.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FL4wefDICHo32h9247H9jmqyY6zv5MUtAqMoiveQx9g=;
        b=WM3db+UZNX0xYRn8xFInkWCZ/gGBxlESeid8dXGQU2p17G2KmYfmQKEJM/6nxdjVkz
         dcCfwIBMRd3gygzYVu0IHJtJgUPU16y1N7AQMDT6+xP5d6gPmR+R/fMCMBXpDEu/jhZJ
         wIS2GKrKi2LdTuVlyChuB3CdPaAYkTSGlI7eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FL4wefDICHo32h9247H9jmqyY6zv5MUtAqMoiveQx9g=;
        b=gQ7e8Oubps4qMaL3mtInlkRwQOkgL/h1Nzv/VSK5H9qQXT8lcvDuO7GKir9gLxvbBs
         B8MQ0vw3G1eKEKLXnsh9c7kaSljui8o/js+BENnfgJs9OXvVFpjBIYvrk5gkKZzVFp+R
         ADw9rqS+H5THAwjLLkuuAxWik354rKw8VqlNlvs0Cndxqtgd6EL81oFgE6fEBcwblLW5
         iUBo1Zx3Dth3q/eQFAK6WIpfTC+rFLixrEF8xlAMFBimtTHQkml/WhFIVcWTp06vrRrl
         QsRiO4zs5PZeGqXnF8WLL1/R0Wp5xW8rMKLnoqfex9Na7zARHXtkudf2NZ1zTXPMLFxE
         7qyA==
X-Gm-Message-State: APjAAAVbdycxto8hLn6J3l6jD6eManJ7wlNjoObz+wRPTmlrINyuv/Zs
        h7456WC3uwP+EzZBCX2qSrqb8w==
X-Google-Smtp-Source: APXvYqzCkS9lqjETR7JbwYC8m9Tz96BZoapb1R12xn90SEX0h1M81nDkrgY6B1mLpdktlcuraWeZvg==
X-Received: by 2002:a2e:9a53:: with SMTP id k19mr5922502ljj.246.1573218139469;
        Fri, 08 Nov 2019 05:02:19 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:18 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 41/47] soc: fsl: qe: drop pointless check in qe_sdma_init()
Date:   Fri,  8 Nov 2019 14:01:17 +0100
Message-Id: <20191108130123.6839-42-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdma member of struct qe_immap is not at offset zero, so even if
qe_immr wasn't initialized yet (i.e. NULL), &qe_immr->sdma would not
be NULL.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 5bf279c679ef..96c2057d8d8e 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -367,9 +367,6 @@ static int qe_sdma_init(void)
 	struct sdma __iomem *sdma = &qe_immr->sdma;
 	static s32 sdma_buf_offset = -ENOMEM;
 
-	if (!sdma)
-		return -ENODEV;
-
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
 	if (sdma_buf_offset < 0) {
-- 
2.23.0


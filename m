Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4118FDC571
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410061AbfJRMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 08:52:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40989 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408106AbfJRMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so6103222ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76C3KCBVTIWXOJRoGbkicD5UasUbJ5XDGEEs+OOGNvk=;
        b=FSHcuBzPR1mmeL4PACLKsTbqTj+24LBzK/6l+O/Lm/1IrQLP3nhdrLnFf6MSg0yH0g
         HoftTcmnUioa5SuvRouA12dlbveQ/icRsojJyg7o+TA6FzCF4LpHeb/WCkcTlKMjOMFj
         W12H1zsXT9+1u+Ng90qJFYXAQtc1ter6pD6Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76C3KCBVTIWXOJRoGbkicD5UasUbJ5XDGEEs+OOGNvk=;
        b=DvrKlmh9u2ICECH2KHQBmud7K9mPZDv7LwFSD7Rf/6v1/LCrLQooZf+zQO5JzX3mNN
         nXlULJkt6nact8vJ1umRG3VxKqslnEox5JPUE0SWZZCxFEYl3P1qJigTuS8R56b1e7+r
         hxwwstuKyBn1rYAIZOtH/O6WFMYRisf5FHamR53qyP5LaZ7xflqP7YKaGw4NXte3+eVZ
         cmS4a0GX5+kSKvOVeMwYzzZ1P8JZEdalspYbpmPzAYEtbsGBTMWZGEB7TvMCB/HJb5Ca
         YRY1LcL4p2S0HPKatd9L+iWtGCvtj3r4hwHLHCoYV/GmPrx72GVdeE3PiNSexo8e8B/T
         3M6A==
X-Gm-Message-State: APjAAAUTuBrGKyc6wUkx/wyz4yvQa/xRrqHzLBh+3RH0xBoo+bV+aLLa
        Yn0d8zU650uOjpkIG3VNETfdgg==
X-Google-Smtp-Source: APXvYqwYe6ilX8TDGuGskrpio0qKSxCNGwmNMC2CS8ROsNPpnWHiv5TjxIYmTv9OVkt1GHfcoMvdMg==
X-Received: by 2002:a2e:9112:: with SMTP id m18mr6305431ljg.75.1571403161898;
        Fri, 18 Oct 2019 05:52:41 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:40 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] soc: fsl: qe: remove space-before-tab
Date:   Fri, 18 Oct 2019 14:52:28 +0200
Message-Id: <20191018125234.21825-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 417df7e19281..6fcbfad408de 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -378,8 +378,8 @@ static int qe_sdma_init(void)
 	}
 
 	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
- 	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
- 					(0x1 << QE_SDMR_CEN_SHIFT)));
+	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
+					(0x1 << QE_SDMR_CEN_SHIFT)));
 
 	return 0;
 }
-- 
2.20.1


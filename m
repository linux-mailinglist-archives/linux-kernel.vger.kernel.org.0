Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3279B10CADD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfK1O5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 09:57:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46143 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1O5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id a17so20227113lfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0Z99m46uTitiY7EAqUjdsfnbt8T6jBnOkYMa/lxzFc=;
        b=f/W/exb9eqrLZUZU7hVxEY41tbm7yL1+b7JHIp/+HXGPW6D57B7kArjlPKFQAP795y
         JFFg6GJoWjgAQzfamqMMSl7siZ5vtxRSyA6w4/O5Y0YSqBAYYsiufM8Jod3NrLYjb9DT
         QDUuJMw+ZdkL9v/N3IHXbu7xg+vS9msqIMmXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0Z99m46uTitiY7EAqUjdsfnbt8T6jBnOkYMa/lxzFc=;
        b=LGfybMn/4VMydkdx3Fl65k4Rb/qghW7ZXNyThkKBm/RFY5DjdQckku9qvr59w/+Lyc
         ToVDDjD+WLBh3G5zcH18/xV0Y+J2+wH9bUXp05V3//bmqbG08jFKfQ5Qw6vWQlVfWnNN
         ZujBuwXCemJeJwLmtn8Ff5jfcI+EjvuUTVTnnhpImsqZT+nJ2oibaX6m4PCQ+atLEDXJ
         JIhOiuphmObgi08nqRQiP1JDxl1CdeKJtr9Mps/OBjQGunnY0gNIpeMOO8+4CprlnJEO
         7himnJtQYRDCj6v+LHhQTv5/rUef3nt3w/4ugtrdU/0fLqEcHfFTQ01LiD8TybiW2iyv
         xrNw==
X-Gm-Message-State: APjAAAV9+RVEK1hK52TIplEJqEEacn7dQywvJFdD3pHQB2T/ZeSHEVaq
        uLOHjebaKx2D/oOAcNzqEMFTSA==
X-Google-Smtp-Source: APXvYqxb8GWt/9RrETi2+yLMb/nDXIK4UMHDkk05wdq/zOJZC8k6Rm4tzODOn7GKBe/vlKCItiPr3w==
X-Received: by 2002:a19:756:: with SMTP id 83mr6609479lfh.173.1574953025427;
        Thu, 28 Nov 2019 06:57:05 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:04 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 01/49] soc: fsl: qe: remove space-before-tab
Date:   Thu, 28 Nov 2019 15:55:06 +0100
Message-Id: <20191128145554.1297-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 417df7e19281..2a0e6e642776 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -378,8 +378,8 @@ static int qe_sdma_init(void)
 	}
 
 	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
- 	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
- 					(0x1 << QE_SDMR_CEN_SHIFT)));
+	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
+		 (0x1 << QE_SDMR_CEN_SHIFT)));
 
 	return 0;
 }
-- 
2.23.0


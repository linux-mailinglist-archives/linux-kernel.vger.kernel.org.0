Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECE41003B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfKRLXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:23:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKRLXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so18971811wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uK8xEnPEigQ7dFIza6M7Wg35/gDKz/RHXvPNwcggqY=;
        b=ESHufM9rLwzeit6o3y1ifl1OvkypH74ieT9VS8b/loPYq5KFebFx5IHeajLey5njlA
         nUzu4nF8OqS1t+fYCyJ8MX/TbSfZw1FjLIURt2XAPydF1iNrZaszqm/kzaXRlHKUTWxx
         vecOqxle748O6UlRJPOFIZsmf9MDaD2KpObhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uK8xEnPEigQ7dFIza6M7Wg35/gDKz/RHXvPNwcggqY=;
        b=KSf4W+c+8ezaP/8O1fZdLKnB62vSGAuaPDmHFc27aZ4M74enylb4WpJkSML8ubQwVW
         aoPcHGwO7kdGGBQgXt1pqloKb4svlxwhqs57/dmxo8qcN1TUbGrl0gkgBjDOKjIRvwI3
         KdkFO6HY9nWQSAi19y7GGhgBgumj3loy/aRqfOrmfS0sCD/0CyAk73VvcZ4JKw4KClsl
         vTzR7LZE77BqAppdjEOOmBQ0mcWxwzrdiCuV4VBcbQUMGdOxsxoEinohFjhH+OkllQ8q
         UYbVCIAyhlShyHB/OEck6337wFAR8/5yIoI4u1MrAbDI7hQ2HkzWH2C5pYIXfBpoPlji
         KxAA==
X-Gm-Message-State: APjAAAU9WI+v03Pve9KeWei0NvWBArTzfheCU2GXCNuhjQDUdfxaCEvX
        pfNVDtXF5gLmD0/B9sHsve9f0w==
X-Google-Smtp-Source: APXvYqy2NodHoijv8VFlHCy2XgCL4gzpCEIpCfwwztX4l52WX/0x4yS/GCAFF8twhFiSv7d91UMYIw==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr20473299wrv.367.1574076211060;
        Mon, 18 Nov 2019 03:23:31 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:30 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 01/48] soc: fsl: qe: remove space-before-tab
Date:   Mon, 18 Nov 2019 12:22:37 +0100
Message-Id: <20191118112324.22725-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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


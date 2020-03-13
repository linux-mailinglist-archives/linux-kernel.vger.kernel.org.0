Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCEE183FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 05:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgCMEHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 00:07:25 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52141 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgCMEHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:07:25 -0400
Received: by mail-pj1-f67.google.com with SMTP id y7so3476670pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 21:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YEeFDXp3ZyN3NwzD7P+co9ETlP6ejU9qaOPFtmQDLg8=;
        b=fmSPqFK2FKqqNmxPJqtn9RtEOyg93NIBZtPv+SvPkees2/djyARD5wqAaJ8OZKVa0r
         tYXAOpFmQV5yA/VRxrcbUO5BhXi8zAueicKhaWvO5A4+85udddUc3nAXYk0t6PASYgl9
         xhUGzKaHVMT97mEjeg7RwJka+a1OcxcHBiUd94TlrRXU5nsPX6tZ0mGDSaqJLtGOkqWJ
         BmXorpsxVmBVp3k6xJfWU3FPij7lb5dGiK+nLwbvmpWxbgSLOe9U0qqC4wiKprp5lUCe
         5JkMthLQAYQuVqTy9i1YRioeHNAQZCmfCeKOVr4POtvZVyQi2GwsIQDoHEmdYvN6McMy
         OmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YEeFDXp3ZyN3NwzD7P+co9ETlP6ejU9qaOPFtmQDLg8=;
        b=iioS/2TOwWHnbIzu0hyYih6TAb37PQMw/KG3bMxdiwpNnnQsEVAT+5maEwe43uSrgV
         q1kp0zpBekNuBA69AChe1QYDZ1/USPSniABhb1c+moowuO71icgoBtjoSrmHsNKIRGcY
         80F7nCYaP3IhGWw/UDa6uVKLEbfCyUJ0qRVR15ct9pnHXuzRULazeMl0QC61JdkAt0os
         AkXBFwp3PSagiaP7QlLSY6j5/SxX682+4bT3RG3eVehXGJD26HaRIuIgLCOjJpjPvuCB
         NsLpLwcejxOv1m75JkGLhP8zFsdbA4BJ9xXi/SSUl+8ic1ziySFCuzhRfAtTMiexTk4L
         s1pg==
X-Gm-Message-State: ANhLgQ16gRJScVaQ99NOOvd9J6hcSL4RNHOBLT9C20dYLCP96kvdIYnb
        njU+Ncg8HeoI5OU20YQt2ic=
X-Google-Smtp-Source: ADFU+vvtFQqtocgSF/5Xbdoe9MZNKlwqqtxdD10jCtW/jxbNcQtkQn0hWHFGHLksRiiikJ1J5tBM+w==
X-Received: by 2002:a17:90a:5d18:: with SMTP id s24mr7445153pji.141.1584072444059;
        Thu, 12 Mar 2020 21:07:24 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 6sm15576661pfx.69.2020.03.12.21.07.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 21:07:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     srinivas.kandagatla@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, freeman.liu@unisoc.com,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nvmem: sprd: Fix the block lock operation
Date:   Fri, 13 Mar 2020 12:07:07 +0800
Message-Id: <03c391fc1bbc3575ed47d5d249106de9e0b7d508.1584072223.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584072223.git.baolin.wang7@gmail.com>
References: <cover.1584072223.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584072223.git.baolin.wang7@gmail.com>
References: <cover.1584072223.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

According to the Spreadtrum eFuse specification, we should write 0 to
the block to trigger the lock operation.

Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/nvmem/sprd-efuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 2f1e0fb..7a189ef 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -239,7 +239,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
 		ret = -EBUSY;
 	} else {
 		sprd_efuse_set_prog_lock(efuse, lock);
-		writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
+		writel(0, efuse->base + SPRD_EFUSE_MEM(blk));
 		sprd_efuse_set_prog_lock(efuse, false);
 	}
 
-- 
1.9.1


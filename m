Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDCC700A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfGVNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 09:10:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43086 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbfGVNK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:10:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so17631509pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nK15mMz9psJ4xYNbb/viJ2eSjpHSRghs1AoPCx3Qibw=;
        b=KY1bnd4Up1tXXPW2ZmnY4asvQ3zqGzy3u3b1KUBtemsy/00kmw7MuqyaQeqIKTwo9Y
         71DSBIUgWn9dRmVialFx4Joe3zX5wJ3d6HasrDvAlfxWeltqtCqgo3qWTHcd38Tqgwec
         0O3V3bS09p9DpBrbf1r6vLUM0Gj1uSr/P01k9rClYJIwmhLZrD9HqLIBnDN3VsIsVVr9
         rMw0i9EVoiUHIQbpGJfm02M1gMj+Sa24Heh0UYaRRoV3q2ZuI5BuqfR0YE1q5mGxJlWX
         Z714pEfRJyiEtR6dq9EnC2Wl/g6fjwzXljrMMCca0NnDyp+iyt9CbMTkpw3XQn44z/1+
         p+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nK15mMz9psJ4xYNbb/viJ2eSjpHSRghs1AoPCx3Qibw=;
        b=e36bVjOlqtYL/kPuZ3UC87C+7euqTqdLzErxM1JshoYRGGiXo5uQY1Ejlb689ft4dn
         /UrEPg1QOLmLBbawueEsdMqSb8gJryClvDqsehQXb53sizwU8grwumxYkoMtuzHF8v8r
         C0nm47pad/3KpSHZAMQOgkwOtecRn83enWDMpG0z9Hm69cs7fYp2ot6mGxCNuF8myizW
         QMfodQ5g6clGF4uvIMufHmv96XTL7J++xxH+fK/Kk0u07TGk5N5VOlYqOXpPDT3xzz/8
         VBzy9DCmwl3lZ4UsAwGC0gDcoEJFoey8nT8ezX8xODnQin17dpDo7hZUG8ybQFX7zosI
         fItQ==
X-Gm-Message-State: APjAAAXBGEqO7s8OCmKw9fJ68FA82eFmraniaIxePzuT+ivOZYiVcn9F
        3jfu1P2Wm1YVZmXJh0Vjsl/Uuw==
X-Google-Smtp-Source: APXvYqyK7nJNIaBSuDpr8SygQ/E7h7qbGmJ907l2NWDJp3Vg9aPJ6YfwpwHeGwhvuNZd/+Fuz7R8ag==
X-Received: by 2002:a17:90a:37e9:: with SMTP id v96mr75508203pjb.10.1563801025887;
        Mon, 22 Jul 2019 06:10:25 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:25 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 5/7] mmc: host: sdhci: Remove redundant sg_count member of struct sdhci_host
Date:   Mon, 22 Jul 2019 21:09:40 +0800
Message-Id: <b34528f0248ce537ec020373f96aa6d486dc6f6d.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc_data structure has a member to save the mapped sg count, so
no need introduce a redundant sg_count of struct sdhci_host, remove it.
This is also a preparation patch to support ADMA3 transfer mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |   12 +++++-------
 drivers/mmc/host/sdhci.h |    2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5760b7c..9fec82f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -696,7 +696,7 @@ static void sdhci_adma_mark_end(void *desc)
 }
 
 static void sdhci_adma_table_pre(struct sdhci_host *host,
-	struct mmc_data *data, int sg_count)
+	struct mmc_data *data)
 {
 	struct scatterlist *sg;
 	unsigned long flags;
@@ -710,14 +710,12 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	 * We currently guess that it is LE.
 	 */
 
-	host->sg_count = sg_count;
-
 	desc = host->adma_table;
 	align = host->align_buffer;
 
 	align_addr = host->align_addr;
 
-	for_each_sg(data->sg, sg, host->sg_count, i) {
+	for_each_sg(data->sg, sg, data->sg_count, i) {
 		addr = sg_dma_address(sg);
 		len = sg_dma_len(sg);
 
@@ -788,7 +786,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		bool has_unaligned = false;
 
 		/* Do a quick scan of the SG list for any unaligned mappings */
-		for_each_sg(data->sg, sg, host->sg_count, i)
+		for_each_sg(data->sg, sg, data->sg_count, i)
 			if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 				has_unaligned = true;
 				break;
@@ -800,7 +798,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 
 			align = host->align_buffer;
 
-			for_each_sg(data->sg, sg, host->sg_count, i) {
+			for_each_sg(data->sg, sg, data->sg_count, i) {
 				if (sg_dma_address(sg) & SDHCI_ADMA2_MASK) {
 					size = SDHCI_ADMA2_ALIGN -
 					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
@@ -1094,7 +1092,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			WARN_ON(1);
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
-			sdhci_adma_table_pre(host, data, sg_cnt);
+			sdhci_adma_table_pre(host, data);
 
 			sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
 			if (host->flags & SDHCI_USE_64_BIT_DMA)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 010cc29..4548d9c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -584,8 +584,6 @@ struct sdhci_host {
 	struct sg_mapping_iter sg_miter;	/* SG state for PIO */
 	unsigned int blocks;	/* remaining PIO blocks */
 
-	int sg_count;		/* Mapped sg entries */
-
 	void *adma_table;	/* ADMA descriptor table */
 	void *align_buffer;	/* Bounce buffer */
 	void *integr_table;	/* ADMA3 intergrate descriptor table */
-- 
1.7.9.5


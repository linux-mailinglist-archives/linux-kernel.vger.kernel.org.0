Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892D913B96
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfEDSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:38:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43843 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfEDSic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id z5so2743466lji.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NC4NMJOLNJxdm2CPanlPF74VFqGQQWz2k2E7RsLwLpM=;
        b=MK4y9Sq43luQX4AvFZhVgsj8p7hkgXjvSMwGDR/SWA0nG9n2n2poIdFxLoIeVwLCA9
         FDYwqYcLqTETfjPqtU95fgCX9foaIzHy/jaQzUdc6YvMaCm75z2eewx9mATQWngL7hl8
         siKIg6zurXrEHD9acFPFvhuvgkOgzEwKbs9nyZU+qCQGJORCtxsZkGvXlXFuQbb7fejw
         3wfTUBYYOVJc+TQGteXrjqc1aTce992/KRbn1MPOVYjlxrFCqcUa/WHc59kgkOJxjCpD
         Mq++853VNdEf70pTNxeFZSo+W999Him5MPlnp6jrHuQcrJJkQCWbpEQIFY1n7rE9lRrQ
         wI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NC4NMJOLNJxdm2CPanlPF74VFqGQQWz2k2E7RsLwLpM=;
        b=LahIeevQS/3LoXlP1sdZd6WPkl9q+hZ3qDuO/9DtvRU714kbTo0perPb+3DOXwOZ1h
         MgO9X3Les71GZtPBHZezCmZkBkhEw+tmpmUdNWZ8joBMD+cNsTJolkNwgeXG6WGLLwnr
         49q5CUHF5AR3WKZac3SmYb82HMcte7GzYkZkgmIfgPaf3/3pGFVfiO5nWKOaf5GETKu6
         xgApQEHmPOJsJQKFSD9qk57UqrYjuPRCxZ645uGITQngYNzZ0OgQSiin+Ish5vlijT7C
         OmU0tpbC4i0iyB1EUhwffIgwUaHoNAae8mcrawMvVIW9+59WoPMYnPYLtCZaNy98K/E/
         J3Ow==
X-Gm-Message-State: APjAAAUPkUoGvLeCTb+xTB5IOaFvH8flXt73pUduAFAtnXk4dCHIgeGo
        zZJWbtQ4VqGAodCy9XS7PZ6kYw==
X-Google-Smtp-Source: APXvYqyavtT5Y0zUWAiEHqlXMC4gt+WhaKiG2/ukwhqFznk1DwpJymBPKYHTnY3msWgXKf1aG/GJeQ==
X-Received: by 2002:a2e:9993:: with SMTP id w19mr8909597lji.111.1556995109642;
        Sat, 04 May 2019 11:38:29 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:29 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 03/26] lightnvm: pblk: reduce L2P memory footprint
Date:   Sat,  4 May 2019 20:37:48 +0200
Message-Id: <20190504183811.18725-4-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently L2P map size is calculated based on the total number of
available sectors, which is redundant, since it contains mapping for
overprovisioning as well (11% by default).

Change this size to the real capacity and thus reduce the memory
footprint significantly - with default op value it is approx.
110MB of DRAM less for every 1TB of media.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c     | 8 ++++----
 drivers/lightnvm/pblk-init.c     | 7 +++----
 drivers/lightnvm/pblk-read.c     | 2 +-
 drivers/lightnvm/pblk-recovery.c | 2 +-
 drivers/lightnvm/pblk.h          | 1 -
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6ca868868fee..fac32138291f 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -2023,7 +2023,7 @@ void pblk_update_map(struct pblk *pblk, sector_t lba, struct ppa_addr ppa)
 	struct ppa_addr ppa_l2p;
 
 	/* logic error: lba out-of-bounds. Ignore update */
-	if (!(lba < pblk->rl.nr_secs)) {
+	if (!(lba < pblk->capacity)) {
 		WARN(1, "pblk: corrupted L2P map request\n");
 		return;
 	}
@@ -2063,7 +2063,7 @@ int pblk_update_map_gc(struct pblk *pblk, sector_t lba, struct ppa_addr ppa_new,
 #endif
 
 	/* logic error: lba out-of-bounds. Ignore update */
-	if (!(lba < pblk->rl.nr_secs)) {
+	if (!(lba < pblk->capacity)) {
 		WARN(1, "pblk: corrupted L2P map request\n");
 		return 0;
 	}
@@ -2109,7 +2109,7 @@ void pblk_update_map_dev(struct pblk *pblk, sector_t lba,
 	}
 
 	/* logic error: lba out-of-bounds. Ignore update */
-	if (!(lba < pblk->rl.nr_secs)) {
+	if (!(lba < pblk->capacity)) {
 		WARN(1, "pblk: corrupted L2P map request\n");
 		return;
 	}
@@ -2167,7 +2167,7 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
 		lba = lba_list[i];
 		if (lba != ADDR_EMPTY) {
 			/* logic error: lba out-of-bounds. Ignore update */
-			if (!(lba < pblk->rl.nr_secs)) {
+			if (!(lba < pblk->capacity)) {
 				WARN(1, "pblk: corrupted L2P map request\n");
 				continue;
 			}
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8b643d0bffae..81e8ed4d31ea 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -105,7 +105,7 @@ static size_t pblk_trans_map_size(struct pblk *pblk)
 	if (pblk->addrf_len < 32)
 		entry_size = 4;
 
-	return entry_size * pblk->rl.nr_secs;
+	return entry_size * pblk->capacity;
 }
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -170,7 +170,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
 
 	pblk_ppa_set_empty(&ppa);
 
-	for (i = 0; i < pblk->rl.nr_secs; i++)
+	for (i = 0; i < pblk->capacity; i++)
 		pblk_trans_map_set(pblk, i, ppa);
 
 	ret = pblk_l2p_recover(pblk, factory_init);
@@ -701,7 +701,6 @@ static int pblk_set_provision(struct pblk *pblk, int nr_free_chks)
 	 * on user capacity consider only provisioned blocks
 	 */
 	pblk->rl.total_blocks = nr_free_chks;
-	pblk->rl.nr_secs = nr_free_chks * geo->clba;
 
 	/* Consider sectors used for metadata */
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
@@ -1284,7 +1283,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 
 	pblk_info(pblk, "luns:%u, lines:%d, secs:%llu, buf entries:%u\n",
 			geo->all_luns, pblk->l_mg.nr_lines,
-			(unsigned long long)pblk->rl.nr_secs,
+			(unsigned long long)pblk->capacity,
 			pblk->rwb.nr_entries);
 
 	wake_up_process(pblk->writer_ts);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 0b7d5fb4548d..b8eb6bdb983b 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -568,7 +568,7 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
 		goto out;
 
 	/* logic error: lba out-of-bounds */
-	if (lba >= pblk->rl.nr_secs) {
+	if (lba >= pblk->capacity) {
 		WARN(1, "pblk: read lba out of bounds\n");
 		goto out;
 	}
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index d86f580036d3..83b467b5edc7 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -474,7 +474,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 
 		lba_list[paddr++] = cpu_to_le64(lba);
 
-		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
+		if (lba == ADDR_EMPTY || lba >= pblk->capacity)
 			continue;
 
 		line->nr_valid_lbas++;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index ac3ab778e976..58da72dbef45 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -305,7 +305,6 @@ struct pblk_rl {
 
 	struct timer_list u_timer;
 
-	unsigned long long nr_secs;
 	unsigned long total_blocks;
 
 	atomic_t free_blocks;		/* Total number of free blocks (+ OP) */
-- 
2.19.1


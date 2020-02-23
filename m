Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D33169998
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 20:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBWTX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 14:23:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37734 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBWTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:23:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so4169063pfn.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p/oWPc6dicg9Lm6g0PcQb0lWtpA8WNgqP72+bZZmonY=;
        b=VKzw8uUlmATaByLcG+SITEL5VM6hw6I/svwNEwCUy4G4KX5oOTqcsYrpP1nnbi/RKH
         kHhs+2sYN+A1KSVBIIpA8kLQHBlE1eaRb9zpcrAdCHAmS0ad26ca6mMxI/TVn7uP2sik
         7O1kAJA79hJUQETsCBUZ4KjwKBb0K+GzyDDues4afVo2wu3E75It1rDX5IaxbH1ECORd
         ifk5NRz5tbx2u6w9LTE/sphogeKnOEse+M9lKvffmar3aZiAffxGz30Qm3PUHXJCKMlQ
         aVK7tm7dSyS6Gev4pKRK32Y0tpZprTsLDPKfdlhRw+xSWZvvrGqGxkBm7X/53YGPJU86
         0c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p/oWPc6dicg9Lm6g0PcQb0lWtpA8WNgqP72+bZZmonY=;
        b=HV8Bs2Oxh5KyR286gPJ3SJg1LRkk2zc5YTWKkWQSwCjemkuh8FkE1d83ajeITWHB3n
         DBYPtaTpyP15sSzteuF8g0hq1m/iXpQBt05jDJwI+DOGsKcdG/Iekd1hYB6GFm5JNB2D
         Duj+HQuBgPtxDnPk/JE2bEd14kslgzROZlHKdX3lRsz+UbMDkjGBdoNfIK/iPF6RdRUv
         q0C+xXxT9EgE5kwRgjFxC5ptZMDOf3TJfD0zhp5WhhXw8sgQUNBYxCXNCltFr/jjDR8A
         GXBrAQ+OdF2V/AD2iDLEezXIvRbMzkLti5Pc/eE8IIEh5Y+JpZhPYTt1ie7MAYnWWFWb
         jEcw==
X-Gm-Message-State: APjAAAUTQpaMxxT801/mtskroXteAFZQjbPRrHoEbbkM7COxgzcq4oBE
        d4eIFkVnvojfg8Rgco5M79THmLdSKAhsMA==
X-Google-Smtp-Source: APXvYqzxuAgacRkNNWJYsDpRQyDXBIH0scB/6/cfNf3UgciFb96UiJWOm0qx1Wgod3g/nR3VG8hc6A==
X-Received: by 2002:a63:291:: with SMTP id 139mr42809093pgc.342.1582485835006;
        Sun, 23 Feb 2020 11:23:55 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id f43sm9614614pje.23.2020.02.23.11.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2020 11:23:54 -0800 (PST)
Date:   Mon, 24 Feb 2020 00:53:47 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: remove sync_alloc_bitmap()
Message-ID: <20200223192347.GA20286@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sync_alloc_bitmap() is not called anywhere, hence remove it from
exfat_core.c and exfat.h

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/exfat/exfat.h      |  1 -
 drivers/staging/exfat/exfat_core.c | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 1867d47d2394..4a0a481fe010 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -665,7 +665,6 @@ void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 /* allocation bitmap management functions */
 s32 load_alloc_bitmap(struct super_block *sb);
 void free_alloc_bitmap(struct super_block *sb);
-void sync_alloc_bitmap(struct super_block *sb);
 
 /* upcase table management functions */
 s32 load_upcase_table(struct super_block *sb);
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 7308e50c0aaf..d30dc050411e 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -561,18 +561,6 @@ void free_alloc_bitmap(struct super_block *sb)
 	p_fs->vol_amap = NULL;
 }
 
-void sync_alloc_bitmap(struct super_block *sb)
-{
-	int i;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	if (!p_fs->vol_amap)
-		return;
-
-	for (i = 0; i < p_fs->map_sectors; i++)
-		sync_dirty_buffer(p_fs->vol_amap[i]);
-}
-
 /*
  *  Upcase table Management Functions
  */
-- 
2.17.1


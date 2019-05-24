Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D646228F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 05:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbfEXDNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 23:13:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37238 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbfEXDNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:13:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so3563720pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 20:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SADUbUTzsKuL6+0zlFN554wz3Ug1cJN9qaVymCYLya8=;
        b=RkRTYY+3hCLgYqP2p+u+vpPJcIgR7UCLzQVOZl9uOyK1n3lrfRyg3ucE3OwGPk9P+P
         tLqwZbaVRXdBtc+0DB1TZU+dOnf2fVy3XzzMaozUAPfUS7T4BerAEIx3U0BwTrIpAbgu
         qLtLDLrTExsuU55T39GAzXMZXAKwO71fUxxMl2m1lMOO5++FwxOK3wbIu6GyfxRh5N0l
         dfPD8qf2iIcp9eetBCLwPJvPBr60mdgGEuu5OLeNGSZP8Dqd39y6BJssucc2z9/MN2T4
         LoO2I9Qff2ZTZj2Eh7XtljAR7+yoO5T15x39zK54CNISqcbKOuHqo4Hd+/u/uYDWfrhO
         n/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SADUbUTzsKuL6+0zlFN554wz3Ug1cJN9qaVymCYLya8=;
        b=N/v92FoJXJhlsNj7eyHfyZApeb61RvPFxlDxZ4CYVrvH7K37V4mnZ+HEI2OO3U48n5
         fpeS7c0ySu2s5MkzIXtL37Uc7Gk9yoSovjXvbqfli/rb9jdD3ZYAiTTvux55jdWjHI0y
         AYMatMjwB/oBIUdfpv25zQTRT+sHqiEu94yCRAj3DiPW2q0jWA6ULgtChhcrNjTK1ezM
         8xe0wFmpH0/7UY9HpFqtlAGRtpY/GneC20uK7vREckhwaHWM5dPXpDQVXodL6vcWDUB2
         tjJHYdQ9SACjwi1s+rXZIQWE2hC1jaCtTtv3UV8pq/RY4L9dLrCQ1M4jw9JDW+9NmYv0
         XHkA==
X-Gm-Message-State: APjAAAU66AGdZbMRmtWbxO8OqywqD/U1mhv6szD9fsgQvL9jatNmhspt
        djuC7p3M6BHB9BPyifhGCDi5Jwo73a4=
X-Google-Smtp-Source: APXvYqwx+3Ni5mzChJHEGu89s31328M3giHbmL30qpfZhaPz2GvtZ7v0kNlaEDRChzrpyQdQ6bnsNw==
X-Received: by 2002:a17:902:b615:: with SMTP id b21mr40159692pls.12.1558667596052;
        Thu, 23 May 2019 20:13:16 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e10sm909308pfm.137.2019.05.23.20.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 20:13:15 -0700 (PDT)
Date:   Fri, 24 May 2019 11:12:48 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dm-region-hash: Fix a missing-check bug in __rh_alloc()
Message-ID: <20190524031248.GA6295@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function __rh_alloc(), the pointer nreg is allocated a memory space
via kmalloc(). And it is used in the following codes. However, when 
there is a memory allocation error, kmalloc() fails. Thus null pointer
dereference may happen. And it will cause the kernel to crash. Therefore,
we should check the return value and handle the error.
Further, in __rh_find(), we should also check the return value and
handle the error.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
index 1f76045..2fa1641 100644
--- a/drivers/md/dm-region-hash.c
+++ b/drivers/md/dm-region-hash.c
@@ -290,8 +290,11 @@ static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
 	struct dm_region *reg, *nreg;
 
 	nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
-	if (unlikely(!nreg))
+	if (unlikely(!nreg)) {
 		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
+		if (!nreg)
+			return NULL;
+	}
 
 	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
 		      DM_RH_CLEAN : DM_RH_NOSYNC;
@@ -329,6 +332,8 @@ static struct dm_region *__rh_find(struct dm_region_hash *rh, region_t region)
 	if (!reg) {
 		read_unlock(&rh->hash_lock);
 		reg = __rh_alloc(rh, region);
+		if (!reg)
+			return NULL;
 		read_lock(&rh->hash_lock);
 	}
 
---

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB656A5392
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfIBKFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 06:05:10 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25507 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbfIBKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:05:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567418704; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=TM+4mEo1xD2rzEeOfUxWndcC3p0c8zhKYLLPAqM/BOV14zqFaKumCXx8Zy6hu/18AsOsP+TPVaeLZ6bVemP8diEYHDUtiSrdc+2uwGNy4KNQ9PLRA9IP62A95m4Zdq78av9OhLMHjmxQpvXd4kGpx5CBmWAKV71d+vLLd295Bno=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1567418704; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=Ot31l6YpX1Hep2bcCR1LFgbNEtu8dKylpOjGYbOxviM=; 
        b=biMCUT0zeW4LfaIQz+uiKhh4+fQoHdfApmOIaEMmq+7+RRv2qfDaiGqns4/K9isfdmumv+kaCUScwZIeIdCf0Hk2pPEnySpR5NS0qnsjXthJDtrJx+tzUld6g0W1c/0cjbkdCS9FhSYzfVBhoqUKbBEwdsg/BDJ1UYZ6uXHz+zQ=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=czy/eCu1ugpkJGhENvNLqYJWEHDA7rdgLAiR+89XIzN4M3F28ach6VP6qA3xNdZmujT7mhNHokCP
    rqxXqCcUvxCnXrXxzODJoYdpApi/RsxExfeDwO8ISwt71/kfEhTG  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1567418704;
        s=zm2019; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=911;
        bh=Ot31l6YpX1Hep2bcCR1LFgbNEtu8dKylpOjGYbOxviM=;
        b=QxLgzFE7GjTrKP6CgR4RAKH6pA4VZ3f28TEBGKKPr1hYWk8Xibf9nCE9OxBkS4iw
        1u0MfRITi23bPn3e5Oq61rL25siCq5jjD2Y7XUDNVgiuF5iIdKM/SAaWR92UyuYTaDv
        Jedy067xd+CjwOPefeZo8UCAM0joTFR8j3Ui7COc=
Received: from YEHS1XPF1D05WL.lenovo.com (111.205.43.251 [111.205.43.251]) by mx.zohomail.com
        with SMTPS id 1567418703324628.2466891855994; Mon, 2 Sep 2019 03:05:03 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, tyu1@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm writecache: skip writecache_wait for pmem mode
Date:   Mon,  2 Sep 2019 18:04:50 +0800
Message-Id: <20190902100450.10600-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The array bio_in_progress[2] only have chance to be increased and
decreased with ssd mode. For pmem mode, they are not involved at all.
So skip writecache_wait_for_ios in writecache_flush for pmem.

Suggested-by: Doris Yu <tyu1@lenovo.com>
Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index c481947..d06b8aa 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -726,7 +726,8 @@ static void writecache_flush(struct dm_writecache *wc)
 	}
 	writecache_commit_flushed(wc);
 
-	writecache_wait_for_ios(wc, WRITE);
+	if (!WC_MODE_PMEM(wc))
+		writecache_wait_for_ios(wc, WRITE);
 
 	wc->seq_count++;
 	pmem_assign(sb(wc)->seq_count, cpu_to_le64(wc->seq_count));
-- 
1.8.3.1



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDB61D139
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfENVXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 17:23:19 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:52942 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfENVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:23:19 -0400
Received: by mail-ot1-f74.google.com with SMTP id t17so160359otp.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eeCk7+ZeaGS0zOYMgnht4wfwSEDnFnUqNORnM8SadLc=;
        b=KhlkHLib2ZPt4MDKCmX3c5l6XUgu0JVLpDWiWLHfXrPp0hxxZkxpHxkH1XrFOsEM89
         FqNJrRBNOCGPmvxx/zTZh4CXK32vZVQOu449TEHyRwOl0xnrhtyLa5z/ZyuYbcd+jTg5
         egg2OAqF68EFnUsvjahoKCziQ6IvuYM8te2XZIJZniMKC6HLA9NMfvOtJb3qkeCrdMsa
         BjOXZkMLhKCypZnpp9MS2yg4/hlRIbuFNjmwh/1nqJE0iEB6bHqQk5Julg/FopkKbaTy
         0rtCntR1kgrRaYkAYomFcUibIOJGio6AG65oPwzdJZyLNYTDw6AjveM4efi10hjnRFHQ
         waoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eeCk7+ZeaGS0zOYMgnht4wfwSEDnFnUqNORnM8SadLc=;
        b=qYmxbNChoNvtoL6ICIyJI7JozR/SJ5J53mNVp4SE6icseMuc/lmF+EyPadoAQM4/VX
         4Cs6i+GvtashSdYvyx381iiuBOytu7MfJa/wLDrCc/HZvvMWZdY+eRSxosB6lFivITWc
         ZOzBi21zXf/ZlFU6RY7VN6mn1pbaeCM2A+/qxMqjTySmHSK+27oaCu7vwQZOce4k++Ng
         bQH2amcvdpSPj1mUf4vJgjBBsCe1IrEdB1F3QdnoTRpV0PIeUZBZoMn2LS/fiuNBv0Ky
         GQTks714/fz4I0OFqCHX3EsBugnwNLe6lH1EdMBwHkaBYIz4SVRCiBNnNDojdX+jtYGe
         A6Uw==
X-Gm-Message-State: APjAAAWEJi83MwFPpeNIiRHeue7hRtRVhUSdNnNJUog5YSx3FByxmOr+
        Y92s2l/uD0VvdrS/ewwTaskG0fp25QdYEA==
X-Google-Smtp-Source: APXvYqyZAuGU/XaFCSkGl6IOZEqgfvmlg+RqkdHfDZ0i4BaPmxmcfnZJdw9EanHQZrulIbxHkwi9al4HwyjzeQ==
X-Received: by 2002:aca:ef8a:: with SMTP id n132mr4290624oih.98.1557868998432;
 Tue, 14 May 2019 14:23:18 -0700 (PDT)
Date:   Tue, 14 May 2019 14:22:58 -0700
Message-Id: <20190514212259.156585-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3 1/2] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
OOM killer will not be triggered and indeed the page alloc does not
invoke OOM killer for such allocations. However we do trigger memcg
OOM killer for __GFP_RETRY_MAYFAIL. Fix that. This flag will used later
to not trigger oom-killer in the charging path for fanotify and inotify
event allocations.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changelog since v2:
- None

Changelog since v1:
- commit message updated

 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2535e54e7989..9548dfcae432 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2294,7 +2294,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long nr_reclaimed;
 	bool may_swap = true;
 	bool drained = false;
-	bool oomed = false;
 	enum oom_status oom_status;
 
 	if (mem_cgroup_is_root(memcg))
@@ -2381,7 +2380,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (nr_retries--)
 		goto retry;
 
-	if (gfp_mask & __GFP_RETRY_MAYFAIL && oomed)
+	if (gfp_mask & __GFP_RETRY_MAYFAIL)
 		goto nomem;
 
 	if (gfp_mask & __GFP_NOFAIL)
@@ -2400,7 +2399,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	switch (oom_status) {
 	case OOM_SUCCESS:
 		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
-		oomed = true;
 		goto retry;
 	case OOM_FAILED:
 		goto force;
-- 
2.21.0.1020.gf2820cf01a-goog


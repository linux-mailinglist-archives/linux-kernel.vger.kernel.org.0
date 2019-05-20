Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A4022AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 06:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfETEt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 00:49:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37891 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETEt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 00:49:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id b76so6575747pfb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 21:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkToWfPhUbXUlBSKuzZG3pFF8m3+cgJ3j1xebIaK/EI=;
        b=mI5vScJ46CfONQKk0BXuJqgqaOpncnnzaBz3sQRykYdFNJRSapviixTBiuyNXhv3Lj
         IKXhEYu8bwmxqqhsj4jf31vawxOk5hgaSWCzkrl3jSNirETmZA+np4paeXOlSZGefx++
         v/lIzQqsOCjlows+Onq9agp+5xzN+dFq06s1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkToWfPhUbXUlBSKuzZG3pFF8m3+cgJ3j1xebIaK/EI=;
        b=MH4xeuI4O/WqxVWN3ID0d++4JtFVS7qbYO3f/WYIWu2FnxR1ngoQ2/6ylo9+YSNojR
         /8qWtgRVIE2171EzP0OSbNbubSpspiEjl4cTIq6FvUC/DaCZOZDCG9s1BGGUFmj/KQSu
         BHIDsOEB21aIIfoQ1LuWV8d7wBuCxt9XD/cZdAUXhiajRT0EANFAikTBTIFDlIImTrO8
         U8QIomLMYj+KVeKMv9LW89OtgsbTf/YPNpEWWH8fK+LQ6aO0cUcM5qmHRkWCU9CrG6iJ
         KvBeYTxyoc/O2FZWn4RK9MA6iupmZcWkEM9az4EoOlsSm4C7YPohrCvjEC6uDAcCx2Ye
         Pswg==
X-Gm-Message-State: APjAAAVKw8Yzjht5majKxw+uawlQa0g9Qfr+SWmI643b/b7YNSn3UpeW
        wh7/snoHHQ092VguOOJq96m05A==
X-Google-Smtp-Source: APXvYqwN55gQbIsuZenQKAzA8VBSQYQ1vm8yCPL9giuGjnZvDoaeAZMfk2h4f+nYBl2QObZZzuXkCQ==
X-Received: by 2002:a62:ee05:: with SMTP id e5mr76083541pfi.117.1558327798179;
        Sun, 19 May 2019 21:49:58 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id 140sm26022608pfw.123.2019.05.19.21.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 21:49:57 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/failslab: By default, do not fail allocations with direct reclaim only
Date:   Mon, 20 May 2019 12:49:51 +0800
Message-Id: <20190520044951.248096-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When failslab was originally written, the intention of the
"ignore-gfp-wait" flag default value ("N") was to fail
GFP_ATOMIC allocations. Those were defined as (__GFP_HIGH),
and the code would test for __GFP_WAIT (0x10u).

However, since then, __GFP_WAIT was replaced by __GFP_RECLAIM
(___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM), and GFP_ATOMIC is
now defined as (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM).

This means that when the flag is false, almost no allocation
ever fails (as even GFP_ATOMIC allocations contain
__GFP_KSWAPD_RECLAIM).

Restore the original intent of the code, by ignoring calls
that directly reclaim only (___GFP_DIRECT_RECLAIM), and thus,
failing GFP_ATOMIC calls again by default.

Fixes: 71baba4b92dc1fa1 ("mm, page_alloc: rename __GFP_WAIT to __GFP_RECLAIM")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 mm/failslab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/failslab.c b/mm/failslab.c
index ec5aad211c5be97..33efcb60e633c0a 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -23,7 +23,8 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 	if (gfpflags & __GFP_NOFAIL)
 		return false;
 
-	if (failslab.ignore_gfp_reclaim && (gfpflags & __GFP_RECLAIM))
+	if (failslab.ignore_gfp_reclaim &&
+			(gfpflags & ___GFP_DIRECT_RECLAIM))
 		return false;
 
 	if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
-- 
2.21.0.1020.gf2820cf01a-goog


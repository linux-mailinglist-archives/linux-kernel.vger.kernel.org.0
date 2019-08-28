Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C69BA02CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH1NNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 09:13:44 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:37799 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1NNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:13:43 -0400
Received: by mail-vs1-f74.google.com with SMTP id r17so481375vsp.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2uraJyf6YkQQQi+GjgA0Euznea67jY0h3NcNTgfEE6E=;
        b=krpjyvPl4LV2Qp+9bxrX89f65tIa90HGC+HFV5rCeRCZ2Kify9kiCPez94yN8srqEe
         lF+iaLa/UcZn4j756/FDjGcCZ0fi4GAImCz5nAKjfHbDVT4WihMlJOA0Oqe8/oU0YGwb
         Ld33DNMmuOqncMmBjsxdkFdvO20z+TkgT4PefRIYKIBpXFcXzihDFcx0+HYRLWrzVt0z
         Y7v7VnMqtFJ/H51CNlWRxy/3Fa6SCQyge9Dfc/AvqyjN+8IBUTQoqfTpv9OXaM4uCDMu
         tTEYpdiWaBNUKVP37xirxcot4wu+OthQfooyIBAkDMtVrRe6c9qMKF2yFsg7vRx5S76T
         eOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2uraJyf6YkQQQi+GjgA0Euznea67jY0h3NcNTgfEE6E=;
        b=QVMhtTreubGrX7LW063iXGJmkeKONvjrbHlInZqeXPXLYMnjCUDzpymzB6lqxxOBIG
         Vz2zRQw/TOhTwMyc0/SdZ/hEuVp8D5BML7Qoi/6fSPATCGd/W4Pkm7nB+2ZG5+p4cUut
         uOpL9g7wEbEnGtjb0+09Va7tQ/c7ck4uqYCZdQZHHV/7YKkbiXwBpaBVWsjMDwrKcbpC
         LPK09noAmUINhVSQmBY+nWJn8/wXeKsQU3t4cDVjn1+ezZSp3jsGJZ2PQbb/wWCfoVGL
         UNY8gg1XDGcq+2WAaP7Idp0F2fa+rXc560UZzf3dRy4JHKpJuEnX52wuQoTWCd3Ov1UH
         OHpA==
X-Gm-Message-State: APjAAAVXl1LOO24YnpzMFezkXVYQGETBqM93g6ZzNtPoDk9H/ETw4PiM
        3GolDK2U42TOgr4qJTwI2LV3jogrZ8O1Gg==
X-Google-Smtp-Source: APXvYqxwaE69Ih/IcaBEjoZYAtqpyYGYen7SRacn6ADCDqJa8PItgJpR3VuZvxi6a1jkwLHNsHIcq0P0fvxZJQ==
X-Received: by 2002:a67:d02:: with SMTP id 2mr2090357vsn.43.1566998022308;
 Wed, 28 Aug 2019 06:13:42 -0700 (PDT)
Date:   Wed, 28 Aug 2019 06:13:38 -0700
Message-Id: <20190828131338.89832-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] iommu/iova: avoid false sharing on fq_timer_on
From:   Eric Dumazet <edumazet@google.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jinyu Qi <jinyuqi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 14bd9a607f90 ("iommu/iova: Separate atomic variables
to improve performance") Jinyu Qi identified that the atomic_cmpxchg()
in queue_iova() was causing a performance loss and moved critical fields
so that the false sharing would not impact them.

However, avoiding the false sharing in the first place seems easy.
We should attempt the atomic_cmpxchg() no more than 100 times
per second. Adding an atomic_read() will keep the cache
line mostly shared.

This false sharing came with commit 9a005a800ae8
("iommu/iova: Add flush timer").

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jinyu Qi <jinyuqi@huawei.com>
Cc: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iova.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 3e1a8a6755723a927a7942a7429ab7e6c19a0027..41c605b0058f9615c2dbdd83f1de2404a9b1d255 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -577,7 +577,9 @@ void queue_iova(struct iova_domain *iovad,
 
 	spin_unlock_irqrestore(&fq->lock, flags);
 
-	if (atomic_cmpxchg(&iovad->fq_timer_on, 0, 1) == 0)
+	/* Avoid false sharing as much as possible. */
+	if (!atomic_read(&iovad->fq_timer_on) &&
+	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
 		mod_timer(&iovad->fq_timer,
 			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
 }
-- 
2.23.0.187.g17f5b7556c-goog


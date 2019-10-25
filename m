Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB0E445C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436592AbfJYH0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 03:26:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51874 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436532AbfJYH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:26:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so905073wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pRXYeWKUORo8utPtv70wDXbv/nqcWSG3JUe6r/PfEI=;
        b=YYlLYoDROqbWwUtfTPNjepxcl8HiTTjq5OIslAlcY4i1JtM2Veu/FyZJRtpqTpSiMe
         1TleEkPufyv41ZtdooikuHD97vptVcZ1YyUYgasNn7hQ9VNXoTzP5084+6yF74jSe03l
         5hYNuR1/n+QFteqaOoM0ohdoWkU7hMjdzRJcGokVDkC4imte9om91uKM36IJv2niDzlH
         GasMWrE5K1mC0iEJFe3zuy2tOCsO5ubGrB+xjajoIXhgqlCgl/OgvX733B6i+59wxksH
         jXVR96nxhkqAz2gU34tW180p00ElVE5geNNre8egTS21Mz8xPew3lmjpcLWR5AybSb02
         8AQA==
X-Gm-Message-State: APjAAAXDyRTVPNjGszozn2xUjQnZsgNGekYqbzER0LWway/AoM9519yG
        rBnb36kKWWMEgprSCjAZoZw=
X-Google-Smtp-Source: APXvYqzgotUGDCUQZwM9Vsb9uUsTRPRHVKF/iMxe3DUbcp0XuhY2DFbbJPpjicLQ/VwOXq0aoTMlFw==
X-Received: by 2002:a7b:c925:: with SMTP id h5mr1832355wml.61.1571988389054;
        Fri, 25 Oct 2019 00:26:29 -0700 (PDT)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x21sm1482446wmj.42.2019.10.25.00.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 00:26:28 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by /proc/pagetypeinfo
Date:   Fri, 25 Oct 2019 09:26:10 +0200
Message-Id: <20191025072610.18526-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025072610.18526-1-mhocko@kernel.org>
References: <20191025072610.18526-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
This is not really nice because it blocks both any interrupts on that
cpu and the page allocator. On large machines this might even trigger
the hard lockup detector.

Considering the pagetypeinfo is a debugging tool we do not really need
exact numbers here. The primary reason to look at the outuput is to see
how pageblocks are spread among different migratetypes and low number of
pages is much more interesting therefore putting a bound on the number
of pages on the free_list sounds like a reasonable tradeoff.

The new output will simply tell
[...]
Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648

instead of
Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  41019  31560  23996  10054   3229    983    648

The limit has been chosen arbitrary and it is a subject of a future
change should there be a need for that.

While we are at it, also drop the zone lock after each free_list
iteration which will help with the IRQ and page allocator responsiveness
even further as the IRQ lock held time is always bound to those 100k
pages.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmstat.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4e885ecd44d1..ddb89f4e0486 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1383,12 +1383,29 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 			unsigned long freecount = 0;
 			struct free_area *area;
 			struct list_head *curr;
+			bool overflow = false;
 
 			area = &(zone->free_area[order]);
 
-			list_for_each(curr, &area->free_list[mtype])
-				freecount++;
-			seq_printf(m, "%6lu ", freecount);
+			list_for_each(curr, &area->free_list[mtype]) {
+				/*
+				 * Cap the free_list iteration because it might
+				 * be really large and we are under a spinlock
+				 * so a long time spent here could trigger a
+				 * hard lockup detector. Anyway this is a
+				 * debugging tool so knowing there is a handful
+				 * of pages in this order should be more than
+				 * sufficient
+				 */
+				if (++freecount >= 100000) {
+					overflow = true;
+					break;
+				}
+			}
+			seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
+			spin_unlock_irq(&zone->lock);
+			cond_resched();
+			spin_lock_irq(&zone->lock);
 		}
 		seq_putc(m, '\n');
 	}
-- 
2.20.1


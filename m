Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34AEF16608E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgBTPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 10:11:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728079AbgBTPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582211472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/w+hkaHbcwTCv2DnISajtPMXZj1KshVLgpzoXr7emTA=;
        b=duspK3eDJ+4i79QVie9eq/zor3NGDOknCs7woOTLWSPVaVYV0iyNl+xkwQ8Hhc/mmEvWJ1
        aPq28ojs+ZQOr1DPWNl6ewo8MAlt+nrZLc9ag4k6nx4EjbA5gRpz7FIoYvLz2Se4Y+BsLu
        39/emG6GurV4q2Mt8y6iuXgPpuGnCnc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-4GDzG-EOMOe1BZ0G7n1uCw-1; Thu, 20 Feb 2020 10:11:07 -0500
X-MC-Unique: 4GDzG-EOMOe1BZ0G7n1uCw-1
Received: by mail-qt1-f197.google.com with SMTP id l1so2742823qtp.21
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/w+hkaHbcwTCv2DnISajtPMXZj1KshVLgpzoXr7emTA=;
        b=Gqopte70c1NUlbKT2bycdr8VGfNcq4Pl+NTl3NdTq/8gk6KrRCp6Lg4U2gBlmFOSoy
         Ac8Ax78VtxLFckbYn2GmmFLR6XxDD5J8GkzUryh4WJWk2j9HGWuDuLT5oSZGK0Zig5By
         SrQjTSmq9Ex03UI/nZgvXKIMEdVXn4xJNq+GNlOovhig9S7wthrk7AiGx/hO3iWLcwJF
         7ZZWWEKFsgDUKEO9Z7eEATpL556EsQXMavDkvZpsFgrtEIxYZpSs2rCV1i5GUllOMKxK
         buAgduiWJ+/6NpN6qvGDS1Gx3tPq/5bIipo7gVGNvF8XC9UNrtz+hTPvv35PGpKHEGeV
         C7aQ==
X-Gm-Message-State: APjAAAUOgLCP1WehgZwk95Esyyyed1a+EDPmHgnuYw+9eSC2WmwHjgUg
        1NXD1E8bHDyLeXnChs9toLwZPlsAsjMlQeRcX94MHRHSEw/koDq9T5XkcF2tnWZTRCu9XXlwFqZ
        zhCSneDLmWiN1yUGkhdxJnWcD
X-Received: by 2002:a05:620a:a46:: with SMTP id j6mr8265966qka.109.1582211466811;
        Thu, 20 Feb 2020 07:11:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwR7hidHlSuEeLLLMqn+MwWLL469eKR6zA2KtaXbpUkzYziS8akYXrX2mtQwFOIflqeB0axFA==
X-Received: by 2002:a05:620a:a46:: with SMTP id j6mr8265940qka.109.1582211466592;
        Thu, 20 Feb 2020 07:11:06 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id u12sm1756003qke.67.2020.02.20.07.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:11:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Martin Cracauer <cracauer@cons.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Brian Geffon <bgeffon@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        David Hildenbrand <david@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH v6 05/16] arc/mm: Use helper fault_signal_pending()
Date:   Thu, 20 Feb 2020 10:11:04 -0500
Message-Id: <20200220151104.6183-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220145432.4561-1-peterx@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let ARC to use the new helper fault_signal_pending() by moving the
signal check out of the retry logic as standalone.  This should also
helps to simplify the code a bit.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arc/mm/fault.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index fb86bc3e9b35..6eb821a59b49 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -133,29 +133,21 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 
 	fault = handle_mm_fault(vma, address, flags);
 
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return;
+	}
+
 	/*
-	 * Fault retry nuances
+	 * Fault retry nuances, mmap_sem already relinquished by core mm
 	 */
-	if (unlikely(fault & VM_FAULT_RETRY)) {
-
-		/*
-		 * If fault needs to be retried, handle any pending signals
-		 * first (by returning to user mode).
-		 * mmap_sem already relinquished by core mm for RETRY case
-		 */
-		if (fatal_signal_pending(current)) {
-			if (!user_mode(regs))
-				goto no_context;
-			return;
-		}
-		/*
-		 * retry state machine
-		 */
-		if (flags & FAULT_FLAG_ALLOW_RETRY) {
-			flags &= ~FAULT_FLAG_ALLOW_RETRY;
-			flags |= FAULT_FLAG_TRIED;
-			goto retry;
-		}
+	if (unlikely((fault & VM_FAULT_RETRY) &&
+		     (flags & FAULT_FLAG_ALLOW_RETRY))) {
+		flags &= ~FAULT_FLAG_ALLOW_RETRY;
+		flags |= FAULT_FLAG_TRIED;
+		goto retry;
 	}
 
 bad_area:
-- 
2.24.1


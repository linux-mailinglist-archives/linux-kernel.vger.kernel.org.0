Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3902B83D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 17:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfE0PTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 11:19:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46886 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfE0PS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:18:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id m15so179641ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fnFIhfm6w+x6vlcZglDCubHYA2sqJDEBTXH+zDoT54E=;
        b=LP7CSZt6yjO7TpmhKCv3v+8DJMO2A46jdg+f6i14O7xUfZWn1qqLhb1pn7G/EOL3NF
         M9MRMawjq1deUOJNL9bVuotbqGM2QuXsCUIcp1lHT6GhYqpIpXQbdBhyaAFNr5vdMnLB
         a1uEgo51KSrkUe2rbBT12sksoTeRtWAbFZEKJi3N7N5JC5D5MKb325dYOfEk3KLhXD41
         yk+jQLdJG2hq/K1StoQtquSdmIcdtpl5zZiGP/EUk9NeQSg1ICoR9YHUizAYhfQjI1aT
         KbvtEuqIdohzLKfNtmGmC+/oeq6zQ2HP1YmLTYuZmRZ0zUrc69FwEBCRoOMIOU5UaPrW
         JXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fnFIhfm6w+x6vlcZglDCubHYA2sqJDEBTXH+zDoT54E=;
        b=d0U08WaO1Xy/9Ppb4wrylO5IK0bmouA0sHlEqV5rcwJ4nbkyl4d9sH3BkyiDxffFZI
         x4NAq3lCgL3rSV1hv5VAUP/8kdNDU1DqABuGzDu3N30uzh1bhjfhpvVdBNZzDIiNiSSN
         Sxg5H+hYafu9KAI9oCeWTdapvKBdtd8gwp9aYFGzkrVk+Yg5Ks8RdQ4pl6p8905AwLXD
         +wffdDJyli5TtI9ZHKSW3udw/ObE5ia5WG5X230ow/2NsQlmYRFQxYey1r2ZZp3Ctnhd
         AbLy2UtWvfP7y4zzPwd0AkfO133Wb7HKmJH+nBcN2FlHMlgn9GJSvyLzL14fFK+Ny5+N
         ErKA==
X-Gm-Message-State: APjAAAVIAW5vDXrCqmzQQ0psdwFAceRDWEfoacUMs2buWaxQDY5y835o
        1t2PivIPfFfscw8V8TH32TQ=
X-Google-Smtp-Source: APXvYqzzoOQnxbgmmjIK0XSAM1M3uz8HqRTeMQNMnp77GiwQQsoprM514MzE0VvHchBzfv5uumvn9Q==
X-Received: by 2002:a2e:89d2:: with SMTP id c18mr6711906ljk.203.1558970336312;
        Mon, 27 May 2019 08:18:56 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id h25sm2308701ljb.80.2019.05.27.08.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 08:18:55 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 1/4] mm/vmap: remove "node" argument
Date:   Mon, 27 May 2019 17:18:40 +0200
Message-Id: <20190527151843.27416-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190527151843.27416-1-urezki@gmail.com>
References: <20190527151843.27416-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused argument from the __alloc_vmap_area() function.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c42872ed82ac..ea1b65fac599 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -985,7 +985,7 @@ adjust_va_to_fit_type(struct vmap_area *va,
  */
 static __always_inline unsigned long
 __alloc_vmap_area(unsigned long size, unsigned long align,
-	unsigned long vstart, unsigned long vend, int node)
+	unsigned long vstart, unsigned long vend)
 {
 	unsigned long nva_start_addr;
 	struct vmap_area *va;
@@ -1062,7 +1062,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
 	 */
-	addr = __alloc_vmap_area(size, align, vstart, vend, node);
+	addr = __alloc_vmap_area(size, align, vstart, vend);
 	if (unlikely(addr == vend))
 		goto overflow;
 
-- 
2.11.0


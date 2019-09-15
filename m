Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E44B30F2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfIOQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 12:52:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33264 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfIOQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:52:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so21122232pfl.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X86RdWoaDKqJbFDIoXti2bda7+kkyeUkiLhSN5JzlKU=;
        b=UVlqUskFF6lnSRhNIDONapUfjNYD1Nk3plqN/bZfrOxvI8jXvH2brUc3nFqa8l6/m2
         bzJoXmb99FvFIz8wmkMhFV8OrapnQW+3rgFRcQi84Q0rv0sEXDlzjG35LkxFo4BzBimx
         E/DEAi8w4LF2wNQ9W3KGhbSNq5T9370tn/2S3iEdZ31+bKcaRwRryklJJW1LxakGJwP2
         hmryWpIP5WkJwKDqp2xJL8DpIbGmxZLsRXNr1cJQReJNW2y3Wzy84f0UJnpanyBiaQKz
         HkHjvIcUU5OcKS+Dn6CCbRB2JjmXiiti8WZT7vWc8yYfL/iWgQMPtA78P41UWqUpkpGY
         eHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X86RdWoaDKqJbFDIoXti2bda7+kkyeUkiLhSN5JzlKU=;
        b=KAhcYDBoHnH5QxAsw94bbRa7hh93Ym3AFL++sAwZkPPZygzZLwhcfPg3lkXASHMAtT
         RZn1AZVTACrQ5OdBylS1nurIzLAiPlRfO0Yk/DbwL8Cq9X8axDuqzKfnTz4dE8xZNdSC
         nzGKWpWCdV09F3LqWtIzUQEJ8Fsf28NcgwC56lu+9p0DhQCOazSk7iTRI8Il0XfMkC5e
         0W+IukWWcO4nHNpSyJEnSQO1C2/iorKyn+2eUpwtazJRt73DOPSpJ3zI32LG8/rINsQh
         tm9rXV4IETM68Ucw5ZThOlzPt5zKgnk6YhUbMoLc67VTbcRcEvp1XEdc2Qwql1H81rNF
         piyA==
X-Gm-Message-State: APjAAAWm/IBpv9uYPhsdItslY6hEFsgm9LKrvjLbs0ZdYZVwJmcin7Og
        g3BosH2KMZACUpHllBjWyGE=
X-Google-Smtp-Source: APXvYqyQaiQnRW16hsy9jw0my3XuKFz+xcp5uJlbcjwUKSbH+CeKDB0TSECOfjFQc1MEbcv3mxb3aw==
X-Received: by 2002:a62:5f83:: with SMTP id t125mr67798974pfb.125.1568566349157;
        Sun, 15 Sep 2019 09:52:29 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id a4sm4383259pgq.6.2019.09.15.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 09:52:28 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v4 3/7] mm, slab_common: Use enum kmalloc_cache_type to iterate over kmalloc caches
Date:   Mon, 16 Sep 2019 00:51:13 +0800
Message-Id: <20190915165121.7237-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915165121.7237-1-lpf.vector@gmail.com>
References: <20190915165121.7237-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of local variable *type* of new_kmalloc_cache() should
be enum kmalloc_cache_type instead of int, so correct it.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/slab_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8b542cfcc4f2..af45b5278fdc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1192,7 +1192,7 @@ void __init setup_kmalloc_cache_index_table(void)
 }
 
 static void __init
-new_kmalloc_cache(int idx, int type, slab_flags_t flags)
+new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
 	if (type == KMALLOC_RECLAIM)
 		flags |= SLAB_RECLAIM_ACCOUNT;
@@ -1210,7 +1210,8 @@ new_kmalloc_cache(int idx, int type, slab_flags_t flags)
  */
 void __init create_kmalloc_caches(slab_flags_t flags)
 {
-	int i, type;
+	int i;
+	enum kmalloc_cache_type type;
 
 	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
 		for (i = KMALLOC_SHIFT_LOW; i <= KMALLOC_SHIFT_HIGH; i++) {
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C40626CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389959AbfGHRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 13:06:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46198 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbfGHRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:06:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so7019095plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5b7anIeqnAhA6BO/lx8yoH/EvcoMVwex3ww0hx0nIBk=;
        b=nE4pF6WCSfy5375pasiGnK6x/BoAlKvJiEjKHA1Z6LC61rUtkohvgs+pMqeqoxrHeJ
         QaoQIYQBVzZdYmyimFzvOOvkufThmb+yZ/4JPuZk6Vll7Vgc2aPjWaiSruazPDixu8y+
         MC4cvlyfnXnFY2cPZh2uu8o6bDhtz0x/6j8cB//biI5O9TvD9bC+T/gL5B5tf7CHvRYr
         RxFPEo/q+Y4ypdM2KWGRBpOJoOMygvy5tt61wahtCaSnBQ7/twQqoocOOgu+BscuktVJ
         YlpYTN9kzOINtxTO6MsLndbEJJry/TBKMD8GLviUttA82JUu2V4o6hu6UgvfMjPuHWlN
         OseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5b7anIeqnAhA6BO/lx8yoH/EvcoMVwex3ww0hx0nIBk=;
        b=D0ef6vWKSvlE+JV5enMx4wJwSlc7zJdMyOrvEEU07QbGH7loJPW1rqhzsLUMNr/miR
         be3ri79bY6NyNRXj9fMoKzSW+KFBuOrUbBApv94lIequC7qdOIiPM/RbQI4ex/WgQ6+p
         2tZhlwATjXAFSZl4KncI86yRXQzJUP4MAW8nmxXrR2ZOpAgy2vhQsz4IbcOdkukbybIj
         RCWpq1czyakDqzhshRmwKVICBtZWMLNSaA+U6j1PIG1DABlv2AkaYpltMwmpqzJ/aP8x
         QHp+APcAyBbB5RpSnphZCm17to49LE5iwVomsmMm2L8CzeoDQwAACtgJ37G2izAL7kdB
         47gQ==
X-Gm-Message-State: APjAAAX2YGHjU22Zx+r3586V1fSXQJuUlmCFZY/tiA85/qcjHd38AZa6
        4QFpBww9QQ2Ot+uMZO9z5nM=
X-Google-Smtp-Source: APXvYqzt+il4zwPT6FRB06smT4nafOFmaW59SnLzajCBM2ImXEDODHJR8LpJ1IuBFwxXC7wAgigEgg==
X-Received: by 2002:a17:902:6a85:: with SMTP id n5mr24841812plk.73.1562605616776;
        Mon, 08 Jul 2019 10:06:56 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:b30:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id 30sm149551pjk.17.2019.07.08.10.06.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:06:56 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     urezki@gmail.com, rpenyaev@suse.de, peterz@infradead.org,
        guro@fb.com, rick.p.edgecombe@intel.com, rppt@linux.ibm.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH] mm/vmalloc.c: Remove always-true conditional in vmap_init_free_space
Date:   Tue,  9 Jul 2019 01:06:31 +0800
Message-Id: <20190708170631.2130-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unsigned long variables are subtracted from one another,
the result is always non-negative.

The vmap_area_list is sorted by address.

So the following two conditions are always true.

1) if (busy->va_start - vmap_start > 0)
2) if (vmap_end - vmap_start > 0)

Just remove them.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/vmalloc.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0f76cca32a1c..c7bdbdc18472 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1810,31 +1810,25 @@ static void vmap_init_free_space(void)
 	 *  |<--------------------------------->|
 	 */
 	list_for_each_entry(busy, &vmap_area_list, list) {
-		if (busy->va_start - vmap_start > 0) {
-			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
-			if (!WARN_ON_ONCE(!free)) {
-				free->va_start = vmap_start;
-				free->va_end = busy->va_start;
-
-				insert_vmap_area_augment(free, NULL,
-					&free_vmap_area_root,
-						&free_vmap_area_list);
-			}
-		}
-
-		vmap_start = busy->va_end;
-	}
-
-	if (vmap_end - vmap_start > 0) {
 		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
 		if (!WARN_ON_ONCE(!free)) {
 			free->va_start = vmap_start;
-			free->va_end = vmap_end;
+			free->va_end = busy->va_start;
 
 			insert_vmap_area_augment(free, NULL,
-				&free_vmap_area_root,
-					&free_vmap_area_list);
+				&free_vmap_area_root, &free_vmap_area_list);
 		}
+
+		vmap_start = busy->va_end;
+	}
+
+	free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
+	if (!WARN_ON_ONCE(!free)) {
+		free->va_start = vmap_start;
+		free->va_end = vmap_end;
+
+		insert_vmap_area_augment(free, NULL,
+			&free_vmap_area_root, &free_vmap_area_list);
 	}
 }
 
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F13373BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfFFMEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 08:04:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39648 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfFFME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:04:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so1339591lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MRxFMmBYeOcfOROJA3F+SVmsyybL0BND7saL3kxCMEU=;
        b=HZ7EcqzL4NXZJzoiyoS9j++T2BZmiWFS/5supBxv2WREp5utcc2p1e588OOZ5xSNFt
         lOdr/giv7KKtNLnKC0lm93kxocNgZ6XAP7DOLCF6mw1MZCuSBGNwv+lGqsWRRda4xk2B
         EvYkslYRyZ0dtuqmylqJRfav/pe9jVzRphHERGN+/D85P2QG4lQx6HVGNWKKMEIV4pG8
         wDe9lmHq0DBwRfRSlwnVXTWpasBqCshZ595Ti0/Z8Rz+v9ZfpzjqB5EQOvo0DdWAPayH
         YFh83gtmcnRu7LvFejwYzB+0YOPnwHJqq/zuLz/OZhSR/Z+s3+b8MURxt4oM+YIOcDqB
         l/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MRxFMmBYeOcfOROJA3F+SVmsyybL0BND7saL3kxCMEU=;
        b=uR4M68qA5twrJEYu4QGh4hy3ltfUys6t5T0RWdE0JV5D6iAq4yw/RVqQF+IeOuBsGG
         qsS+WmaqFsddwTeqDmGmRWW34UakhRNl7pyNaAJKqomOOFRW94NB/Uo2uX0a8z1mu+Of
         xvOYLj0q5PoDqb/yfZ+iWt1J9GJlT/AxipdRxuPeUfaJ6VVUZ4wAqKexWSVPj7gv9aFT
         DQnNfJpjfjMrTNi2cu9qicR3YB975bQz7hoOChLwVgwzJpbFeG6loVKFlfo9JjqkEmeD
         aikJDx2GuyC0YsOOdqfel8eG4CSg0ZBuClw0ZvH9t+1YQ7SrTBRd3YuzkTBpjMQR4g3o
         skZQ==
X-Gm-Message-State: APjAAAU5ea1VuxCHOHakuPmKHlIo/Osb6aaH0H9SvsiuSRUqLdXqYF2W
        YJC6uSamlHiBWMQg80kabCg=
X-Google-Smtp-Source: APXvYqyz5hDWDD6CLYMB1TnL2eHwqeiB8HW9gZoViWH7Xm7CCUACGnDGlIz+Y+5hFioLnk2Y+Xroag==
X-Received: by 2002:ac2:41d7:: with SMTP id d23mr20251558lfi.118.1559822667190;
        Thu, 06 Jun 2019 05:04:27 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l18sm309036lja.94.2019.06.06.05.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:04:26 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v5 3/4] mm/vmalloc.c: get rid of one single unlink_va() when merge
Date:   Thu,  6 Jun 2019 14:04:10 +0200
Message-Id: <20190606120411.8298-4-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190606120411.8298-1-urezki@gmail.com>
References: <20190606120411.8298-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not make sense to try to "unlink" the node that is definitely not
linked with a list nor tree.  On the first merge step VA just points to
the previously disconnected busy area.

On the second step, check if the node has been merged and do "unlink" if
so, because now it points to an object that must be linked.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Hillf Danton <hdanton@sina.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
 mm/vmalloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fcda966589a6..a4bdf5fc3512 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -719,9 +719,6 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
-
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
 
@@ -746,12 +743,11 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
+			if (merged)
+				unlink_va(va, root);
 
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
-
 			return;
 		}
 	}
-- 
2.11.0


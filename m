Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5185963CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfGIUmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 16:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbfGIUme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:42:34 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49F72073D;
        Tue,  9 Jul 2019 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562704953;
        bh=GEmvXXtJuZoeMjHkUNxrqjxRtgJkTpEtZUN+Li1Nq6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZmWqLO2MGKo9QjsetZzCTSXngUYeLKa3JvNAikweNYugfvLIbMiyers4p3kUwTi9C
         yxIgUZkvGl+xVfd/ZLwP1VlpGO5T/DWLw7rkl82b0lXLQnVh4JNtFeV9tBjlg59fqy
         9cd6v34dSORzhTUQygVKWLdrYVe4X3FSqiKRHKd0=
Date:   Tue, 9 Jul 2019 13:42:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20190709134233.b50814f5a789244b9bdb573e@linux-foundation.org>
In-Reply-To: <20190709211559.6ffd2f4e@canb.auug.org.au>
References: <20190709211559.6ffd2f4e@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 21:15:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arm-linux-gnueabi-ld: mm/list_lru.o: in function `list_lru_add':
> list_lru.c:(.text+0x1a0): undefined reference to `memcg_set_shrinker_bit'
> 
> Caused by commit
> 
>   ca37e9e5f18d ("mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix-2")
> 
> CONFIG_MEMCG is not set for this build.
> 
> I have reverted that commit for today.

Thanks.  This, I suppose:

--- a/include/linux/memcontrol.h~mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix-2-fix
+++ a/include/linux/memcontrol.h
@@ -1259,6 +1259,8 @@ static inline bool mem_cgroup_under_sock
 	} while ((memcg = parent_mem_cgroup(memcg)));
 	return false;
 }
+extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+                                  int nid, int shrinker_id);
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
@@ -1267,6 +1269,10 @@ static inline bool mem_cgroup_under_sock
 {
 	return false;
 }
+static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
+					  int nid, int shrinker_id)
+{
+}
 #endif
 
 struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
_


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6618CE64
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 14:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgCTNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 09:02:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51645 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726814AbgCTNCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584709367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2xYAH0uHG6b9vkm9HxDhrmxz4KFO1slj1dTazI1pnSg=;
        b=EsrN9x1d29qPRRPHIK2hAvEQlT4tbvkrGwwoM0nS2pvUeHlkUwPOjeB/g5BEFZ2VzXgn+7
        phSeNBqMObUtaqbICWWho6KHPP0t+B+eDU6tlA3Z7zeoT6gM35/QhpIP2/qIXdeoT4fHGz
        k0+LzguSwm6kl2lyFKZNOeQ/sWuo3gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-uhMhq033Mya-ISAj-ZXbTA-1; Fri, 20 Mar 2020 09:02:45 -0400
X-MC-Unique: uhMhq033Mya-ISAj-ZXbTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3339A8017CC;
        Fri, 20 Mar 2020 13:02:44 +0000 (UTC)
Received: from lxbceph0.gsslab.pek2.redhat.com (vm36-245.gsslab.pek2.redhat.com [10.72.36.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B64F560C18;
        Fri, 20 Mar 2020 13:02:39 +0000 (UTC)
From:   xiubli@redhat.com
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        jlayton@kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] cachefiles: fix assertion failed after bmap
Date:   Fri, 20 Mar 2020 09:02:35 -0400
Message-Id: <1584709355-7071-1-git-send-email-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

<7>[  333.227204] ceph:  page/inode not in cache
<7>[  333.571182] ceph:  page/inode not in cache
<7>[  333.741097] ceph:  page/inode not in cache
<7>[  337.977233] ceph:  all-page read submitted
<7>[  339.649714] ceph:  all-page read submitted
<3>[  339.654882] CacheFiles:
<3>[  339.654952] CacheFiles: Assertion failed
<4>[  339.655124] ------------[ cut here ]------------
<2>[  339.655126] kernel BUG at fs/cachefiles/rdwr.c:434!
<4>[  339.655225] invalid opcode: 0000 [#1] SMP KASAN PTI
<4>[  339.655309] CPU: 0 PID: 3004 Comm: python2 Tainted: G            E     5.6.0-rc6+ #77
<4>[  339.655436] Hardware name: Red Hat RHEV Hypervisor, BIOS 1.11.0-2.el7 04/01/2014
<4>[  339.655578] RIP: 0010:cachefiles_read_or_alloc_page.cold.19+0xa2/0xcd [cachefiles]
<4>[  339.656007] RSP: 0018:ffff88838110f610 EFLAGS: 00010282
<4>[  339.656095] RAX: 000000000000001c RBX: ffff88836e564600 RCX: 0000000000000001
<4>[  339.656210] RDX: 0000000000000000 RSI: 0000000000000007 RDI: ffff888389c22bd0
<4>[  339.656326] RBP: ffff88837b502e48 R08: ffffed107138457b R09: ffffed107138457b
<4>[  339.656441] R10: ffffed107138457a R11: ffff888389c22bd3 R12: ffffea000d2dffc0
<4>[  339.656563] R13: 0000000000000000 R14: ffff88835ef44700 R15: ffff88835ef44600
<4>[  339.656679] FS:  00007fbb546c3740(0000) GS:ffff888389c00000(0000) knlGS:0000000000000000
<4>[  339.656809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  339.656902] CR2: 0000561ecd9c5108 CR3: 000000036c20a000 CR4: 00000000000406f0
<4>[  339.657020] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
<4>[  339.657136] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
<4>[  339.657251] Call Trace:
<4>[  339.657322]  ? fscache_run_op.isra.10+0x80/0x150 [fscache]
<4>[  339.657421]  ? cachefiles_read_copier+0x920/0x920 [cachefiles]
<4>[  339.657529]  ? fscache_wait_for_operation_activation+0xe2/0x310 [fscache]
<4>[  339.657659]  __fscache_read_or_alloc_page+0x3d2/0x520 [fscache]
<4>[  339.657797]  ceph_readpage_from_fscache+0x80/0x110 [ceph]
<4>[  339.657915]  ceph_do_readpage+0x1f3/0x660 [ceph]
<4>[  339.657997]  ? scan_shadow_nodes+0x50/0x50
<4>[  339.658094]  ? writepages_finish+0x700/0x700 [ceph]
<4>[  339.658178]  ? add_to_page_cache_lru+0x10e/0x190
<4>[  339.658255]  ? add_to_page_cache_locked+0x10/0x10
<4>[  339.658361]  ceph_readpage+0x12/0x40 [ceph]
<4>[  339.658433]  generic_file_buffered_read+0xa4e/0x1160
<4>[  339.658517]  ? read_cache_page_gfp+0x20/0x20
<4>[  339.658599]  ? down_read+0xe0/0x190
<4>[  339.658661]  ? unaccount_page_cache_page+0x2f0/0x2f0
<4>[  339.658743]  ? generic_file_read_iter+0x3b/0x220
<4>[  339.658846]  ceph_read_iter+0x321/0x1430 [ceph]
<4>[  339.658923]  ? avc_has_perm_noaudit+0x147/0x200
<4>[  339.659027]  ? ceph_direct_read_write+0xee0/0xee0 [ceph]
<4>[  339.659115]  ? perf_event_fork+0x20/0x20
<4>[  339.659182]  ? vma_wants_writenotify+0x6f/0x240
<4>[  339.659257]  ? __ia32_sys_mmap_pgoff+0x80/0x80
<4>[  339.659334]  ? __rb_insert_augmented+0x34/0x3f0
<4>[  339.662451]  ? vm_get_page_prot+0x60/0x60
<4>[  339.665560]  ? vma_set_page_prot+0xe5/0x100
<4>[  339.668668]  ? mmap_region+0x370/0xa60
<4>[  339.671773]  ? userfaultfd_unmap_complete+0x89/0x1e0
<4>[  339.674900]  ? new_sync_read+0x286/0x3b0
<4>[  339.678011]  new_sync_read+0x286/0x3b0
<4>[  339.681102]  ? __ia32_sys_llseek+0x1d0/0x1d0
<4>[  339.684196]  ? __fsnotify_parent+0x8d/0x1f0
<4>[  339.687242]  ? fsnotify+0x5c5/0x600
<4>[  339.690224]  ? __fsnotify_inode_delete+0x20/0x20
<4>[  339.693188]  ? avc_policy_seqno+0x22/0x30
<4>[  339.696043]  ? security_file_permission+0xe1/0x180
<4>[  339.698821]  vfs_read+0xaf/0x1b0
<4>[  339.701518]  ksys_read+0xb4/0x150
<4>[  339.704177]  ? kernel_write+0xb0/0xb0
<4>[  339.706822]  do_syscall_64+0x73/0x260
<4>[  339.709427]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[  339.712055] RIP: 0033:0x7fbb534eb950

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/cachefiles/rdwr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 1dc97f2..073c14c 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -431,7 +431,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retrieval *op,
 	block <<= shift;
 
 	ret = bmap(inode, &block);
-	ASSERT(ret < 0);
+	ASSERT(!ret);
 
 	_debug("%llx -> %llx",
 	       (unsigned long long) (page->index << shift),
-- 
1.8.3.1


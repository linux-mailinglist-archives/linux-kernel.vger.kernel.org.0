Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EEE168C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 05:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBVEdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 23:33:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38052 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgBVEdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 23:33:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id z19so3916223qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 20:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPdiCspFUoLNdKrsNyt7aSs4T7N6gYtV5I8j4acuNpk=;
        b=kCtRbLdy7+38MLaQOqGvMn+7ARfqNP34p7Adh+Nw0vxvzdxkFuJqwccbrDTlSw/rIW
         a6TiZ4wDah27pbw5okdb81kVQ8H9gn3q2+7squeRbWaDfx7wqIFMrussM/adOQ1558qu
         vM/KRBsMBBX3s70MJmNT/XcO30s4LnsodDhHEE+vzXPnrx3DLSvMq0zWyXTE6OYBg+kR
         SXOXG8CMZTPSTIxw0M78unzC4qPvAhF7QREFjpU4G/rxpJe9H07eq2hd8hcP44arR5jQ
         D0J7NjGQuWpJdvcRRwkQ3qhAbrDKU4vfMhCtYX1fIZJH1SyJFDz9WAf349Fob4Ao1KEd
         2/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPdiCspFUoLNdKrsNyt7aSs4T7N6gYtV5I8j4acuNpk=;
        b=GD2Y2XXUueq2u/AJo2mylgqCkX8vKMaF0sFD70DwqMYh0nCWHxkgMNv6swkOnQSwvG
         Fg8vKasxI+VOhKzgHYkhkqBn4jiYshjq5nlJQ77wlSjdVNguINec/s20Sri62ZfT8IQ4
         a+L921OkO7xesYdFwbX8AgXtTmYktb2P/RnQse/Jx+5Nwquy0dMgZtgEYu+8QXJfbBS3
         8BAF1OHiMkrfdlSOgIN0pPO067aefomw+nB8L9ivolQ1cNbiOXjQnoiWR681WlpFs9kN
         yGe2pMqOzcDFQzWfnhKEGGeChs1sOF9J42QnaTfaaTAM6VVg3EFr6yeH6Wa2iy3gFMsV
         Cy3Q==
X-Gm-Message-State: APjAAAUB4UNwas/kXTXkN+vPrjM8PVYiFBU495tKrupSmriU+v9sg3FI
        ZGpI/8SxPZEUrbPo443fgZDgO5HsDhEOsA==
X-Google-Smtp-Source: APXvYqy262Ujqqx69YRIfaoGQM3oqw+MXZRaRJpxs5U7PdfiOQq4CReAY2bXktxNoCUNNXHXTer0nQ==
X-Received: by 2002:a05:620a:15cf:: with SMTP id o15mr37586094qkm.140.1582345982183;
        Fri, 21 Feb 2020 20:33:02 -0800 (PST)
Received: from ovpn-120-117.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j11sm2592733qkl.97.2020.02.21.20.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 20:33:01 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, elver@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] ext4: fix a data race at inode->i_blocks
Date:   Fri, 21 Feb 2020 23:32:58 -0500
Message-Id: <20200222043258.2279-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inode->i_blocks could be accessed concurrently as noticed by KCSAN,

 BUG: KCSAN: data-race in ext4_do_update_inode [ext4] / inode_add_bytes

 write to 0xffff9a00d4b982d0 of 8 bytes by task 22100 on cpu 118:
  inode_add_bytes+0x65/0xf0
  __inode_add_bytes at fs/stat.c:689
  (inlined by) inode_add_bytes at fs/stat.c:702
  ext4_mb_new_blocks+0x418/0xca0 [ext4]
  ext4_ext_map_blocks+0x1a6b/0x27b0 [ext4]
  ext4_map_blocks+0x1a9/0x950 [ext4]
  _ext4_get_block+0xfc/0x270 [ext4]
  ext4_get_block_unwritten+0x33/0x50 [ext4]
  __block_write_begin_int+0x22e/0xae0
  __block_write_begin+0x39/0x50
  ext4_write_begin+0x388/0xb50 [ext4]
  ext4_da_write_begin+0x35f/0x8f0 [ext4]
  generic_perform_write+0x15d/0x290
  ext4_buffered_write_iter+0x11f/0x210 [ext4]
  ext4_file_write_iter+0xce/0x9e0 [ext4]
  new_sync_write+0x29c/0x3b0
  __vfs_write+0x92/0xa0
  vfs_write+0x103/0x260
  ksys_write+0x9d/0x130
  __x64_sys_write+0x4c/0x60
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffff9a00d4b982d0 of 8 bytes by task 8 on cpu 65:
  ext4_do_update_inode+0x4a0/0xf60 [ext4]
  ext4_inode_blocks_set at fs/ext4/inode.c:4815
  ext4_mark_iloc_dirty+0xaf/0x160 [ext4]
  ext4_mark_inode_dirty+0x129/0x3e0 [ext4]
  ext4_convert_unwritten_extents+0x253/0x2d0 [ext4]
  ext4_convert_unwritten_io_end_vec+0xc5/0x150 [ext4]
  ext4_end_io_rsv_work+0x22c/0x350 [ext4]
  process_one_work+0x54f/0xb90
  worker_thread+0x80/0x5f0
  kthread+0x1cd/0x1f0
  ret_from_fork+0x27/0x50

 4 locks held by kworker/u256:0/8:
  #0: ffff9a025abc4328 ((wq_completion)ext4-rsv-conversion){+.+.}, at: process_one_work+0x443/0xb90
  #1: ffffab5a862dbe20 ((work_completion)(&ei->i_rsv_conversion_work)){+.+.}, at: process_one_work+0x443/0xb90
  #2: ffff9a025a9d0f58 (jbd2_handle){++++}, at: start_this_handle+0x1c1/0x9d0 [jbd2]
  #3: ffff9a00d4b985d8 (&(&ei->i_raw_lock)->rlock){+.+.}, at: ext4_do_update_inode+0xaa/0xf60 [ext4]
 irq event stamp: 3009267
 hardirqs last  enabled at (3009267): [<ffffffff980da9b7>] __find_get_block+0x107/0x790
 hardirqs last disabled at (3009266): [<ffffffff980da8f9>] __find_get_block+0x49/0x790
 softirqs last  enabled at (3009230): [<ffffffff98a0034c>] __do_softirq+0x34c/0x57c
 softirqs last disabled at (3009223): [<ffffffff97cc67a2>] irq_exit+0xa2/0xc0

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 65 PID: 8 Comm: kworker/u256:0 Tainted: G L 5.6.0-rc2-next-20200221+ #7
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
 Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work [ext4]

The plain read is outside of inode->i_lock critical section which
results in a data race. Fix it by adding READ_ONCE() there.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e60aca791d3f..98cadd111942 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4812,7 +4812,7 @@ static int ext4_inode_blocks_set(handle_t *handle,
 				struct ext4_inode_info *ei)
 {
 	struct inode *inode = &(ei->vfs_inode);
-	u64 i_blocks = inode->i_blocks;
+	u64 i_blocks = READ_ONCE(inode->i_blocks);
 	struct super_block *sb = inode->i_sb;
 
 	if (i_blocks <= ~0U) {
-- 
2.21.0 (Apple Git-122.2)


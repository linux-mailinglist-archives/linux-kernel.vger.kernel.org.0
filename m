Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7574A10A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFRMoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 08:44:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:44:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hdDSr-000408-4h; Tue, 18 Jun 2019 12:43:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: idle-page: fix oops because end_pfn is larger than max_pfn
Date:   Tue, 18 Jun 2019 13:43:52 +0100
Message-Id: <20190618124352.28307-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the calcuation of end_pfn can round up the pfn number to
more than the actual maximum number of pfns, causing an Oops. Fix
this by ensuring end_pfn is never more than max_pfn.

This can be easily triggered when on systems where the end_pfn gets
rounded up to more than max_pfn using the idle-page stress-ng
stress test:

sudo stress-ng --idle-page 0

[ 3812.222790] BUG: unable to handle kernel paging request at 00000000000020d8
[ 3812.224341] #PF error: [normal kernel read fault]
[ 3812.225144] PGD 0 P4D 0
[ 3812.225626] Oops: 0000 [#1] SMP PTI
[ 3812.226264] CPU: 1 PID: 11039 Comm: stress-ng-idle- Not tainted 5.0.0-5-generic #6-Ubuntu
[ 3812.227643] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[ 3812.229286] RIP: 0010:page_idle_get_page+0xc8/0x1a0
[ 3812.230173] Code: 0f b1 0a 75 7d 48 8b 03 48 89 c2 48 c1 e8 33 83 e0 07 48 c1 ea 36 48 8d 0c 40 4c 8d 24 88 49 c1 e4 07 4c 03 24 d5 00 89 c3 be <49> 8b 44 24 58 48 8d b8 80 a1 02 00 e8 07 d5 77 00 48 8b 53 08 48
[ 3812.234641] RSP: 0018:ffffafd7c672fde8 EFLAGS: 00010202
[ 3812.235792] RAX: 0000000000000005 RBX: ffffe36341fff700 RCX: 000000000000000f
[ 3812.237739] RDX: 0000000000000284 RSI: 0000000000000275 RDI: 0000000001fff700
[ 3812.239225] RBP: ffffafd7c672fe00 R08: ffffa0bc34056410 R09: 0000000000000276
[ 3812.241027] R10: ffffa0bc754e9b40 R11: ffffa0bc330f6400 R12: 0000000000002080
[ 3812.242555] R13: ffffe36341fff700 R14: 0000000000080000 R15: ffffa0bc330f6400
[ 3812.244073] FS: 00007f0ec1ea5740(0000) GS:ffffa0bc7db00000(0000) knlGS:0000000000000000
[ 3812.245968] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3812.247162] CR2: 00000000000020d8 CR3: 0000000077d68000 CR4: 00000000000006e0
[ 3812.249045] Call Trace:
[ 3812.249625] page_idle_bitmap_write+0x8c/0x140
[ 3812.250567] sysfs_kf_bin_write+0x5c/0x70
[ 3812.251406] kernfs_fop_write+0x12e/0x1b0
[ 3812.252282] __vfs_write+0x1b/0x40
[ 3812.253002] vfs_write+0xab/0x1b0
[ 3812.253941] ksys_write+0x55/0xc0
[ 3812.254660] __x64_sys_write+0x1a/0x20
[ 3812.255446] do_syscall_64+0x5a/0x110
[ 3812.256254] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 33c3fc71c8cf ("mm: introduce idle page tracking")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/page_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 0b39ec0c945c..295512465065 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -136,7 +136,7 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 
 	end_pfn = pfn + count * BITS_PER_BYTE;
 	if (end_pfn > max_pfn)
-		end_pfn = ALIGN(max_pfn, BITMAP_CHUNK_BITS);
+		end_pfn = max_pfn;
 
 	for (; pfn < end_pfn; pfn++) {
 		bit = pfn % BITMAP_CHUNK_BITS;
@@ -181,7 +181,7 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 
 	end_pfn = pfn + count * BITS_PER_BYTE;
 	if (end_pfn > max_pfn)
-		end_pfn = ALIGN(max_pfn, BITMAP_CHUNK_BITS);
+		end_pfn = max_pfn;
 
 	for (; pfn < end_pfn; pfn++) {
 		bit = pfn % BITMAP_CHUNK_BITS;
-- 
2.20.1


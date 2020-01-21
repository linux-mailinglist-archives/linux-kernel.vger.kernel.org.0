Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B310143B42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 11:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgAUKmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 05:42:45 -0500
Received: from relay.sw.ru ([185.231.240.75]:57234 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgAUKmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:42:42 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itqzE-0006Oz-FT; Tue, 21 Jan 2020 13:42:20 +0300
Subject: [PATCH v4 0/7] block: Introduce REQ_ALLOCATE flag for
 REQ_OP_WRITE_ZEROES
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com, ktkhai@virtuozzo.com
Date:   Tue, 21 Jan 2020 13:42:20 +0300
Message-ID: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(was "[PATCH block v2 0/3] block: Introduce REQ_NOZERO flag
      for REQ_OP_WRITE_ZEROES operation";
 was "[PATCH RFC 0/3] block,ext4: Introduce REQ_OP_ASSIGN_RANGE
      to reflect extents allocation in block device internals")

v4: Correct argument for mddev_check_write_zeroes().

v3: Rename REQ_NOZERO to REQ_ALLOCATE.
    Split helpers to separate patches.
    Add a patch, disabling max_allocate_sectors inheritance for dm.

v2: Introduce new flag for REQ_OP_WRITE_ZEROES instead of
    introduction a new operation as suggested by Martin K. Petersen.
    Removed ext4-related patch to focus on block changes
    for now.

Information about continuous extent placement may be useful
for some block devices. Say, distributed network filesystems,
which provide block device interface, may use this information
for better blocks placement over the nodes in their cluster,
and for better performance. Block devices, which map a file
on another filesystem (loop), may request the same length extent
on underlining filesystem for less fragmentation and for batching
allocation requests. Also, hypervisors like QEMU may use this
information for optimization of cluster allocations.

This patchset introduces REQ_ALLOCATE flag for REQ_OP_WRITE_ZEROES,
which makes a block device to allocate blocks instead of actual
blocks zeroing. This may be used for forwarding user's fallocate(0)
requests into block device internals. E.g., in loop driver this
will result in allocation extents in backing-file, so subsequent
write won't fail by the reason of no available space. Distributed
network filesystems will be able to assign specific servers for
specific extents, so subsequent write will be more efficient.

Patches [1-3/7] are preparation on helper functions, patch [4/7]
introduces REQ_ALLOCATE flag and implements all the logic,
patch [5/7] adds one more helper, patch [6/7] disables REQ_ALLOCATE
for dm, which inherits limits from underlining block devices,
patch [7/7] adds loop as the first user of the flag.

Note, that here is only block-related patches, example of usage
for ext4 with a performance numbers may be seen in [1].

[1] https://lore.kernel.org/linux-ext4/157599697369.12112.10138136904533871162.stgit@localhost.localdomain/T/#me5bdd5cc313e14de615d81bea214f355ae975db0

---

Kirill Tkhai (7):
      block: Add @flags argument to bdev_write_zeroes_sectors()
      block: Pass op_flags into blk_queue_get_max_sectors()
      block: Introduce blk_queue_get_max_write_zeroes_sectors()
      block: Add support for REQ_ALLOCATE flag
      block: Add blk_queue_max_allocate_sectors()
      dm: Directly disable max_allocate_sectors for now
      loop: Add support for REQ_ALLOCATE


 block/blk-core.c                    |    6 +++---
 block/blk-lib.c                     |   17 ++++++++++-------
 block/blk-merge.c                   |    9 ++++++---
 block/blk-settings.c                |   17 +++++++++++++++++
 drivers/block/loop.c                |   15 ++++++++++++---
 drivers/md/dm-kcopyd.c              |    2 +-
 drivers/md/dm-table.c               |    2 ++
 drivers/md/md.h                     |    1 +
 drivers/target/target_core_iblock.c |    4 ++--
 fs/block_dev.c                      |    4 ++++
 include/linux/blk_types.h           |    5 ++++-
 include/linux/blkdev.h              |   34 ++++++++++++++++++++++++++--------
 12 files changed, 88 insertions(+), 28 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>


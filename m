Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C6C14E2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 19:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgA3Sxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 13:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730632AbgA3Sxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:53:37 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A8220702;
        Thu, 30 Jan 2020 18:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410416;
        bh=gkUZbH3+rXoDnKrPU3LUSjOmxfEKY55z4s/Syd5EzCk=;
        h=Date:From:To:Cc:Subject:From;
        b=WfC4r47vT1+7aO/866TXK/W8wZf+cBh1dbByr+22PkvKt327PJ6JvEuvSgILTjVq3
         Ms6NDRGJK0nAk0d1kQoeOeIz6xio7S+fwAlFTBfwBA3nyX+8Jfqy6pUf/0vOEitBb5
         mApmLVB4Wny4Pkid6ZSk/VmRtZEt12uGooCY2w9k=
Date:   Thu, 30 Jan 2020 10:53:36 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs for 5.6
Message-ID: <20200130185335.GA225399@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 6794862a16ef41f753abd75c03a152836e4c8028:

  Merge tag 'for-5.5-rc1-kconfig-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2019-12-09 12:14:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.6

for you to fetch changes up to 80f2388afa6ef985f9c5c228e36705c4d4db4756:

  f2fs: fix race conditions in ->d_compare() and ->d_hash() (2020-01-24 10:04:09 -0800)

----------------------------------------------------------------
f2fs-for-5.6

In this series, we've implemented transparent compression experimentally. It
supports LZO and LZ4, but will add more later as we investigate in the field
more. At this point, the feature doesn't expose compressed space to user
directly in order to guarantee potential data updates later to the space.
Instead, the main goal is to reduce data writes to flash disk as much as
possible, resulting in extending disk life time as well as relaxing IO
congestion. Alternatively, we're also considering to add ioctl() to reclaim
compressed space and show it to user after putting the immutable bit.

Enhancement:
 - add compression support
 - avoid unnecessary locks in quota ops
 - harden power-cut scenario for zoned block devices
 - use private bio_set to avoid IO congestion
 - replace GC mutex with rwsem to serialize callers

Bug fix:
 - fix dentry consistency and memory corruption in rename()'s error case
 - fix wrong swap extent reports
 - fix casefolding bugs
 - change lock coverage to avoid deadlock
 - avoid GFP_KERNEL under f2fs_lock_op

And, we've cleaned up sysfs entries to prepare no debugfs.

----------------------------------------------------------------
Chao Yu (5):
      f2fs: introduce private bioset
      f2fs: support data compression
      f2fs: fix to add swap extent correctly
      f2fs: fix memleak of kobject
      f2fs: change to use rwsem for gc_mutex

Chengguang Xu (2):
      f2fs: fix miscounted block limit in f2fs_statfs_project()
      f2fs: code cleanup for f2fs_statfs_project()

Eric Biggers (5):
      f2fs: don't keep META_MAPPING pages used for moving verity file blocks
      f2fs: remove unneeded check for error allocating bio_post_read_ctx
      f2fs: fix deadlock allocating bio_post_read_ctx from mempool
      f2fs: fix dcache lookup of !casefolded directories
      f2fs: fix race conditions in ->d_compare() and ->d_hash()

Hridya Valsaraju (2):
      f2fs: delete duplicate information on sysfs nodes
      f2fs: Add f2fs stats to sysfs

Jaegeuk Kim (13):
      f2fs: preallocate DIO blocks when forcing buffered_io
      f2fs: call f2fs_balance_fs outside of locked page
      f2fs: keep quota data on write_begin failure
      f2fs: should avoid recursive filesystem ops
      f2fs: set GFP_NOFS when moving inline dentries
      f2fs: set I_LINKABLE early to avoid wrong access by vfs
      f2fs: don't put new_page twice in f2fs_rename
      f2fs: declare nested quota_sem and remove unnecessary sems
      f2fs: free sysfs kobject
      f2fs: run fsck when getting bad inode during GC
      f2fs: convert inline_dir early before starting rename
      f2fs: add a way to turn off ipu bio cache
      f2fs: update f2fs document regarding to fsync_mode

Sahitya Tummala (2):
      f2fs: cleanup duplicate stats for atomic files
      f2fs: show the CP_PAUSE reason in checkpoint traces

Shin'ichiro Kawasaki (2):
      f2fs: Check write pointer consistency of open zones
      f2fs: Check write pointer consistency of non-open zones

 Documentation/ABI/testing/sysfs-fs-f2fs |  280 +++++---
 Documentation/filesystems/f2fs.txt      |  216 ++----
 fs/f2fs/Kconfig                         |   27 +-
 fs/f2fs/Makefile                        |    1 +
 fs/f2fs/checkpoint.c                    |    6 +-
 fs/f2fs/compress.c                      | 1176 +++++++++++++++++++++++++++++++
 fs/f2fs/data.c                          |  736 ++++++++++++++++---
 fs/f2fs/debug.c                         |   88 ++-
 fs/f2fs/dir.c                           |   25 +-
 fs/f2fs/f2fs.h                          |  329 ++++++++-
 fs/f2fs/file.c                          |  251 +++++--
 fs/f2fs/gc.c                            |   18 +-
 fs/f2fs/inline.c                        |   44 +-
 fs/f2fs/inode.c                         |   41 ++
 fs/f2fs/namei.c                         |  120 +++-
 fs/f2fs/recovery.c                      |   20 +-
 fs/f2fs/segment.c                       |  271 ++++++-
 fs/f2fs/segment.h                       |   19 +-
 fs/f2fs/super.c                         |  182 ++++-
 fs/f2fs/sysfs.c                         |  158 ++++-
 include/linux/f2fs_fs.h                 |    5 +
 include/trace/events/f2fs.h             |  103 ++-
 22 files changed, 3467 insertions(+), 649 deletions(-)
 create mode 100644 fs/f2fs/compress.c

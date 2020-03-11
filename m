Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17347181DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgCKQ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbgCKQ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:27:36 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E70206BE;
        Wed, 11 Mar 2020 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583944056;
        bh=6Vo3+x0qJalhkBRtWzcGky+bHsuwVfFeSdbQXvVkhUQ=;
        h=Date:From:To:Cc:Subject:From;
        b=yMJ5i1TnwI1bH7wYGWAQujoySrxYNb6JJqlT3ces9qWP3xXNA8Jr4wWMtImW9UVOG
         wxmOxSc07MpcO69zm6fENyc/zI44TvJn37V0sfYPdsBYV4bMyN8yBI2eTp3AYgaW7/
         cW4GPNXM3wHuqLIfupBz6q+FYpyRB5J3jUvj5X1I=
Date:   Wed, 11 Mar 2020 09:27:35 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs for 5.6-rc6
Message-ID: <20200311162735.GA152176@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry for late pull request. Could you please consider this?

Thanks,

The following changes since commit b19e8c68470385dd2c5440876591fddb02c8c402:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2020-02-13 14:36:57 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.6-rc6

for you to fetch changes up to 2536ac6872e5265b4d9d263122cee02e3d5cae1d:

  f2fs: allow to clear F2FS_COMPR_FL flag (2020-03-11 08:25:38 -0700)

----------------------------------------------------------------
f2fs-for-5.6-rc6

Some major bug fixes wrt compression:
- compressed block count
- memory access and leak
- remove obsolete fields
- flag controls

And some others:
- replace rwsem with spinlock
- potential deadlock

----------------------------------------------------------------
Chao Yu (14):
      f2fs: fix to wait all node page writeback
      f2fs: fix to avoid NULL pointer dereference
      f2fs: recycle unused compress_data.chksum feild
      f2fs: add missing function name in kernel message
      f2fs: fix to avoid potential deadlock
      f2fs: fix to check i_compr_blocks correctly
      f2fs: cover last_disk_size update with spinlock
      f2fs: remove i_sem lock coverage in f2fs_setxattr()
      f2fs: fix inconsistent comments
      f2fs: fix to avoid using uninitialized variable
      f2fs: fix to avoid use-after-free in f2fs_write_multi_pages()
      f2fs: fix to account compressed inode correctly
      f2fs: fix to check dirty pages during compressed inode conversion
      f2fs: allow to clear F2FS_COMPR_FL flag

Eric Biggers (1):
      f2fs: fix leaking uninitialized memory in compressed clusters

Jaegeuk Kim (1):
      f2fs: fix wrong check on F2FS_IOC_FSSETXATTR

Sahitya Tummala (1):
      f2fs: fix the panic in do_checkpoint()

 fs/f2fs/checkpoint.c | 34 +++++++++++-----------------------
 fs/f2fs/compress.c   | 24 ++++++++++++++----------
 fs/f2fs/data.c       | 23 ++++++++---------------
 fs/f2fs/f2fs.h       | 18 ++++++++++--------
 fs/f2fs/file.c       | 40 +++++++++++++++++++++++++---------------
 fs/f2fs/gc.c         |  5 ++++-
 fs/f2fs/inode.c      | 25 +++++++++++++++++++++----
 fs/f2fs/namei.c      |  2 +-
 fs/f2fs/node.c       | 18 ++++++++----------
 fs/f2fs/shrinker.c   |  2 +-
 fs/f2fs/super.c      |  7 ++++---
 fs/f2fs/xattr.c      |  3 ---
 12 files changed, 107 insertions(+), 94 deletions(-)

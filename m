Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13A717318B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 08:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgB1HIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 02:08:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgB1HIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:08:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so1769586wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Y3bqnLpG6SCjOwt4nBEcww4YzAPzL9sw6D5C7BP4ss=;
        b=kNuQWssR1j1UXJivHjADXdQbCi8KzkCDdcAGoFjr1Uw+1MhzsyD16SW420zCLbmsno
         tpdi00UqDp6NzXw0u0aRt5DcUYBrUI9/uxDChuz8wrrUK3dbfkM7RvYv7v+NSBSh7o8y
         Ss8/OZZddwlPFZhyOQKwrfliuld4tiTCISnUxODZGt4FNqF9k/CZKfEpn1FDyUKRQcrl
         H0yy/F5VaFz3Yo+W7n8fXArZh+PiYXslU0AprptuMnlO2G7QFgDjs/KOjjMQVWUpNf7q
         lSZC9QWP0eeU9JKFSIkEOYefvNSXxEYl45Pl1Z84H/LTZA/AG5MtbT6zkQWOFbr2rAOo
         gPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Y3bqnLpG6SCjOwt4nBEcww4YzAPzL9sw6D5C7BP4ss=;
        b=fJ81kqXgebXqmga325DufM26DeufzeNQZXm3Xw+RipN5IlyEwYVmmDID93HVuJcuSH
         C1mNu7FuMqx1Qo7fzeus3dFgh0I6W3oN1aOF921EHnVTCKnSGQgeaUhVAROMPGWKfyTI
         oAn3SL8YQ0HD9xz+lTHeL7dY3kBv6XMaiWXgqCaZ02Oj4cY0qqTtf1+1Uu8qja+n9zX/
         nCpTvJHcB6ct4ynf0btGJcS/St1wCqrQcOWBDVGC/UCfeqAS35Deb7rewleLL6t0l5fv
         zRJ161mjiwjO6MHeT7ZgeKAWk9UsDQkAZ/uwozg9ZJtHqizz6U5oZBM0Wu+2t083Ducs
         AGaw==
X-Gm-Message-State: APjAAAXRMdgo5AzaKRqnyWLm7YiZeMN7pdGFUd7+G2aBaCMcmFQnfmRp
        8Y3efAszMSEozX9pnXicqtiaoWkIirXM3thqzg9ILg==
X-Google-Smtp-Source: APXvYqwy838vGaHfU+raXOq8AVBEGhanWZziMBY3GYimgfDYKo0mTCncF7OS9/vpBdLq51cpEzoHDrwYM5ju/oQVf/E=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr3413854wrw.252.1582873698006;
 Thu, 27 Feb 2020 23:08:18 -0800 (PST)
MIME-Version: 1.0
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
In-Reply-To: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Fri, 28 Feb 2020 15:07:45 +0800
Message-ID: <CAAJeciXSq9yThwuFJ0WFO8-qiYzTD4GqVpVKHS0q5DHJ0f8X-Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, viro@zeniv.linux.org.uk,
        adilger.kernel@dilger.ca, snitzer@redhat.com, jack@suse.cz,
        ebiggers@google.com, riteshh@linux.ibm.com, krisman@collabora.com,
        surajjs@amazon.com, dmonakhov@gmail.com, mbobrowski@mbobrowski.org,
        enwlinux@gmail.com, sblbir@amazon.com, khazhy@google.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kirill Tkhai:

I agree with your idea very much.
I had also implemented a similar fallocate interface with the unique
flag which call tell ext4 filesystems to allocate the special free
physical extents.
I had done the same work as your fallocate2 work last year.

but i think it has modified the core ext4 physical blocks allocator a
lot, so the ext4 community may not accept it.
so I didn't share it openly.

but i think this fallocate2 interface just same as my work is also
very useful in android mobile phone world.

today android phone has large capacity memory and storage, just the
same as a computer.
and current days, customer treat phone and make full use of it by just
the same way as they treat computer in past days.
so after install many software and unstall them for many times in
android phone,  the ext4 physical layout on disk has become more
fragmented
(the number of extents per group is large).
at this moment, when run a sequential write workload, you will find
the sequential write performance is very bad.

but after do defragment work on some fragmented ext4 groups, and then
run the same workload again, the sequential write performance has
improved greatly.
and the fallocate2 interface is a necessary component of this
defragment work shown above.

so i also think this fallocate2 interface is an important and useful
tools for ext4 filesystems.









On Wed, Feb 26, 2020 at 9:41 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> When discard granuality of a block device is bigger than filesystem block size,
> fstrim does not effectively release device blocks. During the filesystem life,
> some files become deleted, some remain alive, and this results in that many
> device blocks are used incomletely (of course, the reason is not only in this,
> but since this is not a problem of a filesystem, this is not a subject
> of the patchset). This results in space lose for thin provisioning devices.
>
> Say, a filesystem on a block device, which is provided by another filesystem
> (say, distributed network filesystem). Semi-used blocks of the block device
> result in bad performance and worse space usage of underlining filesystem.
> Another example is ext4 with 4k block on loop on ext4 with 1m block. This
> case also results in bad disk space usage.
>
> Choosing a bigger block size is not a solution here, since small files become
> taking much more disk space, than they used before, and the result excess
> disk usage is the same.
>
> The proposed solution is defragmentation of files based on block device
> discard granuality knowledge. Files, which were not modified for a long time,
> and read-only files, small files, etc, may be placed in the same block device
> block together. I.e., compaction of some device blocks, which results
> in releasing another device blocks.
>
> The problem is current fallocate() does not allow to implement effective
> way for such the defragmentation. The below describes the situation for ext4,
> but this should touch all filesystems.
>
> fallocate() goes thru standard blocks allocator, which try to behave very
> good for life allocation cases: block placement and future file size
> prediction, delayed blocks allocation, etc. But it almost impossible
> to allocate blocks from specified place for our specific case. The only
> ext4 block allocator option possible to use is that the allocator firstly
> tries to allocate blocks from the same block group, that inode is related to.
> But this is not enough for effective files compaction.
>
> This patchset implements an extension of fallocate():
>
>         fallocate2(int fd, int mode, loff_t offset, loff_t len,
>                    unsigned long long physical)
>
> The new argument is @physical offset from start of device, which is must
> for block allocation. In case of [@physical, @physical + len] block range
> is available for allocation, the syscall assigns the corresponding extent/
> extents to inode. In case of the range or its part is occupied, the syscall
> returns with error (maybe, smaller range will be allocated. The behavior
> is the same as when fallocate() meets no space in the middle).
>
> This interface allows to solve the formulated problem. Also, note, this
> interface may allow to improve existing e4defrag algorithm: decrease
> number of file extents more effective.
>
> [1-2/5] are refactoring.
> [3/5] adds fallocate2() body.
> [4/5] prepares ext4_mb_discard_preallocations() for handling EXT4_MB_HINT_GOAL_ONLY
> [5/5] adds fallocate2() support for ext4
>
> Any comments are welcomed!
>
> ---
>
> Kirill Tkhai (5):
>       fs: Add new argument to file_operations::fallocate()
>       fs: Add new argument to vfs_fallocate()
>       fs: Add fallocate2() syscall
>       ext4: Prepare ext4_mb_discard_preallocations() for handling EXT4_MB_HINT_GOAL_ONLY
>       ext4: Add fallocate2() support
>
>
>  arch/x86/entry/syscalls/syscall_32.tbl |    1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |    1 +
>  arch/x86/ia32/sys_ia32.c               |   10 +++++++
>  drivers/block/loop.c                   |    2 +
>  drivers/nvme/target/io-cmd-file.c      |    4 +--
>  drivers/staging/android/ashmem.c       |    2 +
>  drivers/target/target_core_file.c      |    2 +
>  fs/block_dev.c                         |    4 +--
>  fs/btrfs/file.c                        |    4 ++-
>  fs/ceph/file.c                         |    5 +++-
>  fs/cifs/cifsfs.c                       |    7 +++--
>  fs/cifs/smb2ops.c                      |    5 +++-
>  fs/ext4/ext4.h                         |    5 +++-
>  fs/ext4/extents.c                      |   35 ++++++++++++++++++++-----
>  fs/ext4/inode.c                        |   14 ++++++++++
>  fs/ext4/mballoc.c                      |   45 +++++++++++++++++++++++++-------
>  fs/f2fs/file.c                         |    4 ++-
>  fs/fat/file.c                          |    7 ++++-
>  fs/fuse/file.c                         |    5 +++-
>  fs/gfs2/file.c                         |    5 +++-
>  fs/hugetlbfs/inode.c                   |    5 +++-
>  fs/io_uring.c                          |    2 +
>  fs/ioctl.c                             |    5 ++--
>  fs/nfs/nfs4file.c                      |    6 ++++
>  fs/nfsd/vfs.c                          |    2 +
>  fs/ocfs2/file.c                        |    4 ++-
>  fs/open.c                              |   21 +++++++++++----
>  fs/overlayfs/file.c                    |    8 ++++--
>  fs/xfs/xfs_file.c                      |    5 +++-
>  include/linux/fs.h                     |    4 +--
>  include/linux/syscalls.h               |    8 +++++-
>  ipc/shm.c                              |    6 ++--
>  mm/madvise.c                           |    2 +
>  mm/shmem.c                             |    4 ++-
>  34 files changed, 190 insertions(+), 59 deletions(-)
>
> --
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>

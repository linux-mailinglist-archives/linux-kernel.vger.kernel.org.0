Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A370017FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 20:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfEHScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 14:32:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35484 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfEHScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:32:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id t87so10352297pfa.2;
        Wed, 08 May 2019 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Q/xfg+nFGLhPsGBWl9LacPjF3U7jjM06H75mJzsV2Q0=;
        b=O+8Jx8jcGtkDWgQF5nFQioz658bj+cLJrSm07lLlrnbp3uJE1Gtsu3a+FAEUTPQutZ
         YN2+2H/uS1o+z6k13VMwXoQjq+to1/uWKLHAlZPf9PMxOsUZ45JsOOLY2rsBScBo3hF8
         8rCAmDgc5Ajnm/t949yqMSAEhwXDdi+ls+FWEaM9y1XD434UspTi/XANIWIpiUNjA5Uq
         bhe8g7tGmbDEH2UFF7Oo5W7uPZkmiLXGVy3psqK07G+Qk7Nuqb0dYnkVE/4KQ+e5UKz8
         99Mygt6uyy27PX9tNDNZtHU5LHY6OEHWENnzQVCnpTS7jOmnzOXDwHVE1gQCFH+mPN52
         o/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Q/xfg+nFGLhPsGBWl9LacPjF3U7jjM06H75mJzsV2Q0=;
        b=RI6ITcX53crEr3ZJ5n4PxU9xOjSOAA0Y0LvCLvYJJKDczPLW3gEYuA4OLgXVUANXZg
         NdQhNykYNlXmpg+3pUYUfX/H9B/QrQsXHp7+mquZwv7vaHSR/WfdwEKrizCnyJoFfTcl
         YYsMiY2AztAAkq8i4CiTs0KMbd03d7Qv0t2FRc5rbZS4cLPIdPOicDuJm5p/WamH3fMq
         fhwYxEDe5ewgpAgb3fomGB8OZVZRTDwGSTDUHIbUvjI1eVNT+yNAwidee26N8lzWwMox
         kCxbp8GRLtgrHIq0eah4E+yPlD1RQp8OtUosc7mdC9yVDRbhUWE9fmWiYN1gcGX8a5SW
         IM3w==
X-Gm-Message-State: APjAAAXlJKuEjS+Jt9ctruZEaHWGH9SMiCMnbCiUt40+C00g0TtLy4nD
        RZrRFHhZ4Y7es3tXgYL7D5YRfQ+djlbh/ki9ettpHPfZ
X-Google-Smtp-Source: APXvYqwADUUxUTdF7fGUVlq+RIXr2nmGzMCbzcpUeBSut5zQOkNNZVPNkSFqhOfNHe3dERpdFVLtRIkyZLYB+5SO/ts=
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr49717413pfv.10.1557340366290;
 Wed, 08 May 2019 11:32:46 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 8 May 2019 13:32:35 -0500
Message-ID: <CAH2r5mv=4JsaF-8v=U4JR3jrOyPfhtUsJPogNudLejDh09xGSA@mail.gmail.com>
Subject: [GIT PULL] CIFS/SMB3 fixes
To:     CIFS <linux-cifs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
d3511f53bb2475f2a4e8460bee5a1ae6dea2a433:

  Merge branch 'parisc-5.2-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
(2019-05-07 19:34:17 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.2-smb3

for you to fetch changes up to cb4f7bf6be10b35510e6b2e60f80d85ebc22a578:

  cifs: update module internal version number (2019-05-07 23:24:56 -0500)

----------------------------------------------------------------
CIFS/SMB3 changes, three for stable, adds fiemap support, improves
zero-range support, and includes various RDMA (smb direct fixes).  Our
build verification tests passed (and continue to be extended to
include more tests).  See e.g. our 'buildbot' results at:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/199

Have an additional set of fixes (for improved handling of sparse
files, mode bits, POSIX extensions) that are still being tested that
are not included in this pull request but I expect to send in the next
week.
----------------------------------------------------------------
Aurelien Aptel (1):
      CIFS: check CIFS_MOUNT_NO_DFS when trying to reuse existing sb

Christoph Probst (1):
      cifs: fix strcat buffer overflow and reduce raciness in
smb21_set_oplock_level()

Jeff Layton (1):
      cifs: remove superfluous inode_lock in cifs_{strict_}fsync

Kenneth D'souza (1):
      CIFS: Show locallease in /proc/mounts for cifs shares mounted
with locallease feature.

Long Li (7):
      smbd: Make upper layer decide when to destroy the transport
      cifs: smbd: Don't destroy transport on RDMA disconnect
      cifs: smbd: Return EINTR when interrupted
      cifs: smbd: Indicate to retry on transport sending failure
      cifs: smbd: Retry on memory registration failure
      cifs: Call MID callback before destroying transport
      cifs: smbd: take an array of reqeusts when sending upper layer data

Paulo Alcantara (SUSE) (1):
      cifs: Fix DFS cache refresher for DFS links

Ronnie Sahlberg (8):
      cifs: Add support for FSCTL passthrough that write data to the server
      cifs: fix bi-directional fsctl passthrough calls
      cifs: add fiemap support
      cifs: zero-range does not require the file is sparse
      cifs: fix smb3_zero_range for Azure
      cifs: fix credits leak for SMB1 oplock breaks
      cifs: rename and clarify CIFS_ASYNC_OP and CIFS_NO_RESP
      SMB3: Clean up query symlink when reparse point

Sergey Senozhatsky (1):
      cifs: don't use __constant_cpu_to_le32()

Steve French (8):
      SMB3: Track total time spent on roundtrips for each SMB3 command
      SMB3: update comment to clarify enumerating snapshots
      SMB3: Add handling for different FSCTL access flags
      SMB3: Add defines for new negotiate contexts
      Add new flag on SMB3.1.1 read
      smb3: Add protocol structs for change notify support
      Negotiate and save preferred compression algorithms
      cifs: update module internal version number

 fs/cifs/cifs_debug.c |   33 +-
 fs/cifs/cifsfs.c     |    3 +
 fs/cifs/cifsfs.h     |    4 +-
 fs/cifs/cifsglob.h   |   27 +-
 fs/cifs/cifsproto.h  |    9 +
 fs/cifs/cifssmb.c    |   98 +--
 fs/cifs/connect.c    |   63 +-
 fs/cifs/dfs_cache.c  |  140 ++++-
 fs/cifs/dfs_cache.h  |    5 +-
 fs/cifs/file.c       |    5 -
 fs/cifs/inode.c      |   37 ++
 fs/cifs/link.c       |   13 +-
 fs/cifs/smb1ops.c    |    9 +-
 fs/cifs/smb2ops.c    |  309 ++++++---
 fs/cifs/smb2pdu.c    |   72 ++-
 fs/cifs/smb2pdu.h    |   71 +++
 fs/cifs/smb2status.h | 3480
++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
 fs/cifs/smbdirect.c  |  292 ++++-----
 fs/cifs/smbdirect.h  |   19 +-
 fs/cifs/smbfsctl.h   |   29 +-
 fs/cifs/transport.c  |   48 +-
 21 files changed, 2582 insertions(+), 2184 deletions(-)


-- 
Thanks,

Steve

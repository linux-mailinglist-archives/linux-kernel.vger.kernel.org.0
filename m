Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684F0E88A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 13:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387974AbfJ2Mr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 08:47:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36240 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfJ2Mr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:47:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so13526732wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6VqIj3BTfFgV4L15YGzzwv6yyFmVnbm7JQmLRtMKsic=;
        b=CfxPPaDekZp7Q3u2GYPK2Du+jE1BNYcTQSKcDF5cLZnsRZZwbwlKGn0v6Lag4uMheH
         pr6at2+zXWlfkIVglgv3gVRED3ewZjIBNRcJdFSK/UMybQo2xr7hrahVXBrn3ff9P6wZ
         bFNSTFOjxn/qUDPxzBiLa0a/JuFbX9XODa7q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6VqIj3BTfFgV4L15YGzzwv6yyFmVnbm7JQmLRtMKsic=;
        b=cCOIlldsMxsR1PrnwzzezfrZX8Wr8vDfeBaOIsgj+jYVkVYdyvvcjqPaelwIIlDnzB
         09C6ZJq7jMSOghp6x5SrUyYl3KBgZhzWGXbA52uj8XfKakg/d9dAQs1PxnfnvKpQLefW
         wQFOUMH/j0laYd0N4XzL8pX9f3pPA+UeQ8aOeZTRdzOfM5owqPYLoeUHxntTeW01+c7k
         zKopjfeFVeH5BwTPGabwmGMSu1WK+Ji+F1VwLBMhRieN01K/qVkz9HYl2vv5r6MSMfP2
         zHwZCCsQsU1TsDP1tQXoYJdFBHnSuFRcKFGK0WazhOUuVjz0n+suFbeKNEjJs+YE1Whh
         XksQ==
X-Gm-Message-State: APjAAAUcP/rw1fHsABqjpJCG1rWjvbQhMqe6Wl3tLUn62MsAobsVI2VA
        4zxZjwU/JAAll0CkTWAU4Wljlw==
X-Google-Smtp-Source: APXvYqxP32WsuIeX0uHdKVMlzu2T3N+gMRJC+9wtmoLuOudI6BOZebwGZYeFObYe4CxYzxOkt41AhA==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr18809312wrq.208.1572353244608;
        Tue, 29 Oct 2019 05:47:24 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id l4sm1953002wml.33.2019.10.29.05.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 05:47:23 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:47:17 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.4-rc6
Message-ID: <20191029124717.GA7805@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.4-rc6

Mostly virtiofs fixes, but also fixes a regression and couple of
longstanding data/metadata writeback ordering issues.

Thanks,
Miklos

----------------------------------------------------------------
Alan Somers (1):
      fuse: Add changelog entries for protocols 7.1 - 7.8

Miklos Szeredi (5):
      virtio-fs: don't show mount options
      fuse: don't dereference req->args on finished request
      fuse: don't advise readdirplus for negative lookup
      fuse: flush dirty data/metadata before non-truncate setattr
      fuse: truncate pending writes on O_TRUNC

Vasily Averin (1):
      fuse: redundant get_fuse_inode() calls in fuse_writepages_fill()

Vivek Goyal (6):
      virtio-fs: Change module name to virtiofs.ko
      virtiofs: Do not end request in submission context
      virtiofs: No need to check fpq->connected state
      virtiofs: Set FR_SENT flag only after request has been sent
      virtiofs: Count pending forgets as in_flight forgets
      virtiofs: Retry request submission from worker context

zhengbin (1):
      virtiofs: Remove set but not used variable 'fc'

---
 fs/fuse/Makefile          |   3 +-
 fs/fuse/dev.c             |   4 +-
 fs/fuse/dir.c             |  16 ++++-
 fs/fuse/file.c            |  14 ++--
 fs/fuse/fuse_i.h          |   4 ++
 fs/fuse/inode.c           |   4 ++
 fs/fuse/virtio_fs.c       | 169 +++++++++++++++++++++++++++++++---------------
 include/uapi/linux/fuse.h |  37 ++++++++++
 8 files changed, 186 insertions(+), 65 deletions(-)

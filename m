Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E996722C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 01:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfGWXGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 19:06:53 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52572 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfGWXGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:06:53 -0400
Received: by mail-pf1-f202.google.com with SMTP id a20so27179694pfn.19
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ypAciFLqcuJHhZlJfd3b9E/UNSP51lkN8ppY3+9yiV0=;
        b=WQ3iNnYoSyu7xtrItLgp020OuxDdO2/iRV2uuk27rT/z0T/Ivgp2t0qpnjUQnutvGO
         Kht4XkxfyI82pAf7iBAmzpAh3bma+GsOP/lWEILbL8XGZCUWOfR+zOJEZO+LCwqW1+0J
         re12tXsPG1ZGIxtefWTTHZ0rmoSeptTv50oNwbBi/yxdBR8eGzy6vE71M02BrWaMSa2m
         Wz74TCUFRRT36yUx5zDCm4LFO0AviBkQ0V64+68mNDKlBkz8NiEXI6tSXKyDDGRXxRym
         +gBXn/6aa1ixajprqf1Gcl0vH57WykEURFDVSYksJJH5tW7lbed6XcGlVblOav8mCxix
         p45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ypAciFLqcuJHhZlJfd3b9E/UNSP51lkN8ppY3+9yiV0=;
        b=UBPD4uCzOUOqnOycP9wznjTVWB9v5KW9wQZKh8VSo6szXChWqeEWqWbRBuI3FzeE+b
         M8OIZp/lJe37ZRbDhvJApKuVWmAofi3Zcuj0aWcQeRWLrTdk4iXpBIT4F+f2awTILxB2
         Ep3bkTJD5l11ZSJMozdYMlZKGoWyZs3kGkre9dPnjUcmHsTY7cCDVvbj0qfe7Qg3L6Vx
         jHDzFxEjRsqcxmsnAlPj37HX3pnHkgBTaYvktte4fIpQFFdSXvbOE1iskt2qBBv4UUo7
         +wo0r0rtjyyYK+dXRc706UpfDsmZaYwvmSQbj+TC4f1CgOj3Xbr8GrnNlhXT0VKEZyhq
         TI9w==
X-Gm-Message-State: APjAAAUXnprOqoWNuuB7teXabKVgA36i95obkcrtCRG7cZ4lhBqI27Ig
        mOcy2/ttiD+G+zEKPNrpyLkgln69WEY=
X-Google-Smtp-Source: APXvYqwz+0x7RONeJbKjUnRXjeymxUnQSwmgLwpHeeoqm1M6i5wivZrMYqkPk7JDlsvHSKoQHeWXu8isL0I=
X-Received: by 2002:a63:1c22:: with SMTP id c34mr78125523pgc.56.1563923212254;
 Tue, 23 Jul 2019 16:06:52 -0700 (PDT)
Date:   Tue, 23 Jul 2019 16:05:26 -0700
Message-Id: <20190723230529.251659-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v4 0/3] Casefolding in F2FS
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are largely based on the casefolding patches for ext4

v4: Added FS_CASEFOLD_FL flag, added documentation that escaped the last
    format-patch, moved setting dentry ops to f2fs_setup_casefold
v3: Addressed feedback, apart from F2FS_CASEFOLD_FL/FS_CASEFOLD_FL
    Added sysfs file "encoding" to see the encoding set on a filesystem
v2: Rebased patches again master, changed f2fs_msg to f2fs_info/f2fs_err

Daniel Rosenberg (3):
  fs: Reserve flag for casefolding
  f2fs: include charset encoding information in the superblock
  f2fs: Support case-insensitive file name lookups

 Documentation/ABI/testing/sysfs-fs-f2fs |   7 ++
 Documentation/filesystems/f2fs.txt      |   3 +
 fs/f2fs/dir.c                           | 126 ++++++++++++++++++++++--
 fs/f2fs/f2fs.h                          |  21 +++-
 fs/f2fs/file.c                          |  16 ++-
 fs/f2fs/hash.c                          |  35 ++++++-
 fs/f2fs/inline.c                        |   4 +-
 fs/f2fs/inode.c                         |   4 +-
 fs/f2fs/namei.c                         |  21 ++++
 fs/f2fs/super.c                         |  96 ++++++++++++++++++
 fs/f2fs/sysfs.c                         |  23 +++++
 include/linux/f2fs_fs.h                 |   9 +-
 include/uapi/linux/fs.h                 |   1 +
 tools/include/uapi/linux/fs.h           |   1 +
 14 files changed, 347 insertions(+), 20 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog


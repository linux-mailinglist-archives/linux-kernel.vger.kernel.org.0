Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6981011CF56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 15:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfLLOIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 09:08:02 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:43130 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfLLOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:08:01 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 473A2200A97;
        Thu, 12 Dec 2019 14:08:00 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 8E99420B64; Thu, 12 Dec 2019 15:07:56 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] remove ksys_dup()
Date:   Thu, 12 Dec 2019 15:07:50 +0100
Message-Id: <20191212140752.347520-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of pretending to be userspace, the opening of
/dev/console as stdin/stdout/stderr can be implemented
using in-kernel functions.

---

@viro: is this something for you to take and push upstream
for the next cycle?

The same changes (on top of commit ae4b064e2a616b545acf02b8f50cc513b32c7522:

  Merge tag 'afs-fixes-20191211' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2019-12-11 18:10:40 -0800)

are also available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git remove-ksys-dup

including all changes up to d7aacb7ad766adea665b440b56e9c9152b1065f7:

  fs: remove ksys_dup() (2019-12-12 14:59:48 +0100)

----------------------------------------------------------------
Dominik Brodowski (2):
      init: unify opening /dev/console as stdin/stdout/stderr
      fs: remove ksys_dup()

 fs/file.c                |  7 +------
 include/linux/initrd.h   |  2 ++
 include/linux/syscalls.h |  1 -
 init/do_mounts_initrd.c  |  5 +----
 init/main.c              | 31 ++++++++++++++++++++++++++-----
 5 files changed, 30 insertions(+), 16 deletions(-)

Thanks,
	Dominik

-- 
2.24.1


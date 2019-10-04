Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C1ECB413
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 07:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfJDFFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 01:05:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbfJDFFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 01:05:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C50DDB06B;
        Fri,  4 Oct 2019 05:05:21 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes and cleanups for 5.4-rc2
Date:   Fri,  4 Oct 2019 07:05:20 +0200
Message-Id: <20191004050520.7270-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.4-rc2-tag

xen: fixes and cleanups for 5.4-rc2

It contains the following patches:

- a fix in the Xen balloon driver avoiding hitting a BUG_ON() in some
  cases, plus a follow-on cleanup series for that driver

- a patch for introducing non-blocking EFI callbacks in Xen's EFI driver,
  plu a cleanup patch for Xen EFI handling merging the x86 and ARM arch
  specific initialization into the Xen EFI driver

- a fix of the Xen xenbus driver avoiding a self-deadlock when cleaning
  up after a user process has died

- a fix for Xen on ARM after removal of ZONE_DMA

- a cleanup patch for avoiding build warnings for Xen on ARM


Thanks.

Juergen

 arch/arm/include/asm/xen/xen-ops.h       |  6 ---
 arch/arm/xen/Makefile                    |  1 -
 arch/arm/xen/efi.c                       | 28 -----------
 arch/arm/xen/enlighten.c                 |  3 +-
 arch/arm/xen/mm.c                        |  5 +-
 arch/arm64/include/asm/xen/xen-ops.h     |  7 ---
 arch/arm64/xen/Makefile                  |  1 -
 arch/x86/xen/efi.c                       | 14 +-----
 drivers/xen/balloon.c                    | 24 +++------
 drivers/xen/efi.c                        | 84 ++++++++++++++++++--------------
 drivers/xen/xenbus/xenbus_dev_frontend.c | 20 +++++++-
 include/xen/xen-ops.h                    | 25 +---------
 12 files changed, 79 insertions(+), 139 deletions(-)

David Hildenbrand (4):
      xen/balloon: Set pages PageOffline() in balloon_add_region()
      xen/balloon: Drop __balloon_append()
      xen/balloon: Mark pages PG_offline in balloon_append()
      xen/balloon: Clear PG_offline in balloon_retrieve()

Juergen Gross (2):
      xen/efi: have a common runtime setup function
      xen/xenbus: fix self-deadlock after killing user process

Peng Fan (1):
      arm: xen: mm: use __GPF_DMA32 for arm64

Ross Lagerwall (1):
      xen/efi: Set nonblocking callbacks

Stefano Stabellini (1):
      ARM: xen: unexport HYPERVISOR_platform_op function

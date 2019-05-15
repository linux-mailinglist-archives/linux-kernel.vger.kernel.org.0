Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF841FA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfEOSiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 14:38:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfEOSix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:38:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 794F3AD72;
        Wed, 15 May 2019 18:38:52 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes and features for 5.2-rc1
Date:   Wed, 15 May 2019 20:38:50 +0200
Message-Id: <20190515183850.26413-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.2b-rc1-tag

xen: fixes and features for 5.2-rc1

It contains:
- some minor cleanups
- 2 small corrections for Xen on ARM
- 2 fixes for Xen PVH guest support
- a patch for a new command line option to tune virtual timer handling

Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 arch/arm/xen/p2m.c                              |  4 +++-
 arch/x86/platform/pvh/enlighten.c               |  8 ++++----
 arch/x86/xen/efi.c                              | 12 ++++++------
 arch/x86/xen/enlighten_pv.c                     |  2 +-
 arch/x86/xen/enlighten_pvh.c                    |  7 ++++++-
 arch/x86/xen/time.c                             | 20 +++++++++++++++++---
 arch/x86/xen/xen-ops.h                          |  4 ++--
 drivers/xen/xen-pciback/xenbus.c                |  2 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c        |  2 --
 10 files changed, 47 insertions(+), 21 deletions(-)

Gustavo A. R. Silva (1):
      xen-netfront: mark expected switch fall-through

Hariprasad Kelam (1):
      xen: xen-pciback: fix warning Using plain integer as NULL pointer

Hillf Danton (2):
      xen/arm: Free p2m entry if fail to add it to RB tree
      xen/arm: Use p2m entry with lock protection

Mao Wenan (1):
      xenbus: drop useless LIST_HEAD in xenbus_write_watch() and xenbus_file_write()

Roger Pau Monne (2):
      xen/pvh: set xen_domain_type to HVM in xen_pvh_init
      xen/pvh: correctly setup the PV EFI interface for dom0

Ryan Thibodeaux (1):
      x86/xen: Add "xen_timer_slop" command line option

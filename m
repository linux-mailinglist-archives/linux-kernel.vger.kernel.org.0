Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FF27FC81
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436740AbfHBOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 10:47:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404067AbfHBOrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:47:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6E8FAC91;
        Fri,  2 Aug 2019 14:47:47 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 5.3-rc3
Date:   Fri,  2 Aug 2019 16:47:46 +0200
Message-Id: <20190802144746.18653-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.3a-rc3-tag

xen: fixes for 5.3-rc3

It contains:
- a small cleanup
- a fix for a build error on ARM with some configs
- a fix of a patch for the Xen gntdev driver
- 3 patches for fixing a potential problem in the swiotlb-xen driver
  which Konrad was fine with me carrying them through the Xen tree

Thanks.


Juergen

 drivers/xen/gntdev.c                            |  2 +-
 drivers/xen/privcmd.c                           | 35 ++++---------------------
 drivers/xen/swiotlb-xen.c                       | 34 +++++++-----------------
 drivers/xen/xen-pciback/conf_space_capability.c |  3 +--
 drivers/xen/xlate_mmu.c                         | 32 ++++++++++++++++++++++
 include/linux/page-flags.h                      |  4 +++
 include/xen/xen-ops.h                           |  3 +++
 7 files changed, 56 insertions(+), 57 deletions(-)

Arnd Bergmann (1):
      xen: avoid link error on ARM

Juergen Gross (3):
      xen/swiotlb: fix condition for calling xen_destroy_contiguous_region()
      xen/swiotlb: simplify range_straddles_page_boundary()
      xen/swiotlb: remember having called xen_create_contiguous_region()

Souptick Joarder (1):
      xen/gntdev.c: Replace vm_map_pages() with vm_map_pages_zero()

YueHaibing (1):
      xen/pciback: remove set but not used variable 'old_state'

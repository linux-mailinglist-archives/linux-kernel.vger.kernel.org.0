Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99847108865
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 06:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKYFe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 00:34:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:37828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfKYFe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 00:34:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB0ACB042;
        Mon, 25 Nov 2019 05:34:55 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for xen
Date:   Mon, 25 Nov 2019 06:34:54 +0100
Message-Id: <20191125053454.19556-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5a-rc1-tag

xen: fixes for xen

It contains following patches:

- a small series to remove the build constraint of Xen x86 MCE handling
  to 64-bit only

- a bunch of minor cleanups
  

Thanks.

Juergen

 arch/arm/xen/mm.c                |  3 +-
 arch/x86/include/asm/msr-index.h |  2 ++
 drivers/xen/Kconfig              | 63 ++++++++++++++++++++--------------------
 drivers/xen/mcelog.c             | 14 +++++++--
 include/xen/interface/xen-mca.h  | 10 +++++--
 5 files changed, 56 insertions(+), 36 deletions(-)

Ben Dooks (Codethink) (2):
      xen: mm: include <xen/xen-ops.h> for missing declarations
      xen: mm: make xen_mm_init static

Jan Beulich (3):
      xen/mcelog: drop __MC_MSR_MCGCAP
      xen/mcelog: add PPIN to record when available
      xen/mcelog: also allow building for 32-bit kernels

Jason Gunthorpe (1):
      xen/gntdev: Use select for DMA_SHARED_BUFFER

Krzysztof Kozlowski (1):
      xen: Fix Kconfig indentation

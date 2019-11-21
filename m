Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22A1047F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 02:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKUBWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 20:22:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:42568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbfKUBWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:22:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B37EB26F;
        Thu, 21 Nov 2019 01:22:23 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de, bp@alien8.de
Cc:     peterz@infradead.org, x86@kernel.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH -tip v3 0/4] x86,mm/pat: Move towards using generic interval tree
Date:   Wed, 20 Nov 2019 17:15:57 -0800
Message-Id: <20191121011601.20611-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2:
 - Removed unnecessary goto error path in patch 1, per tglx.
 - Added the corresponding Makefile change for patch 4, per mingo.
 - Added tglx's review tags.

Changes from v1[0]:
 - Got rid of more code in patch 1 by using the end - 1 for closed
   intervals, instead of keeping the overlap-check.
   
 - added an additional cleanup patch.

Hi,

I'm sending this series again in this format as the interval tree
node conversion will, at a minimum, take longer than hoped for
(ie: Jason still removing interval tree users for the mmu_notifier
rework[1]). There is also a chance this will never see be done.

As such, I'm resending this series (where patch 1 is the only
interesting one and which Ingo acked previously, with the exception
that the nodes remain fully closed). In the future, it would be
trivial to port pat tree to semi open nodes, but for now think that
it makes sense to just get the pat changes in.

Please consider for v5.5. Thanks!

[0] https://lore.kernel.org/lkml/20190813224620.31005-1-dave@stgolabs.net/
[1] https://marc.info/?l=linux-mm&m=157116340411211

Davidlohr Bueso (4):
  x86/mm, pat: Convert pat tree to generic interval tree
  x86/mm, pat: Cleanup some of the local memtype_rb_* calls
  x86/mm, pat: Drop rbt prefix from external memtype calls
  x86/mm, pat: Rename pat_rbtree.c to pat_interval.c

 arch/x86/mm/Makefile       |   2 +-
 arch/x86/mm/pat.c          |   8 +-
 arch/x86/mm/pat_internal.h |  20 ++--
 arch/x86/mm/pat_interval.c | 185 +++++++++++++++++++++++++++++++
 arch/x86/mm/pat_rbtree.c   | 268 ---------------------------------------------
 5 files changed, 200 insertions(+), 283 deletions(-)
 create mode 100644 arch/x86/mm/pat_interval.c
 delete mode 100644 arch/x86/mm/pat_rbtree.c

-- 
2.16.4


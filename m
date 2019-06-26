Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2156FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFZRvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 13:51:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:49814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZRvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="337288585"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2019 10:51:08 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 02/10] x86/resctrl: Remove unnecessary size compute
Date:   Wed, 26 Jun 2019 10:48:41 -0700
Message-Id: <22c7b48603642b02bf1ff66692ae41eee9034dee.1561569068.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information about a cache pseudo-locked region is maintained in its
struct pseudo_lock_region. One of these properties is the size of the
region that is computed before it is created and does not change over
the pseudo-locked region's lifetime.

When displaying the size of the pseudo-locked region to the user it is
thus not necessary to compute the size again from other properties, it
could just be printed directly from its struct.

The code being changed is entered only when the resource group is
pseudo-locked. At this time the pseudo-locked region has already been
created and the size property would thus be valid.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bf3034994754..721fd7b0b0dc 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1308,10 +1308,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		} else {
 			seq_printf(s, "%*s:", max_name_width,
 				   rdtgrp->plr->r->name);
-			size = rdtgroup_cbm_to_size(rdtgrp->plr->r,
-						    rdtgrp->plr->d,
-						    rdtgrp->plr->cbm);
-			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id, size);
+			seq_printf(s, "%d=%u\n", rdtgrp->plr->d->id,
+				   rdtgrp->plr->size);
 		}
 		goto out;
 	}
-- 
2.17.2


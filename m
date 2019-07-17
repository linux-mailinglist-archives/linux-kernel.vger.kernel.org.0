Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335E66B74C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGQHOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 03:14:54 -0400
Received: from 8bytes.org ([81.169.241.247]:35594 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQHOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:14:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C5C11284; Wed, 17 Jul 2019 09:14:51 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3 v2] Sync unmappings in vmalloc/ioremap areas
Date:   Wed, 17 Jul 2019 09:14:36 +0200
Message-Id: <20190717071439.14261-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a small patch-set to sync unmappings in the
vmalloc/ioremap areas between page-tables in the system.

This is only needed x86-32 with !SHARED_KERNEL_PMD, which is
the case on a PAE kernel with PTI enabled.

On affected systems the missing sync causes old mappings to
persist in some page-tables, causing data corruption and
other undefined behavior.

Please review.

Thanks,

	Joerg

Changes since v1:
	- Added correct Fixes-tags to all patches

Joerg Roedel (3):
  x86/mm: Check for pfn instead of page in vmalloc_sync_one()
  x86/mm: Sync also unmappings in vmalloc_sync_one()
  mm/vmalloc: Sync unmappings in vunmap_page_range()

 arch/x86/mm/fault.c | 9 +++++----
 mm/vmalloc.c        | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.17.1


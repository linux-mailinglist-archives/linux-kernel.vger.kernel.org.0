Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27F7E8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 19:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfD2RW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 13:22:26 -0400
Received: from foss.arm.com ([217.140.101.70]:34426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfD2RWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:22:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40EC480D;
        Mon, 29 Apr 2019 10:22:25 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D4BA3F557;
        Mon, 29 Apr 2019 10:22:24 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Device-memory-related cleanups
Date:   Mon, 29 Apr 2019 18:22:14 +0100
Message-Id: <cover.1556555457.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is essentially just a repost, with the trivial typo fix plus all
the acks/reviews collected. There's no direct dependency between the
patches here, so hopefully at least #1 and #3 might sneak into 5.2 if
there's still time, as that would save some bother for follow-up arm64
work next cycle which will depend on both.

Robin.


Robin Murphy (3):
  mm/memremap: Rename and consolidate SECTION_SIZE
  mm: clean up is_device_*_page() definitions
  mm: introduce ARCH_HAS_PTE_DEVMAP

 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
 arch/x86/Kconfig                             |  2 +-
 arch/x86/include/asm/pgtable.h               |  4 +-
 arch/x86/include/asm/pgtable_types.h         |  1 -
 include/linux/mm.h                           | 47 +++++++-------------
 include/linux/mmzone.h                       |  1 +
 include/linux/pfn_t.h                        |  4 +-
 kernel/memremap.c                            | 10 ++---
 mm/Kconfig                                   |  5 +--
 mm/gup.c                                     |  2 +-
 mm/hmm.c                                     |  2 -
 12 files changed, 29 insertions(+), 52 deletions(-)

-- 
2.21.0.dirty


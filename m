Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7680E2DD34
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfE2Mem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 08:34:42 -0400
Received: from foss.arm.com ([217.140.101.70]:45022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2Mem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:34:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB0F180D;
        Wed, 29 May 2019 05:34:41 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23E9B3F59C;
        Wed, 29 May 2019 05:34:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 0/4] arm64/mm: Fixes and cleanups for do_page_fault()
Date:   Wed, 29 May 2019 18:04:41 +0530
Message-Id: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some fixes and cleanups for page fault handling in
do_page_fault(). This has been boot tested on arm64 platform along with
some stress test but just build tested on others.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>

Anshuman Khandual (4):
  arm64/mm: Drop mmap_sem before calling __do_kernel_fault()
  arm64/mm: Drop task_struct argument from __do_page_fault()
  arm64/mm: Consolidate page fault information capture
  arm64/mm: Drop vm_fault_t argument from __do_page_fault()

 arch/arm64/mm/fault.c | 77 +++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

-- 
2.7.4


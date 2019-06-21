Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEC4E457
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfFUJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 05:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfFUJkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:40:13 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414ED20673;
        Fri, 21 Jun 2019 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561110013;
        bh=BqH9Qhk/cLiuyBOOBEqaHd57WIG/8b+VS3FZ1Grpbt0=;
        h=From:To:Cc:Subject:Date:From;
        b=GSUX2iSUGlbkYLWKzwvCt5gySJNway4w7KFc34dlTv2Sg+uSr/8QiUW5recGm7zOr
         EmCRj74iOVIlFnMvk5efJfZOMQTGT4+WlD9Doy2DTVW2X0uwZWei1BiVrxAynWCRn4
         e5+eDutgvhCEgOqj1GWUucKTQfJNBfDbOT0zPrVc=
From:   guoren@kernel.org
To:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 0/4] csky: Use generic asid function from arm
Date:   Fri, 21 Jun 2019 17:39:55 +0800
Message-Id: <1561109999-4322-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

For C-SKY the first implementation is from mips and it's not implemented
well for SMP in performance. Arm's asid allocator is right for us and
we've tested it in our all CPUs:610/807/810/860 and it really reduce the
tlb flush. We'll continue stress testing before merge into master.

Changes for V2:
 - Add back set/clear cpu_mm.
 - Update commit message to explain asid allocator.

Guo Ren (4):
  csky: Revert mmu ASID mechanism
  csky: Add new asid lib code from arm
  csky: Use generic asid algorithm to implement switch_mm
  csky: Improve tlb operation with help of asid

 arch/arm64/lib/asid.c               |   9 +-
 arch/csky/abiv1/inc/abi/ckmmu.h     |   6 +
 arch/csky/abiv2/inc/abi/ckmmu.h     |  10 ++
 arch/csky/include/asm/asid.h        |  78 ++++++++++++
 arch/csky/include/asm/mmu.h         |   2 +-
 arch/csky/include/asm/mmu_context.h | 114 ++---------------
 arch/csky/include/asm/pgtable.h     |   2 -
 arch/csky/kernel/smp.c              |   2 -
 arch/csky/mm/Makefile               |   2 +
 arch/csky/mm/asid.c                 | 188 ++++++++++++++++++++++++++++
 arch/csky/mm/context.c              |  46 +++++++
 arch/csky/mm/init.c                 |   2 -
 arch/csky/mm/tlb.c                  | 238 ++++++++++++++----------------------
 13 files changed, 444 insertions(+), 255 deletions(-)
 create mode 100644 arch/csky/include/asm/asid.h
 create mode 100644 arch/csky/mm/asid.c
 create mode 100644 arch/csky/mm/context.c

-- 
2.7.4


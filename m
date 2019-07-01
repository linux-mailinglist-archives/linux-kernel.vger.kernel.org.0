Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479664B356
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfFSHt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 03:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfFSHt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:49:27 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE142075E;
        Wed, 19 Jun 2019 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560930566;
        bh=RtLGp1BLs2iXTdDwJvaYbkKOMPEEgxwUU8ka7QnC9Qo=;
        h=From:To:Cc:Subject:Date:From;
        b=Le25M2D+NY4pMWf9qrEaN8TubDUuyJwyqB+ZkPv0WwKOBJ9pLhZgA/m6zTLBYaIrm
         29GsaS0PIrgo5kybdhXh6dAF42p0KdmLaxupKBF8iM0uVSpV7ai4UKMgtl9+E6mpWE
         ACmINwqhMbQfQlDWWh3YhEcRqc7HCLMEaOyNIDEw=
From:   guoren@kernel.org
To:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 0/4] csky: Use generic asid function from arm
Date:   Wed, 19 Jun 2019 15:49:09 +0800
Message-Id: <1560930553-26502-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Julien Grall plan to seperate asid allocator into generic and vmid and
other architectures could use it.

ref:
https://lore.kernel.org/linux-arm-kernel/20190321163623.20219-1-julien.grall@arm.com/

For C-SKY the first implementation is from mips and it's not implemented
well for SMP in performance. Arm's asid allocator is right for us and
we've tested it in our all CPUs:610/807/810/860 and it really reduce the
tlb flush. We'll continue stress testing before merge into master.

It's good for all architectures in linux and let's continue the work.

@Julien
 Could you give a seperate patch for add generic asid ?

Guo Ren (4):
  csky: Revert mmu ASID mechanism
  arch: Add generic asid implement from arm
  csky: Use generic asid algorithm to implement switch_mm
  csky: Improve tlb operation with help of asid

 arch/csky/abiv1/inc/abi/ckmmu.h     |   6 +
 arch/csky/abiv2/inc/abi/ckmmu.h     |  10 ++
 arch/csky/include/asm/asid.h        |  77 ++++++++++++
 arch/csky/include/asm/mmu.h         |   2 +-
 arch/csky/include/asm/mmu_context.h | 114 ++---------------
 arch/csky/include/asm/pgtable.h     |   2 -
 arch/csky/kernel/smp.c              |   2 -
 arch/csky/mm/Makefile               |   2 +
 arch/csky/mm/asid.c                 | 185 ++++++++++++++++++++++++++++
 arch/csky/mm/context.c              |  46 +++++++
 arch/csky/mm/init.c                 |   2 -
 arch/csky/mm/tlb.c                  | 238 ++++++++++++++----------------------
 12 files changed, 434 insertions(+), 252 deletions(-)
 create mode 100644 arch/csky/include/asm/asid.h
 create mode 100644 arch/csky/mm/asid.c
 create mode 100644 arch/csky/mm/context.c

-- 
2.7.4


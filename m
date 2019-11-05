Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71E1EFFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbfKEOda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 09:33:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389110AbfKEOda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:33:30 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC24621882;
        Tue,  5 Nov 2019 14:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572964409;
        bh=hXmkzDwTgrPhaWgnpZzxD81BNpiXtqjPDiGXRaspyxA=;
        h=From:To:Cc:Subject:Date:From;
        b=jRz9AgH5C8D6SlSMAS1O0JBxfDpBQnF2v0y+0Q2cMgaHGkYQRhWsBdASBaA6xiNmt
         NcGziJ00wTdmrGGvtqzjbfqwdS3YJtcRgWUBYH+syP760W3PuwdYCzjMFVy6NZrPdd
         gDgGy4+luqc3H9Q1D+3olnbV/m11xDCLJnWlLp8E=
From:   Mike Rapoport <rppt@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/2] xtensa: get rid of __ARCH_USE_5LEVEL_HACK
Date:   Tue,  5 Nov 2019 16:33:18 +0200
Message-Id: <1572964400-16542-1-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

These patches update the xtensa page table folding/unfolding to take into
account the 5th level.

Mike Rapoport (2):
  xtensa: mm: fix PMD folding implementation
  xtensa: get rid of __ARCH_USE_5LEVEL_HACK

 arch/xtensa/include/asm/pgtable.h |  4 ----
 arch/xtensa/mm/fault.c            | 16 ++++++++++++++--
 arch/xtensa/mm/kasan_init.c       |  8 ++++++--
 arch/xtensa/mm/mmu.c              |  4 +++-
 arch/xtensa/mm/tlb.c              |  9 ++++++++-
 5 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.7.4


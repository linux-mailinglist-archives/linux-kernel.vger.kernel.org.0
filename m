Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65863BD6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfFJUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 16:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfFJUZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:25:36 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A1D2082E;
        Mon, 10 Jun 2019 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560198336;
        bh=gDGsy2m0w4KjVtKFwe6BhIUXecNIJ+3dfki+ru/tPh8=;
        h=From:To:Cc:Subject:Date:From;
        b=Yj8hOlAXMRwNLlH6Amy1TzXfZppDj4xeVMeEj0fQEUQnRwg7Mv7a605hX0mse2Fuk
         3ouZynDrxCD6uEDnic2VdnvaHBN922w0/nf4WgQc1EGH5dS0Mk5n3DMSPFyOi12t/t
         ASqzAnr+09Bb7VwT+2j4C62GHBiYj456tra1Le4g=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/5] vsyscall xonly mode
Date:   Mon, 10 Jun 2019 13:25:26 -0700
Message-Id: <cover.1560198181.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

This adds a new "xonly" mode for vsyscalls and makes it the default.
xonly is a bit more secure -- Kees knows about an exploit that relied on
read access to the vsyscall page.  It's also nicer from a paging
perspective, as it doesn't require user access to any of the kernel
address space as far as the CPU is concerned.  This would, for example,
allow a much simpler implementation of per-process vsyscall disabling.

Andy Lutomirski (5):
  x86/vsyscall: Remove the vsyscall=native documentation
  x86/vsyscall: Add a new vsyscall=xonly mode
  x86/vsyscall: Document odd #PF's error code for vsyscalls
  selftests/x86/vsyscall: Verify that vsyscall=none blocks execution
  x86/vsyscall: Change the default vsyscall mode to xonly

 .../admin-guide/kernel-parameters.txt         | 11 ++-
 arch/x86/Kconfig                              | 32 ++++---
 arch/x86/entry/vsyscall/vsyscall_64.c         | 19 ++++-
 arch/x86/mm/fault.c                           |  7 ++
 tools/testing/selftests/x86/test_vsyscall.c   | 83 +++++++++++++------
 5 files changed, 107 insertions(+), 45 deletions(-)

-- 
2.21.0


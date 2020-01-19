Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB75141FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 21:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgASUUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 15:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:32934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgASUUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 15:20:04 -0500
Subject: Re: [GIT PULL] RISC-V updates for v5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579465204;
        bh=bYz4CEe6vBzclYXesXXipvtUCFT3cuPjD73rgGjD4EU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tzFpSzeoYlQ1e8PZpQNnoBP4fSUblqw4QHsq8MX3+GeggAtJllhUKHqK5rDvrrEas
         HClBSVNKC+kyA0t5Lr3j1teExa+YOmFZWCTEKeJiCJk8C75PDkOqcWfJKGzoixPETJ
         HSl5wMsSwapilnYW/f7uz1t6VCyZwrOnymQv7M2I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.2001190951380.106116@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.2001190951380.106116@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.2001190951380.106116@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.5-rc7
X-PR-Tracked-Commit-Id: fc585d4a5cf614727f64d86550b794bcad29d5c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7008ee121089b8193aea918b98850fe87d996508
Message-Id: <157946520423.8493.8283323752335165653.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jan 2020 20:20:04 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jan 2020 09:52:16 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7008ee121089b8193aea918b98850fe87d996508

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

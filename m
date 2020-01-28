Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70EE14C0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 20:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgA1TKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 14:10:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbgA1TKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:10:06 -0500
Subject: Re: [GIT PULL] EFI changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580238605;
        bh=qxWaEzMcFI9COKiedAkuQzda41LgemvU4mrDcYZsfpg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QYebpCInFczYt5Xrxx0jpnpG+He4HrgzeXpRPiZfnlO30XH2GtAVrDa7yxJ2vyPuN
         stjwvTVnxfBVFl0hLTCeJnQSvUhtl2AeK5/jtxOQvRkI9c/5toDhm7mTxc0gCkhZqb
         BChH+qOEdPlTVu387HJuwVgIYiDBfZnC0BJ4gz50=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128074850.GA27168@gmail.com>
References: <20200128074850.GA27168@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128074850.GA27168@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
X-PR-Tracked-Commit-Id: ac6119e7f25b842fc061e8aec88c4f32d3bc28ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 634cd4b6afe15dca8df02bcba242b9b0c5e9b5a5
Message-Id: <158023860549.9583.5506914354548196206.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 19:10:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 08:48:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/634cd4b6afe15dca8df02bcba242b9b0c5e9b5a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

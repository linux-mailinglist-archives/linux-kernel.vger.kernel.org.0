Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550AF14C1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 22:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgA1VPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 16:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgA1VPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:05 -0500
Subject: Re: [GIT PULL] x86/asm changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246105;
        bh=NZD7rCdMXkp4quf3OqFWd9FdT7eUlAXGX7ang5GrKGs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tZZ6YWgYL3QY68Bn9BzIZ+auHvAgnVGy+LHwn1cvJI2jQjOf3ZvzZCQ7aspehA6E3
         mcteSrlKyZTxaYjHdNYrRRlLpFNr4J8NbuerDIz3qhrkvhtXwn13cxxoS8oWwbkZ8t
         AsW6XV29UKIkjr/1PV+Yp2sJ7R6Eh9pHAXNr5C8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128165906.GA67781@gmail.com>
References: <20200128165906.GA67781@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128165906.GA67781@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus
X-PR-Tracked-Commit-Id: 183ef7adf4ed638ac0fb0c3c9a71fc00e8512b61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcc8aff6af53907ecb60e5aa8b34fbd429408a7a
Message-Id: <158024610541.20407.5811612160678826619.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 17:59:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcc8aff6af53907ecb60e5aa8b34fbd429408a7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E639D14ADA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 02:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgA1BfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 20:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgA1BfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:06 -0500
Subject: Re: [GIT pull] smp/core for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175306;
        bh=DnUwPcqcoPWC38r4Nx69dy12kdAmjex/50rHLQbw0rM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v56YUeP18nZMFmNIWg+YgBcYW4NcUSIt+8nBxjrREPMb7rahQ568WhJ9fDDBHCGmn
         dI6YiwFVIqDH2pDQp3vbBEHpk46U2nN1L0vjM15yStGSArKg39acdaA+a+jSZmir1E
         o1Ftqso1GMNjKHXbs7TMwSFPIsggpiYgKasta17Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896589.31887.13016639707269883122.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896589.31887.13016639707269883122.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896589.31887.13016639707269883122.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-01-28
X-PR-Tracked-Commit-Id: cb923159bbb8cc8fe09c19a3435ee11fd546f3d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab67f600253f0f7b3992399918cf69e71b22ff37
Message-Id: <158017530621.6677.17052484953890214666.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2020-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab67f600253f0f7b3992399918cf69e71b22ff37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

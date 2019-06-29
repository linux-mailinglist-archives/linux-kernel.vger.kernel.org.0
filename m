Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765325AA92
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 13:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfF2LpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 07:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfF2LpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 07:45:06 -0400
Subject: Re: [GIT PULL] IRQ fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561808706;
        bh=Qhcg/4AlYM723OdKCNdeEnw+dIqIKosGt1+he9nJkwE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mnprNu5eTg7sEbv3YunXslzTjkm9lanYMh1psnKVg8sqELPGiiJLkoNLC/xqUeyII
         jqqjoy/iQfD0ujRKBtSUSb68bWf+DsPcPlIECUlC0n97BnQaqX8lcvMa1Tq6F/pFx3
         0RPwSDfiSZ4CeZTp5KmcRId05mIZiNi55phK3YBs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190629085033.GA37583@gmail.com>
References: <20190629085033.GA37583@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190629085033.GA37583@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: a52548dd0491a544558e971cd5963501e1a2024d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eed7d30e126dc5b883b77f3e26bbca6c5b0f4222
Message-Id: <156180870652.30344.11659483181245077038.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jun 2019 11:45:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jun 2019 10:50:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eed7d30e126dc5b883b77f3e26bbca6c5b0f4222

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570F01419C4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgARVFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 16:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgARVFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:05 -0500
Subject: Re: [GIT PULL] IRQ fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381504;
        bh=/ASk6xrE1NdNmMq/DajRU93K3xEynwBiskSkxefIkjQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r9VRnC/oE/BnZywhPs4M8nIfOwjGyj4vBdgUz8dST53Fsbd+fDeIVKW6hpz6rq0ZT
         B1+SMZ3kdR1BNWzSXd4/AWO9M9PY+5BlgSSZqDP9CsE34qEyNFSgWswthpj7z9IG9m
         MkWgR0+oH7EE4573go0xWXrc4dbaNxj1WqsLUMmk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118171943.GA82768@gmail.com>
References: <20200118171943.GA82768@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118171943.GA82768@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 1fd224e35c1493e9f5d4d932c175616cccce8df9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1c6f87efc0ad67797bc81071b6e6291896d7460
Message-Id: <157938150466.20598.9272446761585207796.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 18:19:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1c6f87efc0ad67797bc81071b6e6291896d7460

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

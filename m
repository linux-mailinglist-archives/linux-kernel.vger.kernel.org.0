Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E9D6F05B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfGTSkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 14:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbfGTSk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:28 -0400
Subject: Re: [GIT pull] sched/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648028;
        bh=/cpxs0fd5YLbPBSWjoO5XOzLrRC/ESyJi/5tUp3b/1M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BWweMxFqgSepeTEvcP/H4n5mb63JIV3cPaSQ7HtDDafRtMQXMWgMtik157RZqGZd7
         CsILy85l4qavG3Ho3IVc68N208XEkCpH9ebG/cdbWfKIudEsbmBh7iUHTxGLnFc8+V
         zeO5m94egr0oCr7WM6PAmX++8Aftd/zOSver3ypQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156362700019.18624.13516337882561160480.tglx@nanos.tec.linutronix.de>
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
 <156362700019.18624.13516337882561160480.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156362700019.18624.13516337882561160480.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: a50a3f4b6a313dc76912bd4ad3b8b4f4b479c801
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70e6e1b971e46f5c1c2d72217ba62401a2edc22b
Message-Id: <156364802809.20023.353267650379573879.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 12:50:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70e6e1b971e46f5c1c2d72217ba62401a2edc22b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

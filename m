Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AAFFF634
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 01:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfKQAfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 19:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfKQAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 19:35:06 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573950906;
        bh=7ew15bySSGAHoCTsDKktwkw5pd2lLQljbvVuf9XqWII=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H7on4DFq57ZQtZqplKpgVZT+ez+WEnZCUwwoDTEP2q69uHPzTMuwzoEpTK88DwHAU
         OpUsY8g3N8pxhriP2VSCMyE9S678yIDrMt6Bm0GD3IMIzKMjZeXjnlNRpwtEc6yVJc
         KnLuTgPdGxayY7cQXbSFMIUJxFxMrbj38a0b/Pjk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191116214243.GA81282@gmail.com>
References: <20191116214243.GA81282@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191116214243.GA81282@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: c8eafe1495303bfd0eedaa8156b1ee9082ee9642
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe30021c36fbfb71d6ff25a424342149e58bba52
Message-Id: <157395090607.15664.9418362550444247934.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 00:35:06 +0000
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

The pull request you sent on Sat, 16 Nov 2019 22:42:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe30021c36fbfb71d6ff25a424342149e58bba52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071DA10A487
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKZTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbfKZTaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:20 -0500
Subject: Re: [GIT PULL] x86/pti updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796620;
        bh=KfWcTtZoTu93PxQhCrjLtv7+CPo99eOySQH8rbV0fcg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ko4r0JObdkqKa+Hyjo2S8dt6enBSgGDyq+wpffichXyRrsDiL1SZHu04iZvPAEZBg
         RF3rR1iLTEnApagXfsidnEVu8njOHoXgH3gT4zM8bERUMQk4w55HgYqsOmVdNTDBXb
         0Ma+9QtCwHGEudzUEZcpO/PWqi94hwQZKhi6ovHI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125143450.GA26649@gmail.com>
References: <20191125143450.GA26649@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125143450.GA26649@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus
X-PR-Tracked-Commit-Id: cd5a2aa89e847bdda7b62029d94e95488d73f6b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53a07a148fd05dc6d317745688270bc79fe73121
Message-Id: <157479662027.2359.889828018505104004.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:20 +0000
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

The pull request you sent on Mon, 25 Nov 2019 15:34:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53a07a148fd05dc6d317745688270bc79fe73121

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

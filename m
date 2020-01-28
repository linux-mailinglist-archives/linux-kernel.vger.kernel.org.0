Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD06C14C1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 22:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgA1VPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 16:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgA1VPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:08 -0500
Subject: Re: [GIT PULL] x86/fpu changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246108;
        bh=slgj6xFw6Viw4SuoBM8yyEdkOyv+TGDVSkESaQM4jFo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eh/ffoBGNMMxyKo+Dskg+ZnD7XlLLRfkR0RgaX4Pf3xiLNIXUe9lYEaUaOp6PPasV
         C/gGwQFbCnVTEeQjYb1Y7T/vGr7ZbzlEOcCHIymd8g4vCIcwnMOk81F3JVNQfO7j+V
         vP6iFiMDm92e+HzFWUoW3rJLgnR77Y/70ArCUqKQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128180754.GA104974@gmail.com>
References: <20200128180754.GA104974@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128180754.GA104974@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus
X-PR-Tracked-Commit-Id: bbc55341b9c67645d1a5471506370caf7dd4a203
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d6245ce8c8b441e01a3a1c1e67a1963a84498dd
Message-Id: <158024610841.20407.14259259353729654002.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, bpetkov@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 19:07:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d6245ce8c8b441e01a3a1c1e67a1963a84498dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

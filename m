Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB310A480
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKZTaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZTaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:06 -0500
Subject: Re: [GIT PULL] x86/decoder change for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796606;
        bh=IGtTu0orrfzxf9eTzVogs+bdlJDBKPO0OXuAhFzr5GA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QGs1jwh7wBj445mPwEuRJ5fdI3j+a6yI5V1+HQo13TojX9c29l8wipKnHhxNfh6+X
         T1QsOUcag2aIMqaGHCwFUG1xHh2LEIgqFlq/8SNZwnHWzfPu8u2lnAAlWLMHtAIk7u
         GbB/1nFpILi096oEahyhv1LpsbBEp0Zd/V+AjJaw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125102959.GA107197@gmail.com>
References: <20191125102959.GA107197@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125102959.GA107197@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-objtool-for-linus
X-PR-Tracked-Commit-Id: 700c1018b86d0d4b3f1f2d459708c0cdf42b521d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd2615908dfd0586ea40692a99c44e34b7e869bc
Message-Id: <157479660617.2359.17525412411713413934.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 11:29:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd2615908dfd0586ea40692a99c44e34b7e869bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

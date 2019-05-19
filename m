Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8E227F3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2019 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfESRpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 13:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfESRpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:45:23 -0400
Subject: Re: [GIT PULL] EFI fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558287922;
        bh=VvvVnhVZcpXecSIhYg4ACmmNbBt/VrKiEi34AGviMRM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M7A0XTugxtW/6SATIxyCJJNRaZOowZlL8E1u4+4Sj1EZW1drkX4tzouhdJJplZahY
         n6KdMw7O5N2SKQ1Ew+SFrGkFDznGKWJVqdB/YS0VuZ+8Y6XyPo491wWZ1NDql8JXKY
         Uhr7I31NhXKVITdq6FjHxmUC1dBGnt4lekEIM/rE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190518091726.GA47721@gmail.com>
References: <20190518091726.GA47721@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190518091726.GA47721@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: f8585539df0a1527c78b5d760665c89fe1c105a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39feaa3ff4453594297574e116a55bd6d5371f37
Message-Id: <155828792287.9186.2637617430225993607.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 17:45:22 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 May 2019 11:17:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39feaa3ff4453594297574e116a55bd6d5371f37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

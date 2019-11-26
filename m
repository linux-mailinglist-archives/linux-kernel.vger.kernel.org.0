Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9433710A488
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKZTa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:30:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfKZTaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:23 -0500
Subject: Re: [GIT PULL] x86/asm changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796622;
        bh=OYiDMH3KgukMnnf5oQv+5eZjUvq8Nszjo4PN+E8nU5w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hQ7aQUfBKV3hk8VD8MfUFO5MD8Co9T4EGVSEW88a9ydrMC/C8I1n1+c9ftJGvqCC8
         vk8Ymn8WJx3ddTjdqCvEZ9OgZhXGWcPQy8Lk8tsM5YPjaa4I5Kw8rRiGuA4L8UHUEV
         H4FZbsAJqy8mNJziIlshzOBeZ7sw/FngDHpjzKTI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125160821.GA42496@gmail.com>
References: <20191125160821.GA42496@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125160821.GA42496@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus
X-PR-Tracked-Commit-Id: f01ec4fca8207e31b59a010c3de679c833f3a877
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d87200446f1d10dfe9672ca8edb027a82612f8c
Message-Id: <157479662280.2359.7800189976684855326.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:22 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 17:08:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d87200446f1d10dfe9672ca8edb027a82612f8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

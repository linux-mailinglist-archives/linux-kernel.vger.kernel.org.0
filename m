Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3531A14C1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 22:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA1VPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 16:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgA1VPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:07 -0500
Subject: Re: [GIT PULL] x86/cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246106;
        bh=KYGkww9h0jZ3WkF/GvPxuI7zjgtrZdyqtTDUI0JaK74=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YDg0/AS8pQVJBzzbI78GlSZgZbWDX1UJp3Cj61nwn6YG+zVJStqXb3TT7CxsE1ynB
         cj1HCzunc/Fxhlka+qwCcRmHT1E5maJDgaigOdY6prE2yyL0jeMftP+aSwoWI5Bj4r
         npJM2TJJdM2prAlX3bKSZVNGemq4hTm2GCrYSWPI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128173452.GA25020@gmail.com>
References: <20200128173452.GA25020@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128173452.GA25020@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-for-linus
X-PR-Tracked-Commit-Id: 3c749b81ee99ef1a01d342ee5e4bc01e4332eb75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6da49d1abd2c2b70063f3606e3974c13d22497a1
Message-Id: <158024610692.20407.13960993485815701683.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:06 +0000
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

The pull request you sent on Tue, 28 Jan 2020 18:34:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6da49d1abd2c2b70063f3606e3974c13d22497a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

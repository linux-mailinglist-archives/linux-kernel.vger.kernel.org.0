Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B776515662
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfEFXkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfEFXkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:10 -0400
Subject: Re: [GIT PULL] x86/build changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186010;
        bh=C/GrTb/fcq9orGBUBnIM7dIjhreghlJnvqlyfzNKYIY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1s19JLvIJ3WwqUkMjMU1cwrzfp68u/Wh6XlxQjlwRVupTJ+IW1+EhKq4NTjaclQzC
         LqLKzI6xTpcMNbTTAXTIQNzzOkQ/I1SO0/o3eOxuBXcXtQlooBptJIHtEv6YNiPZCG
         VkEw8g+7RpQRidBRwaxASaJFU8O6yQ25hO4jEr6A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506094223.GA99131@gmail.com>
References: <20190506094223.GA99131@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506094223.GA99131@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus
X-PR-Tracked-Commit-Id: f36e7495dd3990d6848e6d6703c78f1f17a97538
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75571d822dcc89729c7a72cb7bf3ee8568351089
Message-Id: <155718601019.9113.10980656815635607375.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:10 +0000
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

The pull request you sent on Mon, 6 May 2019 11:42:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75571d822dcc89729c7a72cb7bf3ee8568351089

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

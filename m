Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1022762DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGIBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfGIBpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:09 -0400
Subject: Re: [GIT PULL] x86 cleanups for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636708;
        bh=mv5Lp4IXZkPvOFaFRZw6qqvSFOr5Ii9yfZQ7/ke53H0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l0CvVUEWlvK7vtUneQU9nDPoPxFPwcaFFc1S+MJwaixiGF4KuL5MBBWZG1+YCCSlm
         JbwrVwqJsJycxBAlSxPqR1mkflCHB5waxuBSAVGPRwQFYXYC8nj390xeFfupzGUu22
         n65GsKZio+9iPkJGQqEwv8IyMUeMy6td4amCEjJM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708160755.GA76526@gmail.com>
References: <20190708160755.GA76526@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708160755.GA76526@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-for-linus
X-PR-Tracked-Commit-Id: 53b7607382b0b99d6ae1ef5b1b0fa042b00ac7f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b7a2095232d026d4537c4be54040c0f10525b5b
Message-Id: <156263670877.17382.436562778155642303.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:08 +0000
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

The pull request you sent on Mon, 8 Jul 2019 18:07:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b7a2095232d026d4537c4be54040c0f10525b5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

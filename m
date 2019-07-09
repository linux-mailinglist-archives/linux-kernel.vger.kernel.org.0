Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB2762DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 03:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfGIBqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 21:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfGIBpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:07 -0400
Subject: Re: [GIT PULL] RAS changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636706;
        bh=1/ncZ0bkdCQFqOC4y5Exnfr4ePSYLP1FsVliwhs4oWg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JIshwz06zrsJTQTYCrkxb3VYrEv2yn+g2boR1AP2HXb+supcJpWMugW47jZJ5QWrE
         sk2aPlvKavPiBmXvgmYPMMSr/uNXb16RqgSvhPj/NgFhYcs7M2F4GkyelVWGQgYmbN
         4t1bvO+0F+QdyQmt4LSW+cE8QpUUBIqrx0/DM18M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708095102.GA59026@gmail.com>
References: <20190708095102.GA59026@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708095102.GA59026@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus
X-PR-Tracked-Commit-Id: 6e4f929ea8b2097b0052f6674de839a3c9d477e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 090bc5a2a91499c1fd64b78d125daa6ca5531d38
Message-Id: <156263670639.17382.12967288876934673525.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 11:51:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/090bc5a2a91499c1fd64b78d125daa6ca5531d38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

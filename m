Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499551419C6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 22:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgARVFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 16:05:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727465AbgARVFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:07 -0500
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381507;
        bh=aoq5uEXFxZqFsfno5TmAOvN3lVOGnbRKTD92rAU0CEA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2nfaf1+xvuwQlihbspYPBb7IY6jRGoJy7/ZI6NMbtcdLjALtNLvd430AunbQlcdU8
         NOLSWT4CFXhQIrDUbi5L1h8SiIvUOM/1OM1Tq2zpTczJlJKP+30qDLJPMu6hnAPu/6
         ehrPI0YGeoudsQA56En7D/xW9xjxznsDvZHcF9hc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118185258.GA19672@gmail.com>
References: <20200118185258.GA19672@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118185258.GA19672@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: a006483b2f97af685f0e60f3a547c9ad4c9b9e94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cc2682d8baaa6c7383e40153afc19239ad28d77
Message-Id: <157938150706.20598.1821715748849471357.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:07 +0000
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

The pull request you sent on Sat, 18 Jan 2020 19:52:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cc2682d8baaa6c7383e40153afc19239ad28d77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

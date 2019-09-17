Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC8DB4505
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 03:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfIQBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 21:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388445AbfIQBAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:00:23 -0400
Subject: Re: [GIT PULL] locking changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682022;
        bh=NZvI10WmJkrfRLnzGTd55fG7EGkYZlam5I22lBqwDbw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DfWpEyMAY6rReqDqsNU0rJ1IxF8nagMMtq1vfRj+f7X7yeENEMXFNwlzdnQ8aLrrk
         m8o51jKvhMKgRsaATVGn3K4NCIMnMlNE/ilkMqVBCkj3VtsmEvyQNDzZKHsnVr4yh3
         s35rxooF6nLTLrKXnmgxyH0j+/c83wBDj7fraic8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916114110.GA128086@gmail.com>
References: <20190916114110.GA128086@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916114110.GA128086@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-for-linus
X-PR-Tracked-Commit-Id: e57d143091f1c0b1a98140a4d2e63e113afb62c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7eba51cfdf9cd1ca7ed4201b30be8b2bef15ff5
Message-Id: <156868202284.3683.3500206218909742740.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 01:00:22 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:41:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7eba51cfdf9cd1ca7ed4201b30be8b2bef15ff5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

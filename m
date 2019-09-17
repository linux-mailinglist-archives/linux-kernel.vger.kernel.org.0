Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E92B45A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 04:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392090AbfIQCzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 22:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392068AbfIQCzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:21 -0400
Subject: Re: [GIT PULL] x86/cpu changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688920;
        bh=QNnDGChtQSfdzLNxQzI4LG49T3yI/z1OJKBSsY0Eack=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OE3QqrYt/OJyJUCsMJy/sS+x1QyOFlhN4PPvRIC7cgT0YKBB3xlK0NyCrpnDZyBe0
         hbzvvZsuxooYwlQkqSsTHcvmGtZ8P0YjMbgAHiONkoc7AItSmcqa2tpnrvIptqhEPG
         0SFwgE44duvpM43v7gTncj8Y8F5M728u14IVv57g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916125327.GA31120@gmail.com>
References: <20190916125327.GA31120@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916125327.GA31120@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus
X-PR-Tracked-Commit-Id: 0cc5359d8fd45bc410906e009117e78e2b5b2322
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22331f895298bd23ca9f99f6a237aae883c9e1c7
Message-Id: <156868892065.5285.12505600492111928532.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:20 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 14:53:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22331f895298bd23ca9f99f6a237aae883c9e1c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

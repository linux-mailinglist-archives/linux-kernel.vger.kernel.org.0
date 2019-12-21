Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B879128AED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 19:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfLUSzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 13:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfLUSzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:55:11 -0500
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576954510;
        bh=6AK3i3xZWWW0ob7O8uNwFaAF1w1vUaYzkdng2/FisOg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mkykGQVpjA5dhBU+OVtwAuud4HO/DjdLO7/ZwQBU79IM93CsdEIYllDbU2gPDthXh
         y5SNbdR7Beeg0qLK+9zGdEVKTzSu8opRbLDIpDsxVs0vl1RQLXQCGUOWDHU/cPITNh
         eRsLkclt4nBDwA9TNWdPDCi7DWa22C/eZFUnboP0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221161958.GA15732@gmail.com>
References: <20191221161958.GA15732@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221161958.GA15732@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 6cf82d559e1a1d89f06ff4d428aca479c1dd0be6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd7a6d2b8f1d67df76d0e863f003162b931074a1
Message-Id: <157695451047.26122.13101729395318118626.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 18:55:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 17:19:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd7a6d2b8f1d67df76d0e863f003162b931074a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

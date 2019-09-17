Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB60B45A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbfIQCzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 22:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392100AbfIQCzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:25 -0400
Subject: Re: [GIT PULL] x86/vmware changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688925;
        bh=zIHjbU8JyejMEEyhqiPGX/jh+bMlGnqY0z5fMMIXGT4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vQ7AyZXUzAP31laMbAu0/H2Ap0LAqsRGJbHejh00n4vsnlOjz7tVkloU72hBsGBDU
         YFx2PFfWyBXZ3X8fIj9+HRvwvrZaMKLpm7LKavQ/2OXy6lN0a+DM1ZHCbGv7WEI4wU
         2fmHPooKcW0gvyPpOvXpsFZKSDRvZm7dzmByIa1I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916133646.GA112398@gmail.com>
References: <20190916133646.GA112398@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916133646.GA112398@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-vmware-for-linus
X-PR-Tracked-Commit-Id: f7b15c74cffd760ec9959078982d8268a38456c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ac63f6ba5db5e2e81e4674551d6f9ec58e70618
Message-Id: <156868892545.5285.15004771936769873286.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:25 +0000
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

The pull request you sent on Mon, 16 Sep 2019 15:36:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vmware-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ac63f6ba5db5e2e81e4674551d6f9ec58e70618

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

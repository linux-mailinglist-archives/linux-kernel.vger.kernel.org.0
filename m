Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C98178667
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 00:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgCCXfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 18:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgCCXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:35:06 -0500
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583278505;
        bh=YEiwpyHMzWNVfdz3OiK5HEePksFJObEVKy6iMuPuIZE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xq1Cvw3z2fwSA8MNkjEK4gF5lJM263SIJADfVbWtRBQFyxlFKI8bA32dzhQEbJZn3
         q+kxsIulZyv+UFHSHMjPu4ZrnHRQkHm/aswvKMknxbQ97snlfrS6cKPfx8GKtuaLFz
         4oqqnn5KHeOf4qeq6w+nFEgXCtO/jrFYjPgQ/c2U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200302075136.GA48297@gmail.com>
References: <20200302075136.GA48297@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200302075136.GA48297@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 289de35984815576793f579ec27248609e75976e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c105df5d865afbc10e9730b7b13abc831d5e9ac7
Message-Id: <158327850561.6555.5673455029272373758.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Mar 2020 23:35:05 +0000
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

The pull request you sent on Mon, 2 Mar 2020 08:51:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c105df5d865afbc10e9730b7b13abc831d5e9ac7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

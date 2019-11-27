Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B399110A7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 02:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfK0BaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 20:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfK0BaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:30:09 -0500
Subject: Re: [GIT PULL] RCU changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574818209;
        bh=JvRoU/Gz+1vDxJ7geKxH7hDd6WcZwelMlpLfNPlCFjE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NoAdk1GH6mq/Aux9F7YYmQCWhbAjg2g3Led9ECbiTutGE/ppZDyKaxpmAzJs+snft
         z6FaiXc/rS7f+Vc9dCQTkg+Ed7+HarbenJ3VlMXlW3YnAen4xs5VTtv004TYgEki+K
         7GDZR9OBdPUQK6nsyxdVbdnESJlShdzkrsBBrxHY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125105326.GA20115@gmail.com>
References: <20191125105326.GA20115@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125105326.GA20115@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus
X-PR-Tracked-Commit-Id: 43e0ae7ae0f567a3f8c10ec7a4078bc482660921
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ae78780eda54023a0fb49ee743dbba39da148e0
Message-Id: <157481820928.26353.16101379092134031948.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 01:30:09 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 11:53:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ae78780eda54023a0fb49ee743dbba39da148e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

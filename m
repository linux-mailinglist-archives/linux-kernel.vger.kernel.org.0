Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6389CB56BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfIQUPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfIQUPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:20 -0400
Subject: Re: [GIT pull] smp/hotplug for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751320;
        bh=10wBVDWzdic9WYdUHVtNKyZPwQmRYkU4WC0YxIrFyB8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TLt9wOeKxEfUmdX4q9tOkJnBJ0e5DneDExxgEW3c37oWDt8GSW7q4xqInI521/Xqo
         Oeaojn3n5zs8esL0rE7WJ8ff7X7G9EfOYKTxCTIU96d6CyEMp9BEAxjI+ppZIdgjxg
         XMq4GR7hQjWLiDhyWW9hXElXZpI0cCQtERFdB+jc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062018.3407.12735658875708933630.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062018.3407.12735658875708933630.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062018.3407.12735658875708933630.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-hotplug-for-linus
X-PR-Tracked-Commit-Id: 0c09ab96fc820109d63097a2adcbbd20836b655f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cd0462230d806077c709e44af8733795eaa712c
Message-Id: <156875132004.8483.2176103209473894474.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cd0462230d806077c709e44af8733795eaa712c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

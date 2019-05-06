Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F207C15676
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfEFXl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfEFXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:08 -0400
Subject: Re: [GIT PULL] SMP hotplug support changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186008;
        bh=wLvblnipMupvIvx03SJNjzBBfSa4LBKvClGrLhdhqOk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OjxOoxUecejh83YfvRscRlyhNkuRd8C3G+ALshYiGhhn9ivY8iV9UyONNTnk8ECS+
         rVpgt4sFeP4+jheS35tGYFsvZuh2FV/xXB29/zUhlCMlixZgJuWt9liROsXRYdxfpQ
         3pCM1drk7L8a+5eXaDzlWcK+r+A07JEcV/V7FqpE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506091632.GA42696@gmail.com>
References: <20190506091632.GA42696@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506091632.GA42696@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-hotplug-for-linus
X-PR-Tracked-Commit-Id: d4645d30b50d1691c26ff0f8fa4e718b08f8d3bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a2bf1abbf96fca02b9785c252e569ef8e004851
Message-Id: <155718600840.9113.13445751111078551504.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 11:16:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a2bf1abbf96fca02b9785c252e569ef8e004851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

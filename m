Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C73680CC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 20:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfGNSpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 14:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfGNSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:45:13 -0400
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563129913;
        bh=m+mY587NobP0LvjVC5+14szum03jqWdwPgs8/VIULVg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wT/jvKBTbujGPeDnfDc4X/emKzU6iun08Q5G5LxgN9rh7yRc49EA6RUEjlShyPtA6
         HM48i4IlUujHGV8ZvwgwWqk3FIWuo8RCkXxDd5D7A56nhQNNvmQcH0IDixhGC//h34
         52zIKOClF4sqKu6UkxN0tRfcjJiR8e3jb5LOgBh4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190714101910.GA127043@gmail.com>
References: <20190714101910.GA127043@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190714101910.GA127043@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: e3d85487fba42206024bc3ed32e4b581c7cb46db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50ec18819cade37cccc914ffc71a8b0a2783c345
Message-Id: <156312991314.23515.15918770900638265761.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Jul 2019 18:45:13 +0000
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

The pull request you sent on Sun, 14 Jul 2019 12:19:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50ec18819cade37cccc914ffc71a8b0a2783c345

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

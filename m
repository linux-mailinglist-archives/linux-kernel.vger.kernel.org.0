Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2014D3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgA2XfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 18:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgA2XfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:35:07 -0500
Subject: Re: [GIT PULL] printk for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580340907;
        bh=w/GA0XpevFnHqKABigx6k3IqC4t9Mo+SckVsxo7uS5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qI9nXLAF7zVD6/2qgpy+RQKSB0B43RdIZEw5l7iUIOUMp6Nm7/F66ZxkPfPZHveLE
         0qjp9plK15wfm72reGroiQl30VHzpo1m5mAqCNKgznopRA7eBKkAvEw7uq08YW2YWs
         mhEkTb6KuqVjApQkGgS9VRL5mzb95szj5WWF4CiY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129130729.fhxnq2gcyqoum3i2@pathway.suse.cz>
References: <20200129130729.fhxnq2gcyqoum3i2@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129130729.fhxnq2gcyqoum3i2@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-5.6
X-PR-Tracked-Commit-Id: def97da136515cb289a14729292c193e0a93bc64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4fe2b4d87c9f2298ae6a641a7a64bc941d079d0
Message-Id: <158034090718.30341.12910392977931430763.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 23:35:07 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 14:07:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4fe2b4d87c9f2298ae6a641a7a64bc941d079d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

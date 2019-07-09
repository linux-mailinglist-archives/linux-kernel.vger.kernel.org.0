Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6502863C40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfGITzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 15:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbfGITzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:55:12 -0400
Subject: Re: [GIT PULL] printk for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562702111;
        bh=a8Y+FDrk3WHyug3q+HhNT4amRsnPYR+zp1JY3cd/s7E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pn2onlURKVnfNLLIsuGu23feEI2/Y88YUWWG33EUVPXxXNbsWH54fLuZEKmDPlIqj
         b9RRvfLj91ZQWQZeO9fK+uzsKXEIh2ud6YZ+3t87sFw18jsd35W4JVygWQ6P/sJR4T
         zwx1Y7HJEWcNcyFIbdqOUDD3EDXcp3vPVGuW7IAY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709132259.q23dt7t3cs3rbbof@pathway.suse.cz>
References: <20190709132259.q23dt7t3cs3rbbof@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709132259.q23dt7t3cs3rbbof@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-5.3
X-PR-Tracked-Commit-Id: 4ca96aa99f3e1e530f63559c0cc63ae186ecd677
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7011b7e1b702cc76f9e969b41d9a95969f2aecaa
Message-Id: <156270211166.21525.1763633205015753437.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 19:55:11 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 15:22:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7011b7e1b702cc76f9e969b41d9a95969f2aecaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

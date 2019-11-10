Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5DF6B81
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 22:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKJVAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 16:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfKJVAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:00:08 -0500
Subject: Re: [GIT pull] irq/urgent for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419608;
        bh=GxWkxqJKxhwYSTlXplTYkje4NasewnsAkIwKAqvqLKw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xm89T9SeDIHIvT6y39jQYSDOvZO3/Er4Dzp5Yoc2FYOcxHYpUbz/O40h8/0gvMztN
         87hB8rE7JwAf9U/xhIWhRs7L4B0lU4crcmG+2RXGZWc6FRg5SvtfrgI9ejWr97TjcX
         avEANEmMYiGzhU4ynUsN9eOL+d92wnfGUKcrl9R0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157338131324.14789.9839203234808482110.tglx@nanos.tec.linutronix.de>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
 <157338131324.14789.9839203234808482110.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157338131324.14789.9839203234808482110.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 0ed9ca25894ef673d0259e4bd312d5fa1b9a6591
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffba65ea247bb4193d4990324f5bcc76e8b5a7e7
Message-Id: <157341960829.30887.3918198088182883184.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:00:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 10:21:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffba65ea247bb4193d4990324f5bcc76e8b5a7e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

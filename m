Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9607199EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgCaTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgCaTPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:13 -0400
Subject: Re: [GIT PULL] x86/boot changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682112;
        bh=ipWldwekQACa3F4pZSmHxxZ38u1Uf0opsUEr9Ud9wvE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CV5wM0OqdvpQ2JweJlmptl0q9NWOuPA3xStYsHgDuJUjyrlUPTWm+pI2YcBA6tn5m
         ugoCZQKBVNpHobRT7PNZgCfjo8qgFd6eT5E8QyASHeb/iI0xrKJndIxxuYS5/+FF/Q
         056K52HUMXJSKZxwSh3dHQM4q5Zc2spGC3cvg0gg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331075305.GA57035@gmail.com>
References: <20200331075305.GA57035@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331075305.GA57035@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus
X-PR-Tracked-Commit-Id: c90beea22a2bece4b0bbb39789bf835504421594
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9589351ccf47a85a75180a430627c16bc28da929
Message-Id: <158568211250.28667.9170862913662280977.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:12 +0000
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

The pull request you sent on Tue, 31 Mar 2020 09:53:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9589351ccf47a85a75180a430627c16bc28da929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855791566A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfEFXkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfEFXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:12 -0400
Subject: Re: [GIT PULL] x86/entry change for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186012;
        bh=n0YhbUFwy7S7IRLYpGK1qNxLc2suDXG9ONYByK/A5Mw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GIu06huu7Eujz7aKxbwFUHcSb5jIsXWPjR3JFGN1rwsOxah9xn5KvmLlcMDHAtcaS
         lG2kvnj06Ff/C9vs1Gst+vSyTOVGeNDt8b25+k7l6u4R+CG2Np4nlgnukv3SvNqbja
         wpsTsd31A4wUMqslt60mmYQ83MIfI43YUEjhEKd8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506101857.GA39509@gmail.com>
References: <20190506101857.GA39509@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506101857.GA39509@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus
X-PR-Tracked-Commit-Id: b5b447b6b4e899e0978b95cb42d272978f8c7b4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53f8b081c184328b82c8a7b5e70b8243b3cea8bd
Message-Id: <155718601197.9113.3150549612216930746.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:11 +0000
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

The pull request you sent on Mon, 6 May 2019 12:18:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53f8b081c184328b82c8a7b5e70b8243b3cea8bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

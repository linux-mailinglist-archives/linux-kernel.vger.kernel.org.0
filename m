Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78014C1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 22:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgA1VPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 16:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgA1VPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:07 -0500
Subject: Re: [GIT PULL] x86/core changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246107;
        bh=eqPSHSfAOiDzeW+p5ldZgVJDPVscM/2MxhvNlVEh678=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SWRRUtiAZPyOH/ODL1b+IPM070s5rkfm1Y7oI7AevigQHOL94bN1zFFw973mnTK+f
         6u6jtXwxeHCcKBiDL/EZn7R2TWgNdOH9CpZQGK6qet5AE4l1rhPRXXXgE2tR7Twfft
         dzenOWRzBvrVT+AJnGjAix446mExklbIGp00ak6g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128174659.GA92880@gmail.com>
References: <20200128174659.GA92880@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128174659.GA92880@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-for-linus
X-PR-Tracked-Commit-Id: 248ed51048c40d36728e70914e38bffd7821da57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6170f0afbe23ad82b4a1195168949c31e3a2527
Message-Id: <158024610742.20407.2591069095709342860.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:07 +0000
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

The pull request you sent on Tue, 28 Jan 2020 18:46:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6170f0afbe23ad82b4a1195168949c31e3a2527

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

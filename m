Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE314C1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 22:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgA1VPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 16:15:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgA1VPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:15:08 -0500
Subject: Re: [GIT PULL] x86/cpu changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580246107;
        bh=NoxKgX6uFTBqKu6m/0SI7cR3OZIsH+VpIKsiMPqQgAc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f0hvCjx94UVC0yjAa15eKPrgwmb23BIMx23hKA/KmRHq0OmVcWIoR9PocgPEvluZF
         xCO7fhMdGFqmHl7vCfQO6INSWOLbIc8GTTyzsbeiLp1+KUPm8+yZPtFfB1U0iAG5r3
         FG+NcR9/BqruagK0+OJNmOc/cRmDXRwT5gSDsXW0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200128175751.GA35649@gmail.com>
References: <20200128175751.GA35649@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200128175751.GA35649@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus
X-PR-Tracked-Commit-Id: 283bab9809786cf41798512f5c1e97f4b679ba96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0275ae758f8ce72306da200b195d1e1d66d0a8d
Message-Id: <158024610792.20407.3679690072145683951.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 21:15:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Jan 2020 18:57:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0275ae758f8ce72306da200b195d1e1d66d0a8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

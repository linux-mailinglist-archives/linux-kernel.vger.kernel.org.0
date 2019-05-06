Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161B61566B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfEFXkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfEFXkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:07 -0400
Subject: Re: [GIT PULL] IRQ changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186007;
        bh=f5WbGPGDuUCMlEsdG+QhuejlBo8vSNaCYPzVs5/1yzI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tJmW0ZJn2GLWB1AU1yExot1zgSR4Ybxjnlb8Hr8EqRz6IdKAtbwWaNPlgCFur55CO
         ABeU1JI/maJ8RX6PDEqXrBVzurWKcUdEx7Aks++Saaco0XejeFqz7gwYBURGLM9zcA
         2vnSmYbJrDbnapdaEnVWRQCl2Uk2nhgklLE7mnRI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506083623.GA127408@gmail.com>
References: <20190506083623.GA127408@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506083623.GA127408@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus
X-PR-Tracked-Commit-Id: 471ba0e686cb13752bc1ff3216c54b69a2d250ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f1835dffa949f560dfa3ed63c0bfc10944b461c
Message-Id: <155718600719.9113.7365849118580619712.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:36:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f1835dffa949f560dfa3ed63c0bfc10944b461c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

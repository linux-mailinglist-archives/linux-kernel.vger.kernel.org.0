Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672EC1988DC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 02:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgCaAZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 20:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgCaAZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:25:11 -0400
Subject: Re: [GIT PULL] core/objtool changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585614310;
        bh=hZ8FQxqNkPW8MjSDdK4JyJsSr7AZb4Cuz1zjWf/8myM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dGL06506qGrmfUmReZN0/EsN1qW2BE8JAh6cI8RrdTWOxY5lfIEaQRh2fJhAe1RrJ
         8iDC2RL4xBsqEzVnzr3EpcHR4SITmvgDtYj1B/8VvGCVgbkQQpPkR/MPmHrYvgABt+
         8fC/6KmiGIVF6EvnEJyl1gYkAXS3OEKl77um0low=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330123136.GA3021@gmail.com>
References: <20200330123136.GA3021@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330123136.GA3021@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-objtool-for-linus
X-PR-Tracked-Commit-Id: 350994bf95414d6da67a72f27d7ac3832ce3725d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d937a6dfc9428f470c3ce4d459c390944ddef538
Message-Id: <158561431076.380.13810662072593063982.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 00:25:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 14:31:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d937a6dfc9428f470c3ce4d459c390944ddef538

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

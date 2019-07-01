Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A033C15666
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfEFXk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727193AbfEFXkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:14 -0400
Subject: Re: [GIT PULL] x86/timers updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186013;
        bh=zjJRTHigObvl2MMT7+a2ITIdkD6IMTX19PebXx8AdX8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XCLMnyLA6BZvSU3mNmkaGJvESjMXO67XnmQAjWfsv1bUieLSevFau/Vc8qzbd6+3v
         pBI/UAnA8TH1tu9ihhzAGX0Zr2wIX0m8re2azkqG2d/4J9bgQjlDofe4mHDTlWD3W7
         28zvXsTRCO2o08C7LOD7EJMIS/O80SoLr6/mMPFw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506105212.GA45768@gmail.com>
References: <20190506105212.GA45768@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506105212.GA45768@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-timers-for-linus
X-PR-Tracked-Commit-Id: 81423c37415fe45057d64196ae0ce8e17a9c7148
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db10ad041b318a07985363e243742a07f4b0f44b
Message-Id: <155718601375.9113.4231024247485211002.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:13 +0000
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

The pull request you sent on Mon, 6 May 2019 12:52:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db10ad041b318a07985363e243742a07f4b0f44b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

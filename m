Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60BB1419C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 22:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgARVFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 16:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbgARVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:06 -0500
Subject: Re: [GIT PULL] RAS fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381505;
        bh=suayAzrPg78u7bZXSqxgsPsadMA15kKUsK5+By5UF4w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Amhyt/TWci5TeZzx/AmWy+XqYK2ApH3C209H0A7+Pe5+31p5Q6FcrrArVDLAXOwNo
         9vUA8DVWbj2xRH8X2kL7PIxQJpiWagORAWzAz3JUs3+GVr2RapqBdb4/zIZodxjdTB
         rnSTRyBqloLoDkWG7S4UbSbQdU4E0HESyrfCb/TY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118182949.GA61525@gmail.com>
References: <20200118182949.GA61525@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118182949.GA61525@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 ras-urgent-for-linus
X-PR-Tracked-Commit-Id: 978370956d2046b19313659ce65ed12d5b996626
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a186c112c7a44fefdf9e4208f2b38c31b53f3c1d
Message-Id: <157938150590.20598.27326523745307843.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:05 +0000
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

The pull request you sent on Sat, 18 Jan 2020 19:29:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a186c112c7a44fefdf9e4208f2b38c31b53f3c1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

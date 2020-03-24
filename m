Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1119174A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCXRPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgCXRPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:15:08 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585070108;
        bh=Ptf2h+wtQSYQ+KyO+iq5FjGWavjKdwW24pR9LTKnnMs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f6Yq5ExFf4XC+wDmuGLD7WCdsxoHgFaNlyPgPc2ZXr2oY/9Hbv6xLH8vWTlCCZVTc
         7vt1OyDxI25OSSDBEngDAsTW2Goz3nqmyicpECPBQaJZ9SKWgMia/GMJ7RqX3xyteP
         IOuPFai593AAurjBCq+0QQBa9kbi7l0zPpa+9Cc4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200324091952.GA66321@gmail.com>
References: <20200324091952.GA66321@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200324091952.GA66321@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 564200ed8e71d91327d337e46bc778cee02da866
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76ccd234269bd05debdbc12c96eafe62dd9a6180
Message-Id: <158507010827.16590.2535992708509912561.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Mar 2020 17:15:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Mar 2020 10:19:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76ccd234269bd05debdbc12c96eafe62dd9a6180

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

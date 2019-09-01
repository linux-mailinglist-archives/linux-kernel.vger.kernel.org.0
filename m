Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88A2A4B29
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfIASaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 14:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfIASaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 14:30:07 -0400
Subject: Re: [GIT pull] perf/urgent for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567362607;
        bh=K6ckoRM8rI1NTQ3wG9Y78rLE+T8bD5l+2X0HxIt+bmU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dWqSXUi8y9xFd1wFRgGIqKj2KbDr0/V2H5nyiNmhy4/b5WPUaEwl6w1FL5glElgPk
         xreh+Lmn4OoFqNaF3FcpZziCX6KvC7gjQ3qIuSneNqxK48WaITCWTN0aRozJQo1uhN
         I5Mt2HY+x9ozLgSWyqzdbYee12Jnu7Nb35Q5tz/w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156731805398.16551.16721065723173566021.tglx@nanos.tec.linutronix.de>
References: <156731805398.16551.16721065723173566021.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156731805398.16551.16721065723173566021.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 0f4cd769c410e2285a4e9873a684d90423f03090
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fb181cba01088924a68441753843e5acfd012ff
Message-Id: <156736260751.26191.12652885795876369150.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Sep 2019 18:30:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Sep 2019 06:07:33 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fb181cba01088924a68441753843e5acfd012ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

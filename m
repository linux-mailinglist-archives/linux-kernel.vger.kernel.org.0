Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7610BBFB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 01:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfIZXA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 19:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfIZXA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:00:26 -0400
Subject: Re: [GIT PULL] timer fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569538826;
        bh=Te0AMbnp7/yHOV7UlPag9LsO5tZOedu52hU/6h1xNb8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XDKabWdzWBfVXwLrp36Euwdui+vC7obgx+PAlJWKJqt8tt5YBi/GID0Q76LlJzmC9
         P7OagyJndnpcRzxMZqC1xITfQlSzPXxf3N6EoiH4RdqvcVw+iXocf1hkrQvGloCa21
         JNa6R8KZ2qdoA1rZM0MP9AMTOncLyVxTV0JavHts=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926201825.GA45571@gmail.com>
References: <20190926201825.GA45571@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926201825.GA45571@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: e430d802d6a3aaf61bd3ed03d9404888a29b9bf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da05b5ea12c1e50b2988a63470d6b69434796f8b
Message-Id: <156953882636.9540.9070232488717065924.pr-tracker-bot@kernel.org>
Date:   Thu, 26 Sep 2019 23:00:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 22:18:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da05b5ea12c1e50b2988a63470d6b69434796f8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

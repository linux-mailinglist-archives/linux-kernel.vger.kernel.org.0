Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5AFF633
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 01:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKQAfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 19:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfKQAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 19:35:06 -0500
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573950905;
        bh=n1ne2bx6B9Uogy6WVvkHV8yLTT7+/NmlZGunvMj7cic=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LdsjWm/SFL2CB3S1eLRZPKSAewqm9BkkJU9PcmGUJ1H54EHGnGjiadSMqntiZN5j7
         NryYlU6v1KUCzfgFMmZU2PHfvOOXMuGUZ3cocynRm2JABLq/EWKuiTi9/0WIZ2U340
         Ui4r231JNc5+h5Yt013BGYfeGydL0jp2HvM61IfQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191116213333.GA84250@gmail.com>
References: <20191116213333.GA84250@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191116213333.GA84250@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: d00dbd29814236ad128ff9517e8f7af6b6ef4ba0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ffaf037e776fd5095561c27d879b4484549f7e4
Message-Id: <157395090558.15664.9653672687893480188.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Nov 2019 00:35:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Nov 2019 22:33:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ffaf037e776fd5095561c27d879b4484549f7e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

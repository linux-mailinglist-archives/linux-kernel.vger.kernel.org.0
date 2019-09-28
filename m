Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469FBC122B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfI1UuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 16:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfI1UuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 16:50:24 -0400
Subject: Re: [GIT PULL] x86 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569703824;
        bh=nw5GhvxlEtLMq+EWh51QMDj4GzNpVDN6PYxoNmVNI/8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ceDXd7nlmoIyHjL7kzbswKDU/ILr8ZI1Z1WY+jdWSWYaAGuTpgLq8oLtpiiL6N3Je
         uvCr6ijBlC+vAsFXXmzpkqW/HlenmBBt9BzXj0jkgD38gt1SU/vhSK5FxQXmBMyZi9
         dzSMLrGAEJ/TiwtKkJgsEGnlWEt4k/8iTl38sVVo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190928124243.GA2563@gmail.com>
References: <20190928124243.GA2563@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190928124243.GA2563@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: ca14c996afe7228ff9b480cf225211cc17212688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f19e00ee84be14e840386cb4f3c0bda5b9cfb5ab
Message-Id: <156970382436.9125.3094381266345963947.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Sep 2019 20:50:24 +0000
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

The pull request you sent on Sat, 28 Sep 2019 14:42:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f19e00ee84be14e840386cb4f3c0bda5b9cfb5ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

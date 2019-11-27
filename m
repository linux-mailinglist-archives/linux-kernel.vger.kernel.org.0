Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0810A7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 02:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfK0Baf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 20:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbfK0BaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:30:10 -0500
Subject: Re: [GIT PULL] core/stacktrace cleanup for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574818210;
        bh=NQWRW1on1BMVz4x8ri6AMbA2LWSAwewx5NvKAkzl0xE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MCxeQ6EMqFm/lcL/XG6HlRgTuQCs340TbEl/nwCdA1onUC2K01XH9vyESKV1D9ZoB
         vWH55o6dNE/zIsg9ADSsjQZOXz9ErYSvo6N0G2fU7knfP/XQHF45sijcc9qd7diBDZ
         4TaPm60pqWIh6BZGV6UjEEmhFMiiIgRZJg25andM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125110019.GA117271@gmail.com>
References: <20191125110019.GA117271@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125110019.GA117271@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-stacktrace-for-linus
X-PR-Tracked-Commit-Id: 4b48512c2e9c63b62d7da23563cdb224b4d61d72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f6128139092286cf10e32bef8ccf56a004812d2
Message-Id: <157481821055.26353.11930588878351360896.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 01:30:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 12:00:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-stacktrace-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f6128139092286cf10e32bef8ccf56a004812d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84611419C3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 22:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgARVFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 16:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgARVFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:05:05 -0500
Subject: Re: [GIT PULL] locking fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579381505;
        bh=Ma/t+1Qggvi7VT6wNRlHHh6NSuQrpCPT3zMovtkN2ac=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dozm4bLjCl4aOb5Vhvcn8OBjIfI7DDRMjtURys6vIa1ikkS22DRYnfNuto2hoW9DS
         iNkjEAqAIKcavGlRWwuRLI/rYfsfe3Aeq8iVZ1buqc0Ce7vKbh9n2p0anT5jxH7xp4
         UU2WB87+IA13oVz3ynTwnJb2255LxFUecEXLov7M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200118175309.GA19218@gmail.com>
References: <20200118175309.GA19218@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200118175309.GA19218@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: 39e7234f00bc93613c086ae42d852d5f4147120a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 124b5547ec1e1c935c5cc3dfe9f3c04669ecb5e4
Message-Id: <157938150506.20598.12391834119270297686.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 21:05:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 18:53:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/124b5547ec1e1c935c5cc3dfe9f3c04669ecb5e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

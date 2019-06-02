Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CF432489
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfFBSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 14:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfFBSPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 14:15:16 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559499316;
        bh=LhFAH5+v8SOykJcLeDWBvWHGBPO5D9ujKg3irRywv5g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NvkePuCPOA82MmKMxQqhv8523RnhLWtFjg+YuxgGWfBPlCUCfWHnkX5MvWBRQEhAM
         PMMFVY4rfEu3DXvaXWYS8g5XNsyEfNXBtOVD0EIAAEnez1Qe6oSlS8zhnLZqcjdtq6
         1YUKoW6KuoEakamyI/b33nIRmuwCHqZlZ0DADLpM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190602174442.GA34993@gmail.com>
References: <20190602174442.GA34993@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190602174442.GA34993@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 2ac44ab608705948564791ce1d15d43ba81a1e38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bd1d5edd0160b615ab8748cf94dabcab1fb01cb
Message-Id: <155949931615.4617.2248347050051536322.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 18:15:16 +0000
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

The pull request you sent on Sun, 2 Jun 2019 19:44:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bd1d5edd0160b615ab8748cf94dabcab1fb01cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

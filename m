Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9545B4467
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 01:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfIPXFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 19:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389647AbfIPXFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:05:03 -0400
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568675102;
        bh=j4UYb6NySFq+5N/nNvQgEy+fXpUrumCUy6dkwPm+f78=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DqxW4EWmhqj21yFjUxUnJQahC6k4MdLRzwmKSBckNOsLjtnyRALaeid2nbBtGFoj/
         Up9kcVsOHjoKeyewkOlkqWPh6gBuTgcDVHPJaaj1wCsdLGTbI5xxn7YclgqiJt+HBV
         xhjlwYcXicfK36uejrtDmN1rM5hwjPdK8865mnG8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916182932.GA8097@ls3530.fritz.box>
References: <20190916182932.GA8097@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916182932.GA8097@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.4-1
X-PR-Tracked-Commit-Id: fcc16a9e24ba6a2bb9f3af43d892eeec2a435d18
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0a16fe934383ecdb605ab9312d700fb9099f75e
Message-Id: <156867510260.30760.7539036412169842166.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 23:05:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>,
        Jeroen Roovers <jer@gentoo.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 20:29:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0a16fe934383ecdb605ab9312d700fb9099f75e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

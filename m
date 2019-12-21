Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69391289AE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLUOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 09:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfLUOzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:55:03 -0500
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576940102;
        bh=jHa7TApmdG6ObaG+VsBoYVH6ssS/P+jWiCh/4Qyrq0s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b5H4mJG5ErGsSjYlflLJjv2ul/DWVMeRHPm7kBgD+rN7vyaeYJe4m6B9Vc57Gr/5E
         lwdgeUxurkXPO682wqFJClGbacwsLP8VEz/zRhmAt5FH6diH1lkvX+GpM7iIeE3UYf
         Df8mPw6y7xy+Ko9aPC59/cyiKPS9nWyTXKhbF5oI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221143539.GA29263@ls3530.fritz.box>
References: <20191221143539.GA29263@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221143539.GA29263@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.5-2
X-PR-Tracked-Commit-Id: 75cf9797006a3a9f29a3a25c1febd6842a4a9eb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6210469417fd967ec72dea56723593beefeecafb
Message-Id: <157694010258.20544.2019681266417561363.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 14:55:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 15:35:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6210469417fd967ec72dea56723593beefeecafb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

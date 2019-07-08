Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9858629AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbfGHTao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404532AbfGHTaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:07 -0400
Subject: Re: [GIT pull] core/rslib for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614206;
        bh=Ps7CZ/ksNfe5LYkYWHU88lDOueLYAIm3z3gPoqk1Tvc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HGsZebLs12+aV6N106W1KqG+bdSsRfxP7Ysdakkxsvn2asoJ522eph3C2ohA7BMg6
         2BXXQFNYUxjMd9TKxyaUnaVblZgDaa0woJWF67jThPIeFYpQ1oriwm7MuAk9y/FfbC
         gzdaFN2UU/w6NKNAbFMPha+nbgGfwDZGy3iy8fiI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673794.14831.15719816342504721108.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673794.14831.15719816342504721108.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673794.14831.15719816342504721108.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-rslib-for-linus
X-PR-Tracked-Commit-Id: ede7c247abfaeef62484cfff320b072ec2b1dca0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 568521d058aaab18f01ac39d7a6ef00b75e5cc79
Message-Id: <156261420637.31351.1514329168101450859.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rslib-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/568521d058aaab18f01ac39d7a6ef00b75e5cc79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

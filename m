Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93FB45A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 04:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392050AbfIQCzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 22:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392035AbfIQCzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:55:18 -0400
Subject: Re: [GIT PULL] x86/asm changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568688917;
        bh=CuyIBSUaPXShOVNfyVGNJA9eJigohPCPK6xNze7MWNE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DDV3Xn5KHO5l95VmihZdeW/HuDgr2spivvZF+7lkKArSAPNRn2lBG/WNILrIuS9Z/
         n7anj3KViE3MLx6ns1T+yTpnGJpI/86t9GsNAhy1c4Owq4bdj0xoRCE63e6TNT/p80
         l501ffcIfobfchZ4ZBUJ93+t/14vNAX1MkLp588Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916123454.GA24902@gmail.com>
References: <20190916123454.GA24902@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916123454.GA24902@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus
X-PR-Tracked-Commit-Id: e86c2c8b9380440bbe761b8e2f63ab6b04a45ac2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df4c0b18f2a2798f1e3ae9dcf58c024bb33e4202
Message-Id: <156868891779.5285.17417213358221631023.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 02:55:17 +0000
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

The pull request you sent on Mon, 16 Sep 2019 14:34:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df4c0b18f2a2798f1e3ae9dcf58c024bb33e4202

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

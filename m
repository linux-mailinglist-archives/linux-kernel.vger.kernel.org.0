Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEBAB56C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfIQUP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfIQUPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:22 -0400
Subject: Re: [GIT pull] x86/apic for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751322;
        bh=0tE34KKBPtKP3kiSobi70lyt9t4S653ALxgWdKscfh0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=daDadkt1AxQI8dAG9pPj5Ms5fSHoSx+DYb5frx0sFEb4hhDiIBa8uFe/mt0go7wFr
         SpvV2D62Pjh4dnWr+Hwbti3AoVfaZLldDgbu2TQNhorUm7XbjcAoJiiflbon8Sat2w
         1JOSEDkABxZN/zl1Nq0TJIVjAuELRT1Bx1eZsHb8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062018.3407.17075284512789171310.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062018.3407.17075284512789171310.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062018.3407.17075284512789171310.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus
X-PR-Tracked-Commit-Id: 743dac494d61d991967ebcfab92e4f80dc7583b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5f12fdb8bd873aa3ffdb79512e6bdac92b257b0
Message-Id: <156875132209.8483.10255150833473379498.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5f12fdb8bd873aa3ffdb79512e6bdac92b257b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

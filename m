Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EADFE6244
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 12:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfJ0LaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 07:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfJ0LaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 07:30:06 -0400
Subject: Re: [GIT pull] x86/urgent for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572175806;
        bh=CwEgVbMqeJJvMCXdJlOSTWTdxzVhAsinxKrv1nSkWO8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AExnCNtmiLd1XCocbexwGsM5/qi4uxm7njgmz1b1HMNnOE1CPBcGov35JIxv8eUEO
         Rn7YrsRUDz2jz1Gvw3qxHJ8CJUj7XxIgxQEXzFOtkzMe/x3jprWsx5XMBVYyPEnRxn
         gGswPzKxAaggObHjAgI8wcN80YORJmrdfw6pS9LA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157215878694.13117.10331983631021160763.tglx@nanos.tec.linutronix.de>
References: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
 <157215878694.13117.10331983631021160763.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157215878694.13117.10331983631021160763.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 6fee2a0be0ecae939d4b6cd8297d88b5cbb61654
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 153a971ff578e9c8c5eadc9463c1d73a6adc8693
Message-Id: <157217580617.15608.11417016662517864058.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Oct 2019 11:30:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Oct 2019 06:46:26 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/153a971ff578e9c8c5eadc9463c1d73a6adc8693

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

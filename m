Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FA629A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404615AbfGHTaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404587AbfGHTaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:11 -0400
Subject: Re: [GIT pull] x86/cpu for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614210;
        bh=3Osj4wcSvnCPooNSDqgm8a9zaqD0EQHz1nQtByqs3xE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DfxIvZQ4AaQA7r6Z8jheKVLaLtVAXj3YnqbJIlE04qEmFt89ytYoKx4aT/Dlmw4m3
         317K8rEeKPQvDQRyNhSGPCm6R29S7FNYC6AkfwvgteIXkaCHywgT/QuwUufrUMiBVu
         09zoQ8pBSHaexOqZ2JpjkVPD8QALdi+VZrsxsWHU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673796.14831.10023086664920231810.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673796.14831.10023086664920231810.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673796.14831.10023086664920231810.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus
X-PR-Tracked-Commit-Id: 049331f277fef1c3f2527c2c9afa1d285e9a1247
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13324c42c1401ad838208ee1e98f3821fce1cd86
Message-Id: <156261421064.31351.259068439377610433.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13324c42c1401ad838208ee1e98f3821fce1cd86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

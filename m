Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075A2E6241
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 12:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfJ0LaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 07:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfJ0LaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 07:30:06 -0400
Subject: Re: [GIT pull] timers/urgent for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572175805;
        bh=9OQvjpcFJSqDgvFMQO7q8EpU09L/YCuIVi5sTZBtek0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QPp55C1cv6G355X49Xrzpmiz6MWl+doonrNexXQk2YMSB5Q6ngOUyPLaFyvnUX5U1
         YagML5/F2xL+xdPxhNgdmWfE3cBwqrtnIuRB4ttWg/KO1QnNfIricWlWBACMSxtuO5
         xQGG79R5iQR+4T1Y1bEoBxQi2ag5N9kzIribZdrI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157215878694.13117.5360990944289610665.tglx@nanos.tec.linutronix.de>
References: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
 <157215878694.13117.5360990944289610665.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157215878694.13117.5360990944289610665.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 7f2cbcbcafbca5360efbd175b3320852b8f7c637
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b776b54bca8c6f3b3a37f89bd80863b688bd8dd
Message-Id: <157217580553.15608.17509045792703117774.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Oct 2019 11:30:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Oct 2019 06:46:26 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b776b54bca8c6f3b3a37f89bd80863b688bd8dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

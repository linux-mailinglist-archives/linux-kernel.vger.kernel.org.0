Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205085AE00
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2019 05:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfF3DaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 23:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfF3DaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 23:30:05 -0400
Subject: Re: [GIT pull] smp fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561865404;
        bh=4ImvwuyQPRr4wMbdgWXkDuVVIaF1a8C7nCE5+dHSiSI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SlxgKmAC39pnt8/UHY6DT8CYWfgQt8MNRvVQsswy0Je19Lgzw77MpRHuAtubDzF+t
         m1nZ32fsLpw/6C15CbZMWIvMmWvl1nA87TaRnQ69t+F4W2VYcfq6txCa4ussMUayOl
         q4FPIz8MFq8y5M4fYD8ihDbs7x5KYu0v//BoRM10=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.1906291709410.1802@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906291709410.1802@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.1906291709410.1802@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-urgent-for-linus
X-PR-Tracked-Commit-Id: 33d4a5a7a5b4d02915d765064b2319e90a11cbde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c15f41e8743df676f6cb0615e74e8ba30994d6a
Message-Id: <156186540484.13728.16125180869133752827.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jun 2019 03:30:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x6@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jun 2019 17:13:04 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c15f41e8743df676f6cb0615e74e8ba30994d6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

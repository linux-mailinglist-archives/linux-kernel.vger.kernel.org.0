Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2943847616
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfFPRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 13:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfFPRfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:35:06 -0400
Subject: Re: [GIT pull] timer fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560706505;
        bh=TAuycCk8vkPeA6bgYN0WxZn2rzfjTZS+siQOmXz0YUA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xYn8HoX4TwL4SxRgA/SNsZmbs8X/DCQr9fEPMsXJKwRsyFA4HBmdnVGMzffWyt/zs
         xsUcF122Xj3G2n6iW+ZgcQhdrpr5Vw08zEGkyDJ+bfxNs1n77IOX55QdlRZYvAjxGQ
         oD7N+bJ6P6EuPv87sxX1MQzFiObyKmt/1yftTiGc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156068459205.30217.17659593879245974125.tglx@nanos.tec.linutronix.de>
References: <156068459205.30217.15980952927216488865.tglx@nanos.tec.linutronix.de>
 <156068459205.30217.17659593879245974125.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156068459205.30217.17659593879245974125.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: e3ff9c3678b4d80e22d2557b68726174578eaf52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efba92d58fa37d714d665deddb5cc6458b39bb88
Message-Id: <156070650561.13049.15539313572516926150.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jun 2019 17:35:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jun 2019 11:29:52 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efba92d58fa37d714d665deddb5cc6458b39bb88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

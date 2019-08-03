Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425FD807B7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfHCSZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 14:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbfHCSZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 14:25:12 -0400
Subject: Re: [GIT pull] irq/urgent for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564856711;
        bh=eCRlFWtTIxDMHNHNWUEJA8iqLsGlgfnSRo+EM2PmLLE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DkvTO3FzPDJgLEHiTcE5vL6KPmdmLkJkLzB6UClVyU/mErmoO+1oMTbYBy9wnVq4L
         79XAi9OBc9RT04QaNb6sz0LDHcxnZQ3BsaqRErknzKRKSJ4fS98og7YagGyQl6eLIv
         3ZI5zTtywRoFyuILtfXRF2ua7Kl7Asz4antFc4F0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
References: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156485021326.28964.12573754498454150320.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: a5dbba8f443e2046c63e5dd2907f562c1179169f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af42e7450f4b174a0a3f7611791ba73109997171
Message-Id: <156485671114.25774.12106528399208819183.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Aug 2019 18:25:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 03 Aug 2019 16:36:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af42e7450f4b174a0a3f7611791ba73109997171

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

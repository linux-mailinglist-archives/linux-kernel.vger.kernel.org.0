Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3514ADA4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 02:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgA1BfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 20:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgA1BfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:35:08 -0500
Subject: Re: [GIT pull] irq/core for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580175307;
        bh=QudoQNuGwseCEQZJrFZnJgG/QlZ16kkcVre5voiSqAg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nEaUHoWJ+21k41Rk6mA6Ts8xUb8iA1dTtytLi8RlNwrjYAqJVJXYrH3tCKzsvJgPd
         KKf6DuJ0oUfPGoiW9+IrPdC2BpFa+KZVz+6/r3dRnQeBAgG4FldmYxOAqY70u11M9f
         8QMKRjJ7eXtV0w6CKUgR/ncKfHhrmGWCrWePvzdo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158016896589.31887.14545084921211172429.tglx@nanos.tec.linutronix.de>
References: <158016896586.31887.7695979159638645055.tglx@nanos.tec.linutronix.de>
 <158016896589.31887.14545084921211172429.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158016896589.31887.14545084921211172429.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-01-28
X-PR-Tracked-Commit-Id: 43ee74487bd2842cb4d37b5c62f074fbed2366b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d3b44a61a9cfd268fc071ea1b1c5dfea7ed133d
Message-Id: <158017530781.6677.8000989710436332928.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Jan 2020 01:35:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 23:49:25 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-01-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d3b44a61a9cfd268fc071ea1b1c5dfea7ed133d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

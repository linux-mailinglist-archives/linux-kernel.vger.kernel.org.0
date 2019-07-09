Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36AD63C3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGITzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 15:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfGITzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:55:11 -0400
Subject: Re: [GIT pull] x86/kdump for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562702110;
        bh=cV8a3PZ/RBujwxONeuwmtNhiufeOOMytfXlhF3l3QII=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0nyFMJROl/sklZqG8GWP6h3YMdLLb7xdEjTKE+JVVAvasbz2H0yZjNrKy6bdFaY9j
         Fyt00CFIJr8rTVJWJsu1OL1OizSz3eKCgi5f3zDhHTGu8DOyg8bMGKeTJ7Q9YvBNeJ
         C+WdFWQU5pJX4wOB0r8MPGrQwjguUY8qrl/dqRCw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156267559466.6547.2199213187743143427.tglx@nanos.tec.linutronix.de>
References: <156267559466.6547.5675975755906539836.tglx@nanos.tec.linutronix.de>
 <156267559466.6547.2199213187743143427.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156267559466.6547.2199213187743143427.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus
X-PR-Tracked-Commit-Id: 4eb5fec31e613105668a1472d5876f3d0558e5d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 565eb5f8c5d379b6a6a3134c76b2fcfecdd007d3
Message-Id: <156270211088.21525.4155749807081661623.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 19:55:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 09 Jul 2019 12:33:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/565eb5f8c5d379b6a6a3134c76b2fcfecdd007d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

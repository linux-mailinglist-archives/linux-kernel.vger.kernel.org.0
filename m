Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C551629AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404635AbfGHTaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404596AbfGHTaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:12 -0400
Subject: Re: [GIT pull] x86/entry for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614211;
        bh=TMVHTU0X3UmuGxz2cBL2OUt6ARiKnANTtm0BoDJvDKc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2tbJ79AHQjErTh3CFANI8O2jcq6ZGXlLtFZJeUJJfjVT7Jy5M6FfMkUWYrSu26Ktd
         GJUuBeCATSrp55yUOVWkblaQO3eHWDK2flGVReKlYpjFvyeVZLdf4QkJ+/h2iMYZJM
         /MEEUKbun4I6MGQBFLGwzVa34UmyJysipFTXVUUI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673796.14831.465435984414885448.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673796.14831.465435984414885448.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673796.14831.465435984414885448.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus
X-PR-Tracked-Commit-Id: 7f0a5e0755832301e7b010eab46fb715c483ba60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d37dde70655be73575d011be1bffaf0e3b16ea9
Message-Id: <156261421158.31351.18010022085674357183.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d37dde70655be73575d011be1bffaf0e3b16ea9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

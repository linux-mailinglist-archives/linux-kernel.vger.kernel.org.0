Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5A185FC4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 21:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgCOUZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 16:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbgCOUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:09 -0400
Subject: Re: [GIT pull] x86/urgent for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303909;
        bh=/3B4MbMm7x1sBdJFz+Ubx6i5gCc4klhqnXVC5DsWWCw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QVrAlp+5lIMoqCKOk8GMa7Uh1At3zVJjXIZHpVgpcoF/vEbC9FTH1QqKSRvZ9hy0k
         Z7dlbUeHW0jsfDq3KIZZvkjj2MSSmOM/Z13HcyRwF/nuus//TezBCcTIieC4MRLJT3
         l+FYHSDCu9yhKAXPP9dhuhwfwjLli4VyuRmIAsBA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158428527864.14940.16973165028602818491.tglx@nanos.tec.linutronix.de>
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
 <158428527864.14940.16973165028602818491.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158428527864.14940.16973165028602818491.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-03-15
X-PR-Tracked-Commit-Id: 469ff207b4c4033540b50bc59587dc915faa1367
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec181b7f30bdae2fbbba1c0dd76aeaad89c7963e
Message-Id: <158430390927.13594.3497135957065114259.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 15:14:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-03-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec181b7f30bdae2fbbba1c0dd76aeaad89c7963e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

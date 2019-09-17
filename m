Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2ADB56C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfIQUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 16:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfIQUPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:21 -0400
Subject: Re: [GIT pull] irq/core for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751320;
        bh=Iv9wR4GWwsGpOOON17Vvwi/Xq75+BH7KrUeuehU9KIU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zrosxcU2CtgiKp3nYifD3q/GtD9fTZkEgzwrXl8YfXbtHJ7+z6AlbxC5V3oqMz2ZV
         dtSYJNXD+552sCv/HSOMyKah/iI9DQVtkqBRx+Su9JQT0v+ZsbD/QVfqSZIq2JR+ss
         7ASXDYAmQm3EVCngP3Asg79jrfI16dfsz3mJXU18=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus
X-PR-Tracked-Commit-Id: 9cc5b7fba57919a7d96f89ce79ba99d1dd1af965
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a572ba63298d04e2c5178e2abd82d6bd6e5677e7
Message-Id: <156875132091.8483.8364427918888756703.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a572ba63298d04e2c5178e2abd82d6bd6e5677e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

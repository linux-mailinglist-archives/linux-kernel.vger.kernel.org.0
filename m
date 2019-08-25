Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8F9C530
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 19:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfHYRkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfHYRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:40:07 -0400
Subject: Re: [GIT pull] irq/urgent for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754806;
        bh=ffn9aHQ6QoTdw3EIIVFi13LFashwJerVkbL7wOWeVVE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uLvzBP8PKNHvVtcm0RHqqENv7GdSvenMKBr0V/KA0dqW11uaSYmIycdfy+3Hyh/js
         E0XPao+P+UqRzLrWe1ePgf+NZ9lhiKKLSTJnpmSjSeMsrsxGu1vgoF0BVcI5ycHfq3
         vT6Gxil7GpG4LITL/dmAXpMC3LQzdK+GAhUTnBp8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: d0ff14fdc987303aeeb7de6f1bd72c3749ae2a9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44c471e43698d966d2bf291a9631f7d22a861bbd
Message-Id: <156675480680.29384.2836958416699249231.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 17:40:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 09:43:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44c471e43698d966d2bf291a9631f7d22a861bbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

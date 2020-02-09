Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0AE156C6F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 21:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgBIUka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 15:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgBIUk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:40:29 -0500
Subject: Re: [GIT pull] interrupt fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581280828;
        bh=8/jg/cwuXCSE0sHDqCAtT54ow1FjbsH+4NJWV4mw+Bw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qLu0q3/9NXDAQmP+C/7RrF5CPbHKEDAaQxCMsahRTTTkh8eQD1JINiQkvKfHyqH5i
         wcWOm1QlEPtZZbYP4upVJRJjK+lOLKUtDVB6miaveoWUIPPVMx97YhyThoU+tYkZNh
         oU7db+YaKea97Ew7jRwU4mmgZSV7N9bPmgMPIdwQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158125695732.26104.12129452415222798177.tglx@nanos.tec.linutronix.de>
References: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
 <158125695732.26104.12129452415222798177.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158125695732.26104.12129452415222798177.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-02-09
X-PR-Tracked-Commit-Id: 2f86e45a7f427d217f4b94603a9f43a14877e2cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f06bed87d7cdfd51793cbb0111799f39ba75cfa3
Message-Id: <158128082859.31187.525540796869166403.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Feb 2020 20:40:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 09 Feb 2020 14:02:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-02-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f06bed87d7cdfd51793cbb0111799f39ba75cfa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

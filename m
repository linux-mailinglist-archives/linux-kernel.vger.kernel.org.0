Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA516956F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 03:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBWCzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 21:55:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgBWCzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:55:12 -0500
Subject: Re: [GIT pull] irq fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582426512;
        bh=sT2rDtf4sYNLxHS7Kn/ardWUYSKZ43xXsNUOJJj2ldk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tdPUjlIuD0tfraJBRHAlIkfAQKJxSdYNxsrbBc5LGoSTB8IbKL0p4o+sH4n3dBwia
         fX7isBDB7+n2sXt7i1FluAYM1BzWyElO+89HD14F3C+cX2l6wrhwkJ3SQb/hmBjvHn
         lZ+enFguIUmWkxnDolmFEXoig6INIrNuWzFcckRI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158240520445.852.16454463053831663511.tglx@nanos.tec.linutronix.de>
References: <158240520445.852.16454463053831663511.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158240520445.852.16454463053831663511.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-02-22
X-PR-Tracked-Commit-Id: 2546287c5fb363a0165933ae2181c92f03e701d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3cc24942e955604232e3b4b0dac6a54cbc7c679
Message-Id: <158242651233.13467.10512408820537682430.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Feb 2020 02:55:12 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Feb 2020 21:00:04 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3cc24942e955604232e3b4b0dac6a54cbc7c679

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

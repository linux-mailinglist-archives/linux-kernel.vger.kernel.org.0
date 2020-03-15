Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461E8185FC5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 21:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgCOUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 16:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgCOUZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:25:08 -0400
Subject: Re: [GIT pull] perf/urgent for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584303907;
        bh=GKOpBCylUBtpkVih6coP4IucXrG8ClZPKOdFxGW1roY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vfLd4CdPuXcofG8ED9ty+Xglbuy4/zMfCUvEwnJULlOk8XYQhMBD48SCiYh8smIva
         OOFkzHT7YONnJe8Y9t8hxODIxMs6kmmJ1uZQlln6FsnOeAAi/D4HPdQCk4+JNO1YGT
         aMCvCh+t1CYhPMcrt0UZatqCkDDpjvDRtyDhJZpA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158428527863.14940.2082155777571163931.tglx@nanos.tec.linutronix.de>
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
 <158428527863.14940.2082155777571163931.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158428527863.14940.2082155777571163931.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-2020-03-15
X-PR-Tracked-Commit-Id: f967140dfb7442e2db0868b03b961f9c59418a1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e99bc917fe0233ea64799a5bc376b7d7a7cb0aea
Message-Id: <158430390751.13594.582573945798820994.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Mar 2020 20:25:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Mar 2020 15:14:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-03-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e99bc917fe0233ea64799a5bc376b7d7a7cb0aea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4692088ECF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 01:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfHJXUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 19:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbfHJXUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 19:20:09 -0400
Subject: Re: [GIT pull] sched/urgent for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565479208;
        bh=MSeafg6IoofneVSmp7VVxQ9nN1F5WazLIRdbjLErifs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BSIgOOVmSiROD1LahlKdszrKhOv0QYh+YX9VpoBOymbnpvQ+NkxWl+iatMb2Dc9Ot
         s5iNxHM+t4zFRGcz6yvS8DPjHwxnXhKFhIcFA5BCST8zofNnwa7M1sex/NW0S+oXP7
         7iNy/djQiD8K3ao8fUkBvv6XrJaTCEp3GdzmSAU8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156546731194.17538.15988994782634770420.tglx@nanos.tec.linutronix.de>
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
 <156546731194.17538.15988994782634770420.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156546731194.17538.15988994782634770420.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 04e048cf09d7b5fc995817cdc5ae1acd4482429c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcbb4a153971ff8646af0c963f5698bf21bfbfdc
Message-Id: <156547920814.21687.8146802126945958954.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 23:20:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 20:01:51 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcbb4a153971ff8646af0c963f5698bf21bfbfdc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

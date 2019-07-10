Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7B629A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404591AbfGHTaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 15:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404574AbfGHTaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:09 -0400
Subject: Re: [GIT pull] x86/timers for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614209;
        bh=ZeYPaEdCRjZ8s9mM4oi1ikUJXemNj9nvn/kOgWANjJc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WpqYugOFC4jQKVOHpeCRhC+Ojc4WObKGecSp0l3HIeKiTRvOZov9j65mpv9hPs/Zr
         YaUs+l86G7rob8td567/WtbaV5J0xbaN8CrbK60SU79GQ9o6Nn1Zr8JwN5wkYKkma0
         Lr1B3lKBqCtyx6uEuCMRDlQTOPZZVjZ2DJc6ObHc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673796.14831.2745414267646810295.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673796.14831.2745414267646810295.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673796.14831.2745414267646810295.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-timers-for-linus
X-PR-Tracked-Commit-Id: e44252f4fe79dd9ca93bcf4e8f74389a5b8452f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f0f6503e37551eb8d8d5e4d27c78d28a30fed5a
Message-Id: <156261420905.31351.18172806196433953662.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f0f6503e37551eb8d8d5e4d27c78d28a30fed5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

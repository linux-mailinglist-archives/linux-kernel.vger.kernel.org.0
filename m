Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC36F05D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfGTSkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 14:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfGTSk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:27 -0400
Subject: Re: [GIT pull] smp/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648026;
        bh=58XAWTxCeWuVLXietS9G+HOyDTrlL+axQBsUOo9Qu6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g2VfIoTv6+u+Qy12DnYWTiIh86y50DRtNgAJkLexGJ1zbZEt4vEh4His6lsmPVvDO
         TemtcMNUSbzqn3f6cIVT8M3Cb1qChGqJ/1+lg2ooNPGgrE17ECepZZL6EKDgWZfRxP
         yPtOexEJNkbxUvH+20ohYvkKF+G4W8rjvc9jyZmQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156362700019.18624.17617457563286881221.tglx@nanos.tec.linutronix.de>
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
 <156362700019.18624.17617457563286881221.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156362700019.18624.17617457563286881221.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-urgent-for-linus
X-PR-Tracked-Commit-Id: 19dbdcb8039cff16669a05136a29180778d16d0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b01f5a4c9c4f0c502875c1fb31dcd5d0df86475
Message-Id: <156364802684.20023.10418627090457902557.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:26 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 12:50:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b01f5a4c9c4f0c502875c1fb31dcd5d0df86475

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8D9C533
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 19:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfHYRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 13:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfHYRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:40:07 -0400
Subject: Re: [GIT pull] timers/urgent for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754807;
        bh=GN8oguaMM0Og+EoJnx3TF/88WSIno3UU2PGGMBlGZKw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RaUGpOMuMo4L1twmQmK0rpVCbMbGo4UShYZ9qWdlU5WIX48Y9pF9cEkrd6Yqc2RZe
         YjxA3lLvt0Ybc8m7KldmRdFrWePY1KhtUc4kwb74VZWwtIbH3wTEecefPr5vSU112E
         urc4t45Go5py6Dz1iUBAAE0DMTvYQpD6IizxTWtQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156672618029.19810.11392026209249158095.tglx@nanos.tec.linutronix.de>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.11392026209249158095.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156672618029.19810.11392026209249158095.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: b99328a60a482108f5195b4d611f90992ca016ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a13fc3d8ba00b786056e6fd3612b5102590992f
Message-Id: <156675480701.29384.16236142489342664488.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 17:40:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 09:43:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a13fc3d8ba00b786056e6fd3612b5102590992f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

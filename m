Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA43EAC377
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 02:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405727AbfIGAAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 20:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405541AbfIGAAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:00:08 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567814407;
        bh=3rCpcINeaB832GStVxP1L3/B8p7yuzOO05KsfCq9KR4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Hd1t/x1eovekgLfHjmeJJ+FSpRIwZB4Mm79uHqpstJALTyy8J/uKanlzzm3q9MpDx
         ATYEqgMBIQLu2l27Nw02Kc5BQMf3fBK551sX+GoeCOAGJdk7brtK+339xQXunnfrrr
         HiO9DtrW0Frambtzuzznhw7WS7JAA9+ug1vWCIDw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1567802352.26275.3.camel@HansenPartnership.com>
References: <1567802352.26275.3.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1567802352.26275.3.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 0622800d2ebccead42b3a85e255f7d473a36ec99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e3778cb223e861808ae0daccf353536e7573eed
Message-Id: <156781440764.2933.15376461867039956784.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Sep 2019 00:00:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Sep 2019 16:39:12 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e3778cb223e861808ae0daccf353536e7573eed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

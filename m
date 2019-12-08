Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC11163E4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 22:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfLHVk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 16:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfLHVk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 16:40:28 -0500
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.4+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575841227;
        bh=VFdLGvUEJlFx3BfpBrV+NXc5ubZKGBWPK6idiiHlAYA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0y3IKCCINFRqJTUTq91P4K9B/Sc7VoW9abxKKFeDZaLa1sKdDOF2Bg2ucK6RmbOAB
         l9P8Jle29CsRBWnhp9EfjNO/Ayb/UNEWC1uigBE4WopIkugFJSybcQbKY7MY1gcO37
         PClc4wIcWwIr04euHGxlGDbURhrlNgj+tfPi4Ow4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1575781191.14069.3.camel@HansenPartnership.com>
References: <1575781191.14069.3.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1575781191.14069.3.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 1eb9151eb7c58c2a4b995918271e13037ae278b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 138f371ddf4ff50207dbe33ebfc237e756cd6222
Message-Id: <157584122757.22418.13844672043621103927.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 21:40:27 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 07 Dec 2019 20:59:51 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/138f371ddf4ff50207dbe33ebfc237e756cd6222

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

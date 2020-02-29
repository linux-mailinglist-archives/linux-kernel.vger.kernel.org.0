Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB58E1747E8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 17:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgB2QKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 11:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgB2QKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 11:10:06 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582992605;
        bh=hN2o55zQJWeSJj1BJINpK5gCzFdmbuVzu8aoQPfcNug=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kZLLCUvYBneenMA7eCCSA3HtbJltRJflbe7jscBz3gdo21Rkx4dCj/Ha7FC5ERuaN
         RwoHLK/uabwBuOXUAMMcimseD16Z5LvFrS7qtSeTBj4g33gqhnio16EMLNoaMU4fdK
         FmmEfvPekUc8Ihdiw2EttrnreuSeuV2UulTHku2Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1582985668.3507.9.camel@HansenPartnership.com>
References: <1582985668.3507.9.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1582985668.3507.9.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 03264ddde2453f6877a7d637d84068079632a3c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7557c1b3f715624f3bd4c809f03771ce9384eb7b
Message-Id: <158299260579.20304.5715694865146177189.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Feb 2020 16:10:05 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Feb 2020 09:14:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7557c1b3f715624f3bd4c809f03771ce9384eb7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53CF88CEB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 21:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfHJTaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 15:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfHJTaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:30:12 -0400
Subject: Re: [GIT PULL] Driver core patches for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565465412;
        bh=ovsVLzgAB/VCa2BQdcpmrOiyoai0bKMf46yrUWPYOOY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J4SsRECefoNAOaPIwoJbdW05VSRIJyEL1mf2ppCbnsOXhJ8Gywo+uvpK0dluRU2Y9
         eD3g0rqSB1HO7Uyz8xgZW/AndgXpfh/IbAw1MuMJukHAAOp6y0ficT7O3ChN1pnrBO
         IRtmlRocpWjFpAbwGsOgkXqOfd/6t06A16YzoaRQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190810115301.GA6047@kroah.com>
References: <20190810115301.GA6047@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190810115301.GA6047@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.3-rc4
X-PR-Tracked-Commit-Id: 8097c43bcbec56fbd0788d99e1e236c0e0d4013f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36e630ed98d5daa628368121f74bf37bead9206b
Message-Id: <156546541204.17840.1401929848382451245.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 19:30:12 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 13:53:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36e630ed98d5daa628368121f74bf37bead9206b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

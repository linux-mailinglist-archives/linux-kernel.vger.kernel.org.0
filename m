Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A901710DFCA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 00:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfK3XF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 18:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfK3XFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:05:21 -0500
Subject: Re: [GIT PULL] RAS urgent for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575155121;
        bh=5hJM3lKegDFz7tztvw/2Xk/m4wcryOYeSfLekR5jvtQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Nl2FwzA+Y0ZWxkhpIjbpBvvSd5CHAWraNpQ5fttIynflV8FnUBn0A5pUVC0kv6SqC
         l/tbo2A+HLwXYY7p+JWDsMN+t8jZwB+6Xdfvd6bNP0mqyi1K/xhjQ+ZDfRVUFwh7g9
         c8Du0RIOugN0pE/nPj+h6eNQIcK8tnVD6Mb41Luo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191130184612.GA17459@zn.tnic>
References: <20191130184612.GA17459@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191130184612.GA17459@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 ras-urgent-for-linus
X-PR-Tracked-Commit-Id: 5a43b87b3c62ad149ba6e9d0d3e5c0e5da02a5ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fa91bfa9ba4060347c45673f8ee990a2a1d760e
Message-Id: <157515512126.27985.14802978774335184426.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 23:05:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Nov 2019 19:46:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fa91bfa9ba4060347c45673f8ee990a2a1d760e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

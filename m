Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3CA1097BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 03:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfKZCPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 21:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbfKZCPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:10 -0500
Subject: Re: [GIT PULL] RAS updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734509;
        bh=MdqrTEl0sKW39FweytwSIcIwLBU3C5uN+tKb/8ZFipI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cJMKTlqbacpLwm2J/DwKYvwM86uf3uE+xk96cWUza5RTorf5gqj+YHZbDCeLPy6aP
         bT14A8QqKCKYIYI55A0By3CMuSx3mUVjrLkzLZ470ys+JrSM/pv0ldSJLp7zq0eZ3I
         gqxwZMYSweDfkkB0Wx7zl61DBQHxLyjkr1dvY4V4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125080035.GB12432@zn.tnic>
References: <20191125080035.GB12432@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125080035.GB12432@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus
X-PR-Tracked-Commit-Id: f6656208f04e5b3804054008eba4bf7170f4c841
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28fcb77b387832f03a31624b9de515ea1b57b419
Message-Id: <157473450970.11733.7479424477842162379.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:09 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 09:00:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28fcb77b387832f03a31624b9de515ea1b57b419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C251537F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgBESUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 13:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbgBESUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:16 -0500
Subject: Re: [GIT PULL] xen: branch for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580926816;
        bh=yuBrlgCSyNpGr7f0LkdGSKgVKnHVeUJjNZG0igVS9No=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nzH9OKtg7Wr17/acZ5zPdO4nd6vpEVmHl1rP1B4nTRnmGk+3bHyRZHpfwPTDKvdiK
         C0eETZgCkjnldURs8faFa2ds7o8EUogzUfLFo3eJD2nK8GvXgm9GMbhXM2fW8AU3q/
         NzjDLSUr4RhhXOOFV4Qe/APvd10GeR8x0xZvRoq0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200205141135.31595-1-jgross@suse.com>
References: <20200205141135.31595-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200205141135.31595-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.6-rc1-tag
X-PR-Tracked-Commit-Id: 8557bbe5156e5fba022d5a5220004b1e016227ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d271ab29230b1d0ceb426f374c221c4eb2c91c64
Message-Id: <158092681621.14135.14219430235179173763.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Feb 2020 18:20:16 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Feb 2020 15:11:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.6-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d271ab29230b1d0ceb426f374c221c4eb2c91c64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

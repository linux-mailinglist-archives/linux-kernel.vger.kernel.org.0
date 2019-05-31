Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71BE3147D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 20:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfEaSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 14:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfEaSPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:15:15 -0400
Subject: Re: [GIT PULL] xen: fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559326515;
        bh=DeSV129wW+0DXW6DOrtnDLIS3PoYB2Q3q6d6pGuoqng=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f4CUia6q6CXJ2Rx+FquCyWdAzhSvwxN96hJl3J62I/XTdPlNpsz3p/21zMOzFJii9
         RIMuBXr8kovT1SyoenyL+zjznTnq3VeqAwITyoUMVWt6Tf4dsdlusvoUV0rIP8j2Tn
         F1aaXUcn5ALh0+eHPQYs0S7TbuVNMYoLZkw3h/nc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190531135603.3403-1-jgross@suse.com>
References: <20190531135603.3403-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190531135603.3403-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 for-linus-5.2b-rc3-tag
X-PR-Tracked-Commit-Id: d10e0cc113c9e1b64b5c6e3db37b5c839794f3df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8164c5719b864da3bcfee97ad8af8cfd7ee5ad8c
Message-Id: <155932651541.23368.10945746314777442643.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 18:15:15 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 May 2019 15:56:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.2b-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8164c5719b864da3bcfee97ad8af8cfd7ee5ad8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

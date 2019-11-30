Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BA610DEF2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 20:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfK3Tk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 14:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfK3Tk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:26 -0500
Subject: Re: [GIT PULL] erofs updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142825;
        bh=YgkJswfgiig8ZdaD6RHBZPUYYGoSPSFIx9vRKPxCGF8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tF2bZD0ZgrSQBYEuqtqYcXkFec/DVhqqMNMayQCNZuBMUTuf3TU+D8216H+2pXR0J
         ntTFrhc9W8jvtmLAwMkTrF9GaRPFbQD3shzoI65A9kPk+GDaNaYnRPFf/w40YZlnJN
         nrDifMrdNRvvG4Hbuo+NQW0WMYnp2QXw5YlBlK7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191128152711.GA4993.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.5-rc1
X-PR-Tracked-Commit-Id: 3dcb5fa23e16ef50b09e7a56b47d8e4c04ca09c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2d73c302b6b0a8379a679120590073b813d5e7f
Message-Id: <157514282582.12928.6503250259230440672.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:25 +0000
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 23:27:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2d73c302b6b0a8379a679120590073b813d5e7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

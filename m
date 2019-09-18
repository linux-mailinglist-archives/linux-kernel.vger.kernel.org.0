Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39445B6A60
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbfIRSU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 14:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388010AbfIRSU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:20:26 -0400
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568830825;
        bh=lpTLlt8KBVO05bSuzAoOwZEDrfqDTb+2mrWqDmZiOsk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qY8vtRABIXfQ3NohD6CXdfAhAacR7f0LxwG77P2TV0l9zas+UCGlUshk+nwxWPZYd
         dwPIs5AXk1KEqyE1HqMGCF7nKcIOGzLhunWqaSXcMcB3fFD8JATFPJfsJ7/UFZuEM1
         iSC74iCwWDhR6oQn6sLcqcjEtf/5buAErBfits+A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190918114754.GA1899504@kroah.com>
References: <20190918114754.GA1899504@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190918114754.GA1899504@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.4-rc1
X-PR-Tracked-Commit-Id: 3fb73eddba106ad2a265a5c5c29d14b0ed6aaee1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6874fc29410fabfdbc8c12b467f41a16cbcfd2b
Message-Id: <156883082558.23903.18107326281784968321.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 18:20:25 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Sep 2019 13:47:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6874fc29410fabfdbc8c12b467f41a16cbcfd2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

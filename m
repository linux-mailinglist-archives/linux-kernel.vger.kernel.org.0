Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86FE9B4C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 18:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405990AbfHWQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 12:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732572AbfHWQpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:45:08 -0400
Subject: Re: [GIT PULL] modules fixes for v5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566578708;
        bh=wndpDnUc4/UwuIdsdJvttVKVlH7HF0aDsRi30cD3l+k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V8BfgSHho1/uWJW9rYg7aaadtiwRcRCB0My1hZ1lMN8zlEnX2opn1D/qF6ZvEklNx
         PDaD2odnlhF5jYa715bqabUQF2z0e0QUadMog7mfanb68G3/GP50vq3UcWTiiD9rCh
         NUbzAReB+NLLgdR3JtpPiInu04mx7bce/XHfaG9Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190823151213.wdjaslloway6ng4u@redbean>
References: <20190823151213.wdjaslloway6ng4u@redbean>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190823151213.wdjaslloway6ng4u@redbean>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.3-rc6
X-PR-Tracked-Commit-Id: 3b5be16c7e90a69c93349d210766250fffcb54bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3fb13b7e47cd18b2bd067ea8a491020b4644baf
Message-Id: <156657870800.6801.11202958537547921431.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Aug 2019 16:45:08 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Aug 2019 17:12:13 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3fb13b7e47cd18b2bd067ea8a491020b4644baf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

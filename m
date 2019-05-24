Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FD729DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbfEXSUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 14:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391618AbfEXSUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:20:18 -0400
Subject: Re: [GIT PULL] arm64: Second round of fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558722017;
        bh=EbCatF+nk6Yrrx+RopsbQWZdXfG/uf+mUj9qs2Y1cw4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xVELS5AZpMr7x2GkF7U7Ut/dhQ80wTsGzrrQhxAHfUFsDOuZVwwpDUMMHAH/7Jgl6
         iHJ7XiX7oeS7XticboJGpA1tLamQUIXsfVoQQv5Bu+8bKyZwETWpgi5VksS9wrnrJD
         04dnjx1MYUGjB9ZqB2K7yoPrX8B+pyc/9E9fDze0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190524174357.GC9120@fuggles.cambridge.arm.com>
References: <20190524174357.GC9120@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190524174357.GC9120@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: edbcf50eb8aea5f81ae6d83bb969cb0bc02805a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a72ef89901409847036664c23ba6eee7cf08e0e
Message-Id: <155872201757.27843.1132229878974057804.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 18:20:17 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 18:43:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a72ef89901409847036664c23ba6eee7cf08e0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

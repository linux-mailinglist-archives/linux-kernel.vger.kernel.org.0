Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077EE16646
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEGPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 11:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfEGPKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:10:04 -0400
Subject: Re: [GIT PULL] regulator updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557241804;
        bh=Cp33axtYLXQV79kfBoQsf2nMkq84TAp1qqrLbuAeTJw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YhcXBgm72pg5hdOI32cIueFbe+GMqG+aND4BvYoDt2PnyPaUlw0tiN6lrbycgwkma
         r6Yv0hMOkCrEPnYSkM5ufCoWO+WwtLAAf0ZXxj/X4bt5l+gxoZxMmLg2y0u67UQ3pG
         +NUsl3Og/yPY6a4vqimQ7G9/LyAXbiNdJTeGYIDg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506142352.GT14916@sirena.org.uk>
References: <20190506142352.GT14916@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506142352.GT14916@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.2
X-PR-Tracked-Commit-Id: e2a23affe6a6a15111ae56edd7e4f3c9673ef201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61be53f9ef37de2677cecb8f87b207e6f061e185
Message-Id: <155724180399.32029.18187349334167258076.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 15:10:03 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 23:23:52 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61be53f9ef37de2677cecb8f87b207e6f061e185

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

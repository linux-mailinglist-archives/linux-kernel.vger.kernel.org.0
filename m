Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2003A1D089
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 22:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfENUZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 16:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfENUZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:25:03 -0400
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557865503;
        bh=2Y53EyDD14aT6cgQS+5yEtZ95iiGMtp3cPUFxI50hjM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AUfOMO3avDQg1fxZwGZxf7E5nvNOmk31+znDmiZ67crwpbG5jZaHLJZcIkIFJjYry
         Df8K3AOyckvighsB0afq9LQyH2GQFduU071VGeNCh1picRyRujrNsOFx4TrHX443VO
         d+ttUlV2cKRS6nep9cj1aTsJ2wlKSv405tw3xh/E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514200010.GA30418@ls3530.dellerweb.de>
References: <20190514200010.GA30418@ls3530.dellerweb.de>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514200010.GA30418@ls3530.dellerweb.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.2-2
X-PR-Tracked-Commit-Id: 4e617c86ba9be5211643e53f5f69d1195c956d68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2c91128212a4c1a36bd3085191bff21a34324be
Message-Id: <155786550298.4888.14619113787082061340.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 20:25:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 22:00:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2c91128212a4c1a36bd3085191bff21a34324be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

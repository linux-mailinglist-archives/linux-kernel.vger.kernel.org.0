Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D97226B19C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfGPWKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 18:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731273AbfGPWKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:10:17 -0400
Subject: Re: [GIT PULL] ARC updates for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563315017;
        bh=DZLMybQ+iQHK3bFHht3dTVWSxVGo6cHf+BYHkcrum8o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=06iXnLrrz7PqEWH2+7kh33DFAXYaRJUPL0RALGyKOindTMvmNLpsoT9MO2hwKmVwK
         8j3FBeEdV7sHnID9D/UZxzxIZrta/fyPq7a0RyjSUMeAoSVPlQqbKtW5DM4A8IC7Ys
         GUgSB0j2uRhmjFGmzEkb8A0InMrssz8SjHS7XGWM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <99fc2ead-d7d8-1c54-b493-02e79e2fc24e@synopsys.com>
References: <99fc2ead-d7d8-1c54-b493-02e79e2fc24e@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <99fc2ead-d7d8-1c54-b493-02e79e2fc24e@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.3-rc1
X-PR-Tracked-Commit-Id: 24a20b0a443fd485852d51d08e98bbd9d212e0ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3eb514866f20c5eb74637279774b6d73b855480a
Message-Id: <156331501700.32356.12748239579521687506.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 22:10:17 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 20:22:58 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3eb514866f20c5eb74637279774b6d73b855480a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

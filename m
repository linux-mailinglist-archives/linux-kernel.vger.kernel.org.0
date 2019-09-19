Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A10B8366
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404862AbfISVae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 17:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404843AbfISVac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:32 -0400
Subject: Re: [GIT PULL] Devicetree updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928631;
        bh=NsvKasoijQo3C138eYiB2uWLdScMpV+4dU4hDsG60VE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yrSSyrWczCSYL2T3EzzJPHHN6pTo1wzCxi8frj2pSByNK2ObNY8v9y49gxbSNU0ll
         LMOn2gT9p1SKm91b+zBUw+gF6WwuO/PFEbrWqPrsm5jJ8INQl8Jk1dShFWD8clT+UC
         i4HGtboyPVHGq0CR2RhXDg86GdCuwtFWUNhYODxE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919155354.GA8880@bogus>
References: <20190919155354.GA8880@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919155354.GA8880@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-for-5.4
X-PR-Tracked-Commit-Id: 59e9fcf8772bd97b6d681706fb8c9a972500c524
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3a008ac1213d99f5f1210adc9d2a1f60da10c3b
Message-Id: <156892863173.30913.14275484183569471881.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:31 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 10:53:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3a008ac1213d99f5f1210adc9d2a1f60da10c3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

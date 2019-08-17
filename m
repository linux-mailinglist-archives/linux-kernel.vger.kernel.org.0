Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD48790BC5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 02:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHQAfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 20:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfHQAfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 20:35:06 -0400
Subject: Re: [PULL 0/1] Xtensa fix for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566002105;
        bh=7EoUe3CCPAt8xmkhvStFQGDFk2Mj6wGTGoEowXRtF3o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tzwNrk4cwBAApC2rDbBTDyvEN4R0qem0DfUjD6EsCzvr0E3++s4liokP8l7ysIyk3
         nF5jyNc5oKaAJbqdOtaDOmyYYl1a9Sfgrbcm/mPdtm9gLVkoVOWAuxx9ZQGWOwtVSL
         cYXTQwSE3sDPAzV49PfajWSz3b5+6Xot5fPeYn+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190817002349.28658-1-jcmvbkbc@gmail.com>
References: <20190817002349.28658-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190817002349.28658-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190816
X-PR-Tracked-Commit-Id: cd8869f4cb257f22b89495ca40f5281e58ba359c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e625a1a3f471d63989d3a66cdf6a0c307654848
Message-Id: <156600210583.524.16585893842032622574.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Aug 2019 00:35:05 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Aug 2019 17:23:49 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190816

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e625a1a3f471d63989d3a66cdf6a0c307654848

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

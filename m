Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5EA41A4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 04:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfHaCKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 22:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfHaCKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:10:08 -0400
Subject: Re: [GIT] Crypto Fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567217407;
        bh=+rpYjFz/gK9mI2ubcksMopnmlCrYO26/OTwsyxCeN5A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bC6MBoifjzLlzLjhGZ0x5f8U4Ph/Le5T2zYiLu5XdMnzU8oGLi9aGwaPcNRtLI40Y
         tCFwp1kSxM3pvXVAwEziwrRIpLZKTQdqcsN+lLRZj4lAZI/72q3yjOc1D7DoiahRAf
         gO/nPjkvLZx4Lf7oVbpSTnw0k8iBgiowrjsCGZ2E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190830073906.GA4579@gondor.apana.org.au>
References: <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20181116063146.e7a3mep3ghnfltxe@gondor.apana.org.au>
 <20181207061409.xflg423nknleuddw@gondor.apana.org.au>
 <20190118104006.ye5amhxkgd4xrbmc@gondor.apana.org.au>
 <20190201054204.ehl7u7aaqmkdh5b6@gondor.apana.org.au>
 <20190215024738.fynl64d5u5htcy2l@gondor.apana.org.au>
 <20190312045818.bgpiuxogmaxyscdv@gondor.apana.org.au>
 <20190515060552.ecfwhazt2fnthepg@gondor.apana.org.au>
 <20190719031206.nxyxk4vj6dg7hwxg@gondor.apana.org.au>
 <20190809061548.GA10530@gondor.apana.org.au>
 <20190830073906.GA4579@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190830073906.GA4579@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 5871cd93692c8071fb9358daccb715b5081316ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0f14b8ca3882988d15f0b1b853ae3c29d8c9a83
Message-Id: <156721740767.9496.7852872597014015021.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Aug 2019 02:10:07 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Aug 2019 17:39:06 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0f14b8ca3882988d15f0b1b853ae3c29d8c9a83

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

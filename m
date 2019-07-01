Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74D37EA7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 22:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfFFUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 16:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfFFUUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:20:12 -0400
Subject: Re: [GIT] Crypto Fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559852412;
        bh=Enbhr0t4DrJHwsF0RYBPkQa9lvUyfpzeuvhT2rjVbA8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=doUi+nMSSGxUu4ryIdBi1Vo+gNHhx6mKag8EslupaaO5n8gLoF0g+Tmw0/0m3V+Rv
         n7NYeWzco3SCMEACLdTl/Sl3pgtPm+jQuSyBBVh1zWTSe7YCfo1A1crywCqF8bGLyK
         1iEaaq9l+HNN+/ydUrXWJL4LGjV4ETmYWbAnhOTU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190606060324.du5zbk3ju5djkhfe@gondor.apana.org.au>
References: <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20181116063146.e7a3mep3ghnfltxe@gondor.apana.org.au>
 <20181207061409.xflg423nknleuddw@gondor.apana.org.au>
 <20190118104006.ye5amhxkgd4xrbmc@gondor.apana.org.au>
 <20190201054204.ehl7u7aaqmkdh5b6@gondor.apana.org.au>
 <20190215024738.fynl64d5u5htcy2l@gondor.apana.org.au>
 <20190312045818.bgpiuxogmaxyscdv@gondor.apana.org.au>
 <20190515060552.ecfwhazt2fnthepg@gondor.apana.org.au>
 <20190606060324.du5zbk3ju5djkhfe@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190606060324.du5zbk3ju5djkhfe@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 7829a0c1cb9c80debfb4fdb49b4d90019f2ea1ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae8766042beee814c9e16e9ae1e84cd6eaa7ffaa
Message-Id: <155985241232.29387.3663283585345390700.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jun 2019 20:20:12 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Jun 2019 14:03:24 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae8766042beee814c9e16e9ae1e84cd6eaa7ffaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

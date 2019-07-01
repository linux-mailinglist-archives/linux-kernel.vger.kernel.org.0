Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4851F836
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 18:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfEOQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 12:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfEOQKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:10:15 -0400
Subject: Re: [GIT] Crypto Fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557936614;
        bh=S3xsJ9D2FBrUrUut4SDDJZr9fkFftSXWha+RF701Ghk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GWkWaVgsXPQ+oFpx0EdKaSI3uHOcIPf85Cr4ZnFBEP0vQHqjXu6pbXFkMGPaSSOlp
         sXRJGofYq6r8luO49u2QPUPCaJK5vbd5wMb10gZ3zuANMKyuzMfH5wJvByPvbukz6/
         cPy3+LJk3Rk+M7xnaYQAlB/18XsnV4HMjO4dI98I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190515060552.ecfwhazt2fnthepg@gondor.apana.org.au>
References: <20180212031702.GA26153@gondor.apana.org.au>
 <20180428080517.haxgpvqrwgotakyo@gondor.apana.org.au>
 <20180622145403.6ltjip7che227fuo@gondor.apana.org.au>
 <20180829033353.agnzxra3jk2r2mzg@gondor.apana.org.au>
 <20181116063146.e7a3mep3ghnfltxe@gondor.apana.org.au>
 <20181207061409.xflg423nknleuddw@gondor.apana.org.au>
 <20190118104006.ye5amhxkgd4xrbmc@gondor.apana.org.au>
 <20190201054204.ehl7u7aaqmkdh5b6@gondor.apana.org.au>
 <20190215024738.fynl64d5u5htcy2l@gondor.apana.org.au>
 <20190312045818.bgpiuxogmaxyscdv@gondor.apana.org.au>
 <20190515060552.ecfwhazt2fnthepg@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190515060552.ecfwhazt2fnthepg@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: cbc22b062106993980df43a7ffa93351d3218844
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88f76bc31b93cc228f5a43d5b565dc53615970ae
Message-Id: <155793661488.5377.14250847400138191195.pr-tracker-bot@kernel.org>
Date:   Wed, 15 May 2019 16:10:14 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 14:05:52 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88f76bc31b93cc228f5a43d5b565dc53615970ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

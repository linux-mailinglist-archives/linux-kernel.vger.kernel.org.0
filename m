Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6FBBB9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439837AbfIWQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 12:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389516AbfIWQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:50:23 -0400
Subject: Re: [GIT PULL] Crypto Fixes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569257423;
        bh=EgzKp8gT6sv3Jp0+LGrkd2T20MjVNCHyLZuApqgeVcY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ytmVOz0Gvkv8fYQOqM2L0ZH1pg12l+EPSjTPry8ZVOQ1pd4qPaSI3KXNHKXpQtFZH
         o6TU/cTp48EkQDW09N8159Geh0naHBx7A0CtOH3lNkKsXkNY3xacEiYJwNpUKHVwxW
         5lbDfuP3VYDufqATtNhHekvOpD9uR/t2QazkdaLE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190923050515.GA6980@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190923050515.GA6980@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: bf6a7a5ad6fa69e48b735be75eeb90569d9584bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c6a6910a81eae3566bb5fef6ea0f624382595e6
Message-Id: <156925742341.29653.3717337141757477266.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Sep 2019 16:50:23 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 Sep 2019 15:05:15 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c6a6910a81eae3566bb5fef6ea0f624382595e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

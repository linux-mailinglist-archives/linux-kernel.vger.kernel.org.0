Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEC3190180
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 00:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCWXFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 19:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCWXFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:05:08 -0400
Subject: Re: [GIT PULL] Crypto Fixes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585004707;
        bh=8Kbx+YuPM/kjl/gzSlFEWqeDnOrd7rW3lT6qNKD2TGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gh9N4QYcxURA1vuQFp9X/9vN6jCysP/P03cueNfUJCEfemtKsTLS1covr9hYe6r7h
         NQfwsSX792qAPbQquM/9UWdEVfXyco3VcCYWdSsmmdBPiS4dZBE9ajciSYACkz9zE/
         NZNbOftpssAWUHRnxNxqsyOIMfrL9H1cw9BrvonA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200323225403.GA10100@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
 <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200224060042.GA26184@gondor.apana.org.au>
 <20200312115714.GA21470@gondor.apana.org.au>
 <20200323225403.GA10100@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200323225403.GA10100@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: c8cfcb78c65877313cda7bcbace624d3dbd1f3b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 979e52ca0469fb38646bc51d26a0263a740c9f03
Message-Id: <158500470751.3923.15723237667884136785.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Mar 2020 23:05:07 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Mar 2020 09:54:03 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/979e52ca0469fb38646bc51d26a0263a740c9f03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

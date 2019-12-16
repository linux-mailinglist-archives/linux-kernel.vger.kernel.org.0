Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2911F491
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLNWFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfLNWFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:14 -0500
Subject: Re: [GIT PULL] Crypto Fixes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361114;
        bh=I2VWsQ7ikxV/ncRAKaZFTsgS5lVdp1KBdow1jMBx9bU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FbSZdmMYsZNc+xQpGM1DvtwBJVLiJ46bhuHxB2RYDglaa2o9WmIwkmMVtqRlScxOK
         vy227D4a0+FiM1GWgjylmiHWuwMi8emch3gZAKpi86+rezwRmWrVNkXswDT/cOSJ/l
         UstsHc4Fm0JEGYp/04H3baqQP98NTWg6bRTxZEFc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 84faa307249b341f6ad8de3e1869d77a65e26669
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f791ede32a14151a313783e1105049a137bc13c8
Message-Id: <157636111437.10255.7018789282938420709.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:14 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Dec 2019 16:47:49 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f791ede32a14151a313783e1105049a137bc13c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

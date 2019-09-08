Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD26AD02C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfIHRZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 13:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbfIHRZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 13:25:07 -0400
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567963506;
        bh=DE65Vr0cIj/WIkgoSTFUNCFHGAZp5GZJ8YQBuwM/qbg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jbWlwfebte2Gg5Ku13I3gSBM4p9myBaTc1Tlfh5/MkwqWAOyceRbwsvabI5K8hf4s
         +ImNd6mW+R+s52Kvg76NU6wsmnq9nD7UuM/rR86vzfRcBwHOTAfCoYYk9pC9ACJGvF
         sfvALW8uDl1UBN9A5rSc931okLz4cQ3fgj/6vPeg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190908131902.GA21291@gmail.com>
References: <20190908131902.GA21291@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190908131902.GA21291@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/clang-format-for-linus-v5.3-rc8
X-PR-Tracked-Commit-Id: bfafddd8de426d894fcf3e062370b1efaa195ebc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 983f700eab89c73562f308fc49b1561377d3920e
Message-Id: <156796350665.11336.4938535475327406402.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Sep 2019 17:25:06 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Sep 2019 15:19:02 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/983f700eab89c73562f308fc49b1561377d3920e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

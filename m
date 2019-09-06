Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B451AABD43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395001AbfIFQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 12:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389819AbfIFQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:05:07 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567785906;
        bh=HZS0esBsXkA/xOpK9Zq0YymWhBmGQS9TSY4CwtjMfow=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g5L9Ojvqlkk9Q1dG2WxN/4Riv+lfguAiPDVsCiGpxtzVsvHS6Rr7IHIJxbT6HpCx/
         HihWj+0fhk2YyDxsk/LkpOkO8NKvc+MN9mhTFcrb9KIxMsFnzf3H8BTVlGZQGA8vxY
         dUy6V0nx9U1RCDtXuLdupUX75qB1zqML9pJYTZH0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ftlaxc7q.fsf@mpe.ellerman.id.au>
References: <87ftlaxc7q.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ftlaxc7q.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.3-5
X-PR-Tracked-Commit-Id: a8318c13e79badb92bc6640704a64cc022a6eb97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13da6ac106be36d7c2d7f201fd8850a9ac235e6b
Message-Id: <156778590650.8517.9883351344720266576.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Sep 2019 16:05:06 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, gromero@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        michaelellerman@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Sep 2019 14:47:37 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13da6ac106be36d7c2d7f201fd8850a9ac235e6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

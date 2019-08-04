Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A780BE3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 19:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfHDRfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 13:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfHDRfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 13:35:11 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564940110;
        bh=p8sZ1n+hQaEsRgjUvi94bZ6afmnCTZBAhpFkK+/KLWI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ls8rmKq4GAlyaFcbM76kf257P4gGl7E8tDyKRvSHTfrSmXuaxNO9QD0m1ANf7EJ8L
         ihJWzZAveb1XvHsr4NdrFH38AP7G/3A7e7Rh/hs5Qv8XLiYZUrIG5qSjVOXt+JSCBH
         FhXTDEawV2qpujVARutIXkOUMNsIiV57u/P6XNh0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a7cpw3on.fsf@concordia.ellerman.id.au>
References: <87a7cpw3on.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a7cpw3on.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.3-3
X-PR-Tracked-Commit-Id: d7e23b887f67178c4f840781be7a6aa6aeb52ab1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b6f23161b4e888e72671e377c32eabe9a8e62fc
Message-Id: <156494011026.19393.8183498091592530335.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Aug 2019 17:35:10 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, christian@brauner.io,
        christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, santosh@fossix.org,
        sfr@canb.auug.org.au
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 04 Aug 2019 21:49:44 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b6f23161b4e888e72671e377c32eabe9a8e62fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

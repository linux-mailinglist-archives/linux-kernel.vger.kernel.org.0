Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C660E148D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbgAXSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 13:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390537AbgAXSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:00:04 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-6 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579888804;
        bh=pTt5/4nJC64IRziuSrsQeLEAm3Ls4N5MKo4AbO+HsEs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DMS+QMLSmyZw3ozsXl0FgwSkgp/moUiKpsIj4zrbthu2g86uST5vsfLTjsDdlCFIN
         T1QvIyAebferbrguPeApi0n9W3S2/4ARu/PSRDgISkSkz8wXXkq4cxvtckfSzBK5qZ
         Dv4cJ6onH+x1omRxJ4mxf97r4UdsJUSp9y9eF4dM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87zhedgihh.fsf@mpe.ellerman.id.au>
References: <87zhedgihh.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zhedgihh.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.5-6
X-PR-Tracked-Commit-Id: 5d2e5dd5849b4ef5e8ec35e812cdb732c13cd27e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c45d7510cf563be2ebc04f6864b70bc69f68cb9
Message-Id: <157988880438.9531.13004040647699970908.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jan 2020 18:00:04 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, bharata@linux.ibm.com,
        fbarrat@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jan 2020 23:13:30 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.5-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c45d7510cf563be2ebc04f6864b70bc69f68cb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

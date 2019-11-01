Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224B5ECB4D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 23:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfKAWUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 18:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKAWUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:20:02 -0400
Subject: Re: [GIT PULL] parisc architecture fix for kernel v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572646802;
        bh=nq94pIIwfxzOaW6/9p5VoikDsKMKqN53yODcP2vYWBM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ALPvJw9vCXO9cKCdJ0PvrlrSg3p9a8drIGF49pYkB9wzoGZjod2MwPkL7UodwlKIH
         sQ9qK7u1K6TmQgvF2/UnZgqWiMVVLiqjNA4oeu2a2SrR+4LsJ5VOSx7DfZys0HsBGn
         svQGsjj3ibWuKAx83VWB4T3/lH2oJMf/0D8DPbwM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191101202019.GA22999@ls3530>
References: <20191101202019.GA22999@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191101202019.GA22999@ls3530>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.4-3
X-PR-Tracked-Commit-Id: 3d252454edd0fe88c8250cb7f9dfb9ec12d208d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31408fbe33d1d5e6209fa89fa5b45459197b8970
Message-Id: <157264680212.18172.12099761353547722974.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 22:20:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 21:20:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31408fbe33d1d5e6209fa89fa5b45459197b8970

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

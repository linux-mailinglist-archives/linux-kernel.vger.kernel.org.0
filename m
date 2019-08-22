Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32C99EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390359AbfHVSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 14:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390279AbfHVSaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:30:08 -0400
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566498608;
        bh=16uk2wBMWF1MpWHMNHAvmipTGjfZNpNoFFjWJtA8jZo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0zsBitv/rHU2bOGs158JUsPusZFhoAqBOm9dzp2NzXYC8MMjuB3gBADqC36pkNpRa
         kn4A4x9Csy92npEyInsW3nKRigJM/rIWXNazeN5s4vtNNR6nq6upCg/7I4n8Y2sjZO
         wCHZ/jJRhO2f1aAbcGQXKQghRJh3yHFjyA8R/K0w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190822165815.GA2586@embeddedor>
References: <20190822165815.GA2586@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190822165815.GA2586@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/Wimplicit-fallthrough-5.3-rc6
X-PR-Tracked-Commit-Id: c3cb6674df4c4a70f949e412dfe2230483092523
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20eabc8966f5c1973c2dd2450060f4511389a19c
Message-Id: <156649860810.11049.17005184565041779788.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Aug 2019 18:30:08 +0000
To:     "Gustavo A. R. Silva" <gustavo@linux.embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Aug 2019 11:58:15 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20eabc8966f5c1973c2dd2450060f4511389a19c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

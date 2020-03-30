Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C616B19858B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 22:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgC3UkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 16:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbgC3UkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:40:08 -0400
Subject: Re: [GIT PULL] seccomp updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585600808;
        bh=YTTTjCX8oEROf3f3IDnSDv0fSZht2D8vQsEFfJh58Fw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fth3y3lM+ecw5bXGzFowWkS6m95hC4I1hmDiT6Cuu0HmirQ2yasUNmjbXNAkLepuZ
         b3b7LbifBIpx3nOXXFzL/RMTYLySVOVcCLij8+SAzed6FxLN6gg4vlgBtRv/Ier8Di
         Z1TSPxWV1f6jMtgqIxzHq/huiV+VbjWcWlhr2nkQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202003292114.2252CAEF7@keescook>
References: <202003292114.2252CAEF7@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202003292114.2252CAEF7@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/seccomp-v5.7-rc1
X-PR-Tracked-Commit-Id: 3db81afd99494a33f1c3839103f0429c8f30cb9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78b0dedd529239332b1f8c24dfc9e6c1c322880e
Message-Id: <158560080814.3259.2582456130067082336.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 20:40:08 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Denton <mpdenton@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 21:16:07 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78b0dedd529239332b1f8c24dfc9e6c1c322880e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

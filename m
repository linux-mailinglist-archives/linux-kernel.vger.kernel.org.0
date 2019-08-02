Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616877FE14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfHBQFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 12:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388998AbfHBQFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:05:14 -0400
Subject: Re: [GIT PULL] sound fixes for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761913;
        bh=lkwd5hZ/J31H9R5wqAd5fAWf3X4V+pFtPyXG7oyEk7s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MzuV2+XEsNSEz4p0vPiq447p0jIkCFVk0zTtpYglwigUjR/d5ercDNvoDUA6VdIt2
         7HZk94dzrGKOpka+58jtbLzuKNE8QgmAeGGFf3NmL3h6dOuqXqEs13WfGJyuNhkTmv
         KdMMkVekSQvGYIqFpyXgxiDbm5JTMmEJY0XX9HfY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h36ijsy9r.wl-tiwai@suse.de>
References: <s5h36ijsy9r.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h36ijsy9r.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.3-rc3
X-PR-Tracked-Commit-Id: 5d78e1c2b7f4be00bbe62141603a631dc7812f35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75cdf416b32293dfc348d4c06fcc775ba4dacff6
Message-Id: <156476191325.27663.13270897149053626847.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 16:05:13 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 02 Aug 2019 11:38:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75cdf416b32293dfc348d4c06fcc775ba4dacff6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

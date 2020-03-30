Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCF1984E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 21:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgC3TuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 15:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgC3TuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:50:09 -0400
Subject: Re: [GIT PULL] libata changes for 5.7-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585597809;
        bh=lVH1staHdUc+VWic0ls23crmgogG3F6ST1oi50Hz6uM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LVuBaoWonleUZ9Y0Y9gn9V+KMxtAIwYT5Apt1wyVUgRE4eubNLr3u2Fyr6kug9VeE
         qeiTPQWFbQWPkbk2XQjMWL9sdzY/hmz7SACIuInygyp8/ru7MW3Bu5/wvlVsn/dt2q
         EL/tIu50xyyOesnCWHjml7IrrDc2u/6W/zWBZSWU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d5c6ff8b-f82c-f609-0257-66fb6fbeb331@kernel.dk>
References: <d5c6ff8b-f82c-f609-0257-66fb6fbeb331@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d5c6ff8b-f82c-f609-0257-66fb6fbeb331@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.7/libata-2020-03-29
X-PR-Tracked-Commit-Id: bf89b0bf3038cdc972b563b16c68cee1b8eefb31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a0eb192c01f43dca12628d8b5866d5b8ffb35f5
Message-Id: <158559780904.12131.5857254947142224855.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 19:50:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 16:45:51 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.7/libata-2020-03-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a0eb192c01f43dca12628d8b5866d5b8ffb35f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

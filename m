Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67306681CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 02:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfGOAaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 20:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbfGOAaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:30:16 -0400
Subject: Re: [GIT PULL] Mailbox changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563150615;
        bh=Zv9ABGaIYknfQkHdDopZFT0SK//Gi30nPBOkIjIoGuk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SBY5FEPL53OjVxOKUpBhx0tuO5F39iLFENBxUAr/Qsjl2wwDAuIXFNthTOpAcB/tx
         kiJ2AA97xDPR9ewDWpJtoWnuFAxMjRsJ/avVRbF2ts3f7pMWUhD7VhXcfUTwOjD+3m
         HGX4+I9Sihr4tMifm6eNMyQ4dIFzwnUUXzi+wjhc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2RWBW0054fPLyNMAFX4BQ2FqV2NeAvHe7aHhAuH46dcA@mail.gmail.com>
References: <CABb+yY2RWBW0054fPLyNMAFX4BQ2FqV2NeAvHe7aHhAuH46dcA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2RWBW0054fPLyNMAFX4BQ2FqV2NeAvHe7aHhAuH46dcA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v5.3
X-PR-Tracked-Commit-Id: 25777e5784a7b417967460d4fcf9660d05a0c320
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fde7dc63b1caa6dedf9af7cbf79895589629bc95
Message-Id: <156315061532.32091.8291765980394649849.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Jul 2019 00:30:15 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Jul 2019 18:41:55 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fde7dc63b1caa6dedf9af7cbf79895589629bc95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

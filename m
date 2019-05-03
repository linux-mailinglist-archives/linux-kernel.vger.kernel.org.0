Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74F1320B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfECQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 12:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:20:04 -0400
Subject: Re: [GIT PULL] sound fixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556900403;
        bh=+4C3tXuIzIOfZds15pnBt0vYHhycu3FV4XX679UHQzQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=juwWoHfs5cHCxyNbe8wsg/Msk5Dnd32BNBMyGAd49EcUyAK52S+UbLyRxe4umVdi2
         0emuGhNp0V1RUdl3ffBRccod1MrnS6c12d2Jhc6kBTMBlQCSpxkndzPzlQM+eAWDbJ
         VEMCpT6xoF1cO5Tk3n5Zc8nVZ06bvcVZgt+jteRY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hzho4n1pz.wl-tiwai@suse.de>
References: <s5hzho4n1pz.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hzho4n1pz.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.1
X-PR-Tracked-Commit-Id: 3887c26c0e24d50a4d0ce20cf4726737cee1a2fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46572f785fb41949665ef4665563db5346f7cb30
Message-Id: <155690040360.31408.9235326804129226678.pr-tracker-bot@kernel.org>
Date:   Fri, 03 May 2019 16:20:03 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 02 May 2019 20:35:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46572f785fb41949665ef4665563db5346f7cb30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

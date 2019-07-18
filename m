Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9FB6D260
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390957AbfGRQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 12:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390323AbfGRQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:50:18 -0400
Subject: Re: [GIT PULL] sound fixes for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563468617;
        bh=YmJhX/tMxM3yDYef/MStj63pU5kcSA7S06sIfI4oBP0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OvhGCLeBaiNncrrQsyRFnW5WEGcdX1Vsih2aR+0iWnnthoA9G9vwU7c0BUYP00IiD
         dAtuT+t+jOc+OXyt1gauqa+glfxGlGN6+S04Zjsq1yV5R262A30TkISwyOixu+FFzX
         VLT1BfX3A3NPtGyxDRhIEFX0N4bFm41Ayg/jCi28=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hblxrpsl7.wl-tiwai@suse.de>
References: <s5hblxrpsl7.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hblxrpsl7.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.3-rc1
X-PR-Tracked-Commit-Id: 4914da2fb0c89205790503f20dfdde854f3afdd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ae048e16636afd7521270acacb08d9c42fd23f0
Message-Id: <156346861733.19804.1983223122027489541.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 16:50:17 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 12:03:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ae048e16636afd7521270acacb08d9c42fd23f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

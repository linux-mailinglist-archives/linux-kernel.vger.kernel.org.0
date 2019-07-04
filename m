Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A405FC43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 19:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGDRKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 13:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfGDRKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 13:10:04 -0400
Subject: Re: [GIT PULL] sound fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562260204;
        bh=wUPuiCtsjKFMCYJwXnPf2S8IohnAIH4M9GvNy802eGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=peCfyuGT1OBXfWgwjeYY+MMupoOFhIrCFvqS5ylBKRre+Yjtt8HmLPOIRuXScHdeE
         eMLLoTwCrPY5C7chTTEtyj0iOQcZXV0oSlFrMJPIa1W+hHl37cAnq6sXBDZPM9e7Rl
         1wL0Hf5dlWXdahdiLJDOMI5aAHCNI2CgWKmcSMXo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h8ste2kn4.wl-tiwai@suse.de>
References: <s5h8ste2kn4.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h8ste2kn4.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.2
X-PR-Tracked-Commit-Id: 3450121997ce872eb7f1248417225827ea249710
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c212ddaee2fd21e8d756dbc3c6119e3259b38fd0
Message-Id: <156226020401.21087.4911880582513267664.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jul 2019 17:10:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Jul 2019 11:50:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c212ddaee2fd21e8d756dbc3c6119e3259b38fd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

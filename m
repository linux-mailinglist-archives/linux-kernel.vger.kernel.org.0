Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4428680CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 20:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfGNSpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 14:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfGNSpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:45:14 -0400
Subject: Re: [GIT PULL] x86 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563129914;
        bh=y9kiN+jEQpuAXY2RWeUp57NLwhHJwGEZkeTEZnJs988=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hQi/C7xSATbF3JANvtEz4tVZ1u/5mUhnOwx7fywqBSaHwRXaeZSg2SZiGA5M9U9IH
         zXY6vtqYisSuAgjLhsoDLMG6g2wEO+7WD1w3cVoiBARopueWBXo8fwiwvCP4juyaXd
         KC5Igq3Sbn7UHJXRmzGNeMQQ6uOcekfVvvNosjlc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190714113211.GA11146@gmail.com>
References: <20190714113211.GA11146@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190714113211.GA11146@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: e9a1379f9219be439f47a0f063431a92dc529eda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 577d9460d3d0a69b96f749f974642441ae186a7f
Message-Id: <156312991414.23515.6560879578770207762.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Jul 2019 18:45:14 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jul 2019 13:32:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/577d9460d3d0a69b96f749f974642441ae186a7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

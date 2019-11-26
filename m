Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59021098EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 06:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfKZFkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 00:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfKZFkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:40:08 -0500
Subject: Re: [GIT PULL] regulator updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574746808;
        bh=sBK/YsLtKanUDnDdM39zTec/KpZoHAb9ooAh9Bpl5G0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rRVQGfSPf4b0VjfteObeJOijJADPKagzebDGSfRNGEGgH56agD63mo8pyWW3TK3ef
         cX9Khn1vbNOsn7KjKNdjrbpemQxVYMH7RjxaMgHy2huSwRq5UYb6SQkFNDxPzCTzEA
         URJyoWuNIraDdAi7unxkZ+z9v+P0UCMCarNL5vgg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125132049.GC4535@sirena.org.uk>
References: <20191125132049.GC4535@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125132049.GC4535@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.5
X-PR-Tracked-Commit-Id: a21da94f617bce0771144ea8093b6987184b38d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d873a0cd21dbe2502873feb4b12e3e0ee9a78ac9
Message-Id: <157474680803.3611.6518459029849248865.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 05:40:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 13:20:49 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d873a0cd21dbe2502873feb4b12e3e0ee9a78ac9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

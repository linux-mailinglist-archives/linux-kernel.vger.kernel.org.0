Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73063A87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfGISF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 14:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfGISFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:10 -0400
Subject: Re: [GIT PULL] regulator updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695509;
        bh=ghjBSTXZMw4bhBUM5vo1tj6zKilMYLAktNjcCapsocc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uqU4fGGoos3fC4dMzaI1AkxLjN41TAWegdGgAFqmAgPt8V9oHcj7kO/ISHQ61/Ge3
         X4/kmCjnc8laVhCCDMPtIbucFcVuLNgcsTvmFdWLvT6yand8dFHEznJ8Wa/D0iGGkf
         jTgHSxcVfzscUtZ6kptX6Wiuy70XltZEZ438sz8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708124152.GA12731@sirena.co.uk>
References: <20190708124152.GA12731@sirena.co.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708124152.GA12731@sirena.co.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.3
X-PR-Tracked-Commit-Id: 0ed4513c9a32a479b4dc41685be68edf1e99c139
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98537ee92fb1b17a7f36dcbc8d2e4087af300da6
Message-Id: <156269550972.14383.4746859513517354703.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 13:41:52 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98537ee92fb1b17a7f36dcbc8d2e4087af300da6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

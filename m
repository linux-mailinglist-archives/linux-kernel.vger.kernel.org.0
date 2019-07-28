Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198D27809B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfG1RaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 13:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfG1RaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:30:18 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564335017;
        bh=+Fb/AstsPPb/152WXJWNxzWcmSDViHx0aDjW5JyAh1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xW5sXgtPF3C8w/K4sek/7TH4b2Ltnorn9QHKTPxCx/vWTbywSL5q9DPw8AH+DYGyy
         33AyrJJOOeYe6L4tn3d4bYJfmyB9Jcst2golfHZFTJyr/EG/EbhDV3kkFmsRKb01fk
         NoFAo/uZDx9K4WUkNjB+1D7Ew9JWh3pKoCDTl5lw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190728063715.ensdmo7jyimrsez4@localhost>
References: <20190728063715.ensdmo7jyimrsez4@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190728063715.ensdmo7jyimrsez4@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 7bd9d465140a93c0a21ba2d2f426451c78bfcc7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bb575bcc6d1564340f969c5aa2bff8a500b239f
Message-Id: <156433501738.9558.9696751081969592633.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 17:30:17 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, arm@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jul 2019 23:37:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bb575bcc6d1564340f969c5aa2bff8a500b239f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

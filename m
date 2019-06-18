Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139014A95F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfFRSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 14:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbfFRSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:05:05 -0400
Subject: Re: [GIT PULL] meminit fix for v5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560881104;
        bh=QYuhefQ+JrfaKl735jjxAXSNAG9+JGVvJJYIcDXoH3Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n30nmmCHmOcdnBNFgB0NNyivuTJHgFZboDPcAJ8eH4n74zfL7N8KUif5dWucg+WuP
         8sPByWSPAAVLFXNN3yrBdJjnP3J1Udt9se/Kk1L7lB+c9NFbMjRr+ktqlPuJmvBacY
         FHdi5typyoR0ikegvj5SBL47nqqd1WvbMJUEcL3U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201906172056.CDD757E@keescook>
References: <201906172056.CDD757E@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201906172056.CDD757E@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/meminit-v5.2-rc6
X-PR-Tracked-Commit-Id: 8c30d32b1a326bb120635a8b4836ec61cba454fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 915ed9320cba9ddb5da3f3ee49a8ceeed85fb5cc
Message-Id: <156088110470.27164.8783777065993800077.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jun 2019 18:05:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jun 2019 21:00:28 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/meminit-v5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/915ed9320cba9ddb5da3f3ee49a8ceeed85fb5cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

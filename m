Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D811A67C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfGMWuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 18:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbfGMWuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 18:50:15 -0400
Subject: Re: [GIT PULL] IPMI bug fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563058215;
        bh=XTAr97HZzRYdS0axSSJomw5RNl3p5AQ9Wt3oGdVopY0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uBxr0pcyXyh1Jw5f1EUOtBoX839vnMZdmns4I879K0vqwHldEbLSUWX1lnht2kQ5m
         rUET1RZp5mJtsUKp2LH2RP/TSAp4db0XWJ+1rU7+kOictRZjZicllTDviOhpeh0//A
         lizydaycoyTo1G/3l9KHUVA3VZ3gDkoJkkHc4Jew=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712115204.GD3066@minyard.net>
References: <20190712115204.GD3066@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712115204.GD3066@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.3
X-PR-Tracked-Commit-Id: ac499fba98c3c65078fd84fa0a62cd6f6d5837ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92adeb616c9172dea9678f53ea6e5501fc4f4338
Message-Id: <156305821495.12932.12158249703290312226.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 22:50:14 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 06:52:04 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92adeb616c9172dea9678f53ea6e5501fc4f4338

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

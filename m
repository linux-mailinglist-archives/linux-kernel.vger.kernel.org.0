Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602012679E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfEVQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 12:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfEVQAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:00:21 -0400
Subject: Re: [GIT PULL] arm64: First round of fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558540820;
        bh=J3PVro+tz2J/mbQeKKrLnaYAPBOBsv0SCaa0LR4beHo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2TBjCpcWH97BGuwRPp4pu4Euue4R9o1GoAtLspzNQAAD9y4fzEh/QG8eZPih4U2Fj
         4QORouZbOFCDmSMdjeTtMQVzyQwpVtWywvPbrlqMeNXTMzivmlWTV7NjhF/cNUQz7p
         Az/TV/QBcFyzUrrK5L0WuHKK2j80/O1i5XSVpIYo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190522131102.GC7876@fuggles.cambridge.arm.com>
References: <20190522131102.GC7876@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190522131102.GC7876@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 7a0a93c51799edc45ee57c6cc1679aa94f1e03d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54dee406374ce8adb352c48e175176247cb8db7c
Message-Id: <155854082049.3461.9141870673021713606.pr-tracker-bot@kernel.org>
Date:   Wed, 22 May 2019 16:00:20 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 May 2019 14:11:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54dee406374ce8adb352c48e175176247cb8db7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

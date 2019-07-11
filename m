Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F293D6516E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 07:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfGKFaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 01:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfGKFaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:30:08 -0400
Subject: Re: [GIT PULL] pidfd updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562823007;
        bh=83Wiu5oa/zM+jKgZBRF5tAV0fIyq/2CUtCZ8v5a2Sok=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yyOUJl1ImskoalBR4PDDusTOxHJHCbzjveFo5qsanWY+6heupuF+GB246OJhTsjaW
         KAZO6nGeNaixur9FWMyYHW+MTR0PuDkpGc0S9PKZW/iNVVHxm1sFnilKaSOF3Lwgf+
         fnfpIZYhVYpsguz5x7uCUgELg4WD97i/cini6zJ0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708135423.5309-1-christian@brauner.io>
References: <20190708135423.5309-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708135423.5309-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/pidfd-updates-v5.3
X-PR-Tracked-Commit-Id: 172bb24a4f480c180bee646f6616f714ac4bcab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5450e8a316a64cddcbc15f90733ebc78aa736545
Message-Id: <156282300750.30654.6459014383670259565.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 05:30:07 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Jul 2019 15:54:23 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/pidfd-updates-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5450e8a316a64cddcbc15f90733ebc78aa736545

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

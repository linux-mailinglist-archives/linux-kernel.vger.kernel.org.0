Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76F13972F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 23:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfFGVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 17:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbfFGVAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:00:13 -0400
Subject: Re: [GIT PULL] hwmon fixes for hwmon-for-v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559941213;
        bh=DEB6rxrxE4Pk007HFmygcb4gQ6NM6zTB9Vt7DEB2APg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dmZItiCXVUkLsXLEvA2IKkJ+M/0Hjg4PAsxOXAywX/9HPwh4b7c5Zx8c2kET3pKFP
         JYFKp4x4acC0rlQ7Sm7nb3pTd2bbMDmhjkwdyqqTvH0jXQeBdKiDPgSZY622L04Zlw
         nMnr2b6ir+ZUKEqxobVdtxtOYCs0bThSIKcDEu5Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559938508-12610-1-git-send-email-linux@roeck-us.net>
References: <1559938508-12610-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559938508-12610-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.2-rc4
X-PR-Tracked-Commit-Id: 4a60570dce658e3f8885bbcf852430b99f65aca5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4425649c63018e96e5402807c9e7bc5272f7b3b
Message-Id: <155994121319.4194.15465585918583975195.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jun 2019 21:00:13 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Jun 2019 13:15:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4425649c63018e96e5402807c9e7bc5272f7b3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

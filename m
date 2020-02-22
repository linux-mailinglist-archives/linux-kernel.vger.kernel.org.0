Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D06D2169199
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 20:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBVTpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 14:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVTpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:45:16 -0500
Subject: Re: [GIT PULL] hwmon fixes for v5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582400715;
        bh=fnAEdgXlAAGVIaCoAr2Upcp2vcWpQp2WQ3pdD8PDYDE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fqlzIwkWlDCg36gHLJ8zTk0sSaiUy2HxiuEecBBT+OVz8U9ZiUfZnmF3z4/U2rzWB
         NmQo+ggqJxdEwn1YqpLxzT5m7gScSFkXkeDWq1iKjHx74p90rVuqtguWeKNMCr9NSA
         BQMVvEF9bHOEIGBYAjDX7FJivRhVTM4QZo4dfl4c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200222015937.3949-1-linux@roeck-us.net>
References: <20200222015937.3949-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200222015937.3949-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.6-rc3
X-PR-Tracked-Commit-Id: e61d2392253220477813b43412090dccdcac601f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b442b1a4e9a19def99309b9831e276c21352ac1
Message-Id: <158240071559.14316.12612710477961221244.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 19:45:15 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 17:59:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b442b1a4e9a19def99309b9831e276c21352ac1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392E111EE3A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 00:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfLMXKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 18:10:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfLMXKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:12 -0500
Subject: Re: [GIT PULL] arch/nios2 fix for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278611;
        bh=7qzk3HQAeyJ3JJ09iWWj9q5Ehzl36kM4bhYgUdLpx1Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JMawh/oNlSfP1F/WDku90CV1oez/35ooHoBNSxgl0eXQJJn4sTDRByRTKjpNlelY1
         +qAkRadSoT+5O/aHmUQkJyXyDewa9tEwBC7aqX9/H5GHgKAUZ6IeMD1GCmOl43YBXC
         HJSkV2Mv0MOEse8xTgR73xgZDcy94UMMvVDV6azU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <MN2PR11MB4509EB06FE5B942083D9E097CC540@MN2PR11MB4509.namprd11.prod.outlook.com>
References: <MN2PR11MB4509EB06FE5B942083D9E097CC540@MN2PR11MB4509.namprd11.prod.outlook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <MN2PR11MB4509EB06FE5B942083D9E097CC540@MN2PR11MB4509.namprd11.prod.outlook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
 tags/nios2-v5.5-rc2
X-PR-Tracked-Commit-Id: e32ea127d81c12882f39c2783d78634597ff21a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e31736d9fae841e8a1612f263136454af10f476a
Message-Id: <157627861163.1837.10202656917767790959.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:11 +0000
To:     "Tan, Ley Foon" <ley.foon.tan@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "'lftan.linux@gmail.com'" <lftan.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 08:24:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-v5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e31736d9fae841e8a1612f263136454af10f476a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

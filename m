Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31573BD329
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 21:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633281AbfIXTz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 15:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfIXTz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:55:26 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.4-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569354925;
        bh=Nwk7yTMFu7wBQs0O/oL+33h9d2L601t6C/W54dHxXLU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X4GS/gjEY8BZqQxKOXEh9SAPL14go/xgw76rATajFTEF1EcRrXvhCrq4NpY/NwHpj
         JFQriXbmga6f9SQXn1LpezldB7FtWadM4VYcZHJ36fuICkRTf7yVds6HhWoVUgzWI1
         T27w3OVYM88pDFkC5ctSPKdl6r0hdW0hxixH4M5Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190924075634.GA25010@smile.fi.intel.com>
References: <20190924075634.GA25010@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190924075634.GA25010@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.4-2
X-PR-Tracked-Commit-Id: 24a8d78a9affb63e5ced313ccde6888fe96edc6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baff384b0e90132be4b623a9406ba84a987ed036
Message-Id: <156935492570.15821.14646616504823287242.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 19:55:25 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 10:56:34 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baff384b0e90132be4b623a9406ba84a987ed036

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

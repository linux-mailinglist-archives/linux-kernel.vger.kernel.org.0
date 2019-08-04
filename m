Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4E8808D7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 03:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfHDBzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 21:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfHDBzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 21:55:11 -0400
Subject: Re: [PULL 0/1] xtensa fixes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564883711;
        bh=wSG6jf9T+ocPDPBrS4p+orC3jQ6/dpbATN0xmdl2mkI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NXj8bdSnfGDi6R8ol91F0HzQfVagXJo19JgMnGwPCdnbnukdl6YulzN024mGqSP6r
         lwRj/4ALpBiO9OSRYeBGH7G8EvWsBVHuYgoUoKduTZ2rl46lU2jY21quuHlY+laCva
         hRdkDeMpxr5PCEsQ4To1P051XPmz2fxO00S7zJAg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190804003317.15370-1-jcmvbkbc@gmail.com>
References: <20190804003317.15370-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190804003317.15370-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190803
X-PR-Tracked-Commit-Id: e3cacb73e626d885b8cf24103fed0ae26518e3c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8778f13b73f1cde08be0ece18571dee495b92f1
Message-Id: <156488371119.19418.14198023350636017348.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Aug 2019 01:55:11 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  3 Aug 2019 17:33:17 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190803

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8778f13b73f1cde08be0ece18571dee495b92f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

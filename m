Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5231A829
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfEKPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 11:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfEKPAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 11:00:13 -0400
Subject: Re: [PULL 0/7] xtensa updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557586813;
        bh=QA0PShJmYlKwQyE20qCBI+4puVLfPWAGy/vrfmfZ9ZY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WbzNIfJSSeiRvbqCsP4Ll1faiUJhKpn8PIJ3SNLuIB2stRlW6K1NhrK3nCLR11VoS
         cWlPZGoRWeAdKCdGhqljOGjsZoxPjRLEIxWmQp9MgRsSEKgXAAYmH8hb151rv942tC
         TUdVSW2GzQkfZFNfYqp7O0GZbphYHihfxfGc1NNM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190510194102.28038-1-jcmvbkbc@gmail.com>
References: <20190510194102.28038-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190510194102.28038-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190510
X-PR-Tracked-Commit-Id: a5944195d00a359e28d6e093593609bcee37ed5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a5575212ce4b6a41581b92fe03b6be1134793ba
Message-Id: <155758681294.22634.7903550328568319202.pr-tracker-bot@kernel.org>
Date:   Sat, 11 May 2019 15:00:12 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 12:41:02 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190510

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a5575212ce4b6a41581b92fe03b6be1134793ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

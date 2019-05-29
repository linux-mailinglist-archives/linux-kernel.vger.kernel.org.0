Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD12E796
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 23:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE2VpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 17:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfE2VpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:45:15 -0400
Subject: Re: [GIT PULL] Fixes for sphinx 2.0 docs build failures
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559166315;
        bh=MslAkn0MjKtReq/x6B4kRuRZHNL2td+pBIK0ZIkcHME=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sIZqpnZVbBRDbZma5yyNI9XS7j8ZM5fZw2Rl+q440CLzSqv3/8XSjnwPr4vNoTMpW
         2Bqnwzmwqd9dR6AJSwgzX1shvSmWBKMFgip0IdFJ+ewN9gotLvt9qRDaU/WD3ASEvd
         tGp3Ik0XlJ2aeMim3VTHLL+sgg0OHO0CvhcZa3dM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190529095408.1429a5ab@lwn.net>
References: <20190529095408.1429a5ab@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190529095408.1429a5ab@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.2-fixes2
X-PR-Tracked-Commit-Id: 551bd3368a7b3cfef01edaade8970948d178d40a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bec7550cca106c3ccc061e3e625516af63054fe4
Message-Id: <155916631500.28954.14280541442507821303.pr-tracker-bot@kernel.org>
Date:   Wed, 29 May 2019 21:45:15 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 May 2019 09:54:08 -0600:

> git://git.lwn.net/linux.git tags/docs-5.2-fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bec7550cca106c3ccc061e3e625516af63054fe4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

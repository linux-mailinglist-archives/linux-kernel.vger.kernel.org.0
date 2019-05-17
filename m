Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC021D64
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfEQSfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 14:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfEQSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:35:23 -0400
Subject: Re: [GIT PULL] s390 patches for the 5.2 merge window #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558118122;
        bh=VoGK9ugXAvUb9OiFUQ4ljWBVnyOBgjxMz6gOvmlvG/E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GA5OXeFRIZEp8+zdeJONtgkW7h02csThj81nm819mpl4Kjt97fN2s2TuxR0iPPZFy
         KdCl/qy1tfHg48XizKCoCS+ltlI2JTfHlQAB/XfTOPzqiPk92xbvPUH1Gq6GK84RqU
         4WEIac8FTj2MMT7OZOUHnEg9gf1ko7/YSxM+rTo8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190517085854.7be56501@mschwideX1>
References: <20190517085854.7be56501@mschwideX1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190517085854.7be56501@mschwideX1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
 tags/s390-5.2-2
X-PR-Tracked-Commit-Id: f3e20ad67b4c8365df9818fd3c8026e105d6b53a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80111bfb672d8c04d60c25559243554f732f2848
Message-Id: <155811812256.11644.3744838964746899125.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 18:35:22 +0000
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 08:58:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80111bfb672d8c04d60c25559243554f732f2848

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

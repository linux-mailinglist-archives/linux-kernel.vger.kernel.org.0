Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26CEB9796
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436672AbfITTKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 15:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406842AbfITTK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:10:27 -0400
Subject: Re: [GIT PULL] Hexagon arch maintainer change
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569006626;
        bh=TGXgCr5SzF0uiSfCQafY5H/T+5sJuBCo6ogXQMYyJ8M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yIZG6d9/WRVTBMpvlF4SrDyeUDWOBEyTPJvNrU3RyP0vsyNcEQHLvirbq+i8fGR7c
         SYuUrF8mt3aEQKRNciWDj2ej6GZNpdoPuIxSGQg/Hxb6SivMsNq0qGyC53zonJ8uDO
         Hhwi8H3JFV3fY3urbf5JUozPZ7jlGp4P//o9yUPU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190920020427.GA7719@codeaurora.org>
References: <20190920020427.GA7719@codeaurora.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190920020427.GA7719@codeaurora.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git
 for-linus
X-PR-Tracked-Commit-Id: 18dd1793a340f8216e22c9295c0c7b95cdae1783
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb736a5c0e9a2605f11c2bbb60a68f757832da32
Message-Id: <156900662668.23740.2725582904267103842.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Sep 2019 19:10:26 +0000
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org, bcain@codeaurora.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 21:04:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb736a5c0e9a2605f11c2bbb60a68f757832da32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

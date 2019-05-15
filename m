Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A301FCF5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 03:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfEPBqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 21:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEOXyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:54:21 -0400
Subject: Re: [GIT PULL] ktest: Updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557964216;
        bh=Oi6pljO7qro9G22/ILfgQPC40WJKRUY6nGH93SqfQqQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mz3KQNTuc9Qg+df9b3fMIOfTByoLMorAKrK5/Hh7S2sipKM8ZRgjhhuBDZbbgYmf3
         mz9PMb1LdBY5FoiLrnRVdebvl9IHEAKVpvfxdBEEwBUYy0qNy8rTj90DQX7fhx/5Ib
         e5qS3O1QF23ry7FGfUNJjkkS9E6kgd3sFDM6Y9o4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190515135602.2a6e6012@oasis.local.home>
References: <20190515135602.2a6e6012@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190515135602.2a6e6012@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
 ktest-v5.2
X-PR-Tracked-Commit-Id: d20f6b41b7c2715b3d900f2da02029dbc14cd60a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b06ed1e7a2fa9b636f368a9e97c3c8877623f8b2
Message-Id: <155796421651.28278.7215838280159174377.pr-tracker-bot@kernel.org>
Date:   Wed, 15 May 2019 23:50:16 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "John Warthog9 Hawley" <warthog9@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 13:56:02 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b06ed1e7a2fa9b636f368a9e97c3c8877623f8b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

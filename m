Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE6280C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 17:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfEWPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 11:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbfEWPPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:15:19 -0400
Subject: Re: [GIT PULL] Documentation fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558624518;
        bh=g18uDpN4wjNgqWZ6HoSbbuJ6T1Hz8FXR2qoD0WcFl0g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XbKG0mjszbHIHyRlXMoDmk7qW+q8q5WuHvwXJyiQwwyTGbeOUQaJXaMn5Yu2RtgOo
         zFOJsH/rgjuNVW/4FdglTsIMmqLtQkGMeiqEFc6NwfDHUPjLszzWkjn7zRXHKpLTdn
         zmzPwtJAU4b7KrUwIA/TEF40cWY56ntEBqoUthXk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190523084805.63901c65@lwn.net>
References: <20190523084805.63901c65@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190523084805.63901c65@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.2-fixes
X-PR-Tracked-Commit-Id: a65fd4f0def56f59822b2c49522d36319bc8da8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61686afe1ff378021da4e5509d081fb5196212d5
Message-Id: <155862451883.19073.5953586668759128539.pr-tracker-bot@kernel.org>
Date:   Thu, 23 May 2019 15:15:18 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 May 2019 08:48:05 -0600:

> git://git.lwn.net/linux.git tags/docs-5.2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61686afe1ff378021da4e5509d081fb5196212d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

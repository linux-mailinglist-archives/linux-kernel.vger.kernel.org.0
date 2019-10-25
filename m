Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6FE55FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 23:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfJYVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 17:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfJYVfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:35:06 -0400
Subject: Re: [GIT PULL] Modules fixes for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572039306;
        bh=3fM2FA6QG8rgWV+HZ9oJh4rrxUuqc1MlGZpz7vRt5BU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XqOcmoBMtpbZUJa6drmYyTRZNyMd30nlf7jcJ5a9WKIP618TvszYMHbvnrlNqH/db
         Iz7koeLfMb55twmISzNaNbmTF7gQFd6eTC9O1hjJCbNYhzfq14VI+oHC4LFF77zhlt
         fTPmuHUBiZ/80B0D/b8ipXxLFmVwdmhKgnwSoTOY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191025155512.GA30503@linux-8ccs>
References: <20191025155512.GA30503@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191025155512.GA30503@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.4-rc5
X-PR-Tracked-Commit-Id: 09684950050be09ed6cd591e6fbf0c71d3473237
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e2dd2ca85d211a6ef2a1e95ba9239ec69959b1e
Message-Id: <157203930606.23557.2041549109544035521.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Oct 2019 21:35:06 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Oct 2019 17:55:13 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e2dd2ca85d211a6ef2a1e95ba9239ec69959b1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

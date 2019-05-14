Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095C31D05E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 22:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfENUPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 16:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENUPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:15:15 -0400
Subject: Re: [GIT PULL] Modules updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557864915;
        bh=oE3NcVUGH7x6d12zcqbTI5MKlpQyOUmc09VxLkwOeJU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FxuZ7lqHijuAqNp9MRDDyK2DoHUvgBpaIJWWywwR1LzY2n6W9V4rGRtZt84z6BN4K
         cI8hI9wksXxYuwZdfxNFbtC9GVKft7WXA6TpapZMJgLyWV6j9Xh9ICLD5uwU5YatkC
         l4iU2DneaStcJZpa7Vn+POigq7mJKLOeiVlNoq+c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514153746.GA4533@linux-8ccs>
References: <20190514153746.GA4533@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514153746.GA4533@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.2
X-PR-Tracked-Commit-Id: dadec066d8fa7da227f623f632ea114690fecaf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 280664f558c9d973315d48f125eb664cc607d089
Message-Id: <155786491524.29168.2926770091125486218.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 20:15:15 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 17:37:46 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/280664f558c9d973315d48f125eb664cc607d089

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

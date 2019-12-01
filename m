Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CB010E014
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 02:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfLABkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 20:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfLABkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:40:19 -0500
Subject: Re: [GIT PULL] SELinux patches for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575164419;
        bh=3jlGckcHgAZaUPAAPuHE7bUbtklXkvqHWWqPOkYygX4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WWZCb7KMF4FjNOqemMeWDEhU1rGw/OfE86SSC7EK8jLW7UqzPHWoD9nmuAB8DzIXG
         0V3IHpt/86XmPppYICx/vo3IpaIJx1HDwslH0zfIhZIjzQKNAMm5kDWyjOeacfrQcK
         zKfTEauoj4MSvWy1U267hk6rN2nzqoj+pLHxwpwg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
References: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20191126
X-PR-Tracked-Commit-Id: 42345b68c2e3e2b6549fc34b937ff44240dfc3b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba75082efc18ced6def42e8f85c494aa2578760e
Message-Id: <157516441909.28955.6196919876049308492.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Dec 2019 01:40:19 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 16:24:34 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20191126

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba75082efc18ced6def42e8f85c494aa2578760e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

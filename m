Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8DB19B884
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbgDAWfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 18:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733235AbgDAWfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:35:19 -0400
Subject: Re: [GIT PULL] trivial tree revival
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585780519;
        bh=VZV3D+gMpVWU+yvRGORxE0gOzY23IMBcs54jrGXfU2k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AKvpd+WRR8iEomU1VriQPRFKEt4zleT88Ia9A9S/2tj3PwU2e2wQ2b8lmR4BQGc0F
         B2YQenW2nOhj4D5xfJhLRDm7XiWUbCfXxkbudK+q/OrYEzxkxaZLrYh8yDlW8wyBCz
         lrfsBncfTtNUaDQU1PawMzr87+7N0QDTIe65GNeU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2004011221220.19500@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2004011221220.19500@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2004011221220.19500@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus
X-PR-Tracked-Commit-Id: fad7c9020948eab2bc4661eade4e1ef357279590
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69c1fd97266bcdcfdba1e3ea57773c80e0551e1a
Message-Id: <158578051939.24680.13386569440976844087.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 22:35:19 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Apr 2020 14:11:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69c1fd97266bcdcfdba1e3ea57773c80e0551e1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

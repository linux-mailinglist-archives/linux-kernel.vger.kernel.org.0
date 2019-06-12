Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE45741A20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 03:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437077AbfFLBzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 21:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408338AbfFLBzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:55:13 -0400
Subject: Re: [GIT PULL] Minor ptrace fixes for v5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560304513;
        bh=mjpZy/AXm9YfznLfbotCtjfRbleaCjIRMqbO8WDfh70=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KeQ2dZWSNXS5341KaDgyM4gY77EDlRxXcGznim6yMmq4Fr02ng9n0YQhbvZYKJm+p
         YcIkmOfyHFFi3PTlf22evlrIUryOyUjTj7qy1ikqFTCb00rznBIMZqZ6Scd7DE71d9
         CNBRsbW+4cK+AWfQHBDad9Q9JSP7xBJlDpUIAj7k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87d0jj6fcw.fsf@xmission.com>
References: <87d0jj6fcw.fsf@xmission.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87d0jj6fcw.fsf@xmission.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: f6581f5b55141a95657ef5742cf6a6bfa20a109f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa7235483a838be79b7c22a86b0dc4cb12ee5dd6
Message-Id: <156030451320.13515.9066573219794161403.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jun 2019 01:55:13 +0000
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jann Horn <jannh@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jun 2019 15:23:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa7235483a838be79b7c22a86b0dc4cb12ee5dd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D083D1728D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 20:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgB0TkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 14:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbgB0TkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:40:11 -0500
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582832410;
        bh=eeGY8AZSjPCnOpimAQU2I1rDi2xJnAqsvj8R6nJOjkI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X/jcEblP05yjuurtKjnCWcvbD8AEd+kFEftr81zz2ueegOXXIKrmRdb7+nXTA9E0/
         ehJuVU36iGDc3tGbpUanzeLJhAlo/qFaF3NVigXwqd2xjJdEXbBxPEhbV6pGNXjk7N
         6smNLkwI9PP+gRMn0xelyVFKqocSnzzvY9BtKvWg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2002271539500.13129@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2002271539500.13129@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2002271539500.13129@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 4eb1b01de5b9d8596d6c103efcf1a15cfc1bedf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 278de45e145bedff90072fb47bafdde8393f6a80
Message-Id: <158283241070.25748.16506674996473659207.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Feb 2020 19:40:10 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Feb 2020 15:46:10 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/278de45e145bedff90072fb47bafdde8393f6a80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

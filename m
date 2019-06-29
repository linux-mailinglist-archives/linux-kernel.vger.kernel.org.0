Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822B15A9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfF2JaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 05:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfF2JaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 05:30:06 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561800605;
        bh=WOXdSCgush3mp6rcNJHNy5t/NBk55YbPt/Uh/a/K8rA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MJBVyBZhwW0dAKH/SSGiDOJs3lOzoCYRcE8GVIalsZ3zA86oKViJNUC6rIdgXnoR5
         T1jsXdmuKFBSil96HN1/+qfzd+6NUT51WbRuWL+MA4iR69Si7xO9Apt+NFPy8V5xLA
         KkX0dppNXWKvKnD60vcVQwtlUyd8z6+rdHfpaAYQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1561765703.5883.12.camel@HansenPartnership.com>
References: <1561765703.5883.12.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1561765703.5883.12.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 240b4cc8fd5db138b675297d4226ec46594d9b3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b607ba862f30364aef0b0d40cab8afccf339616
Message-Id: <156180060583.8003.14079749695911722306.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jun 2019 09:30:05 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jun 2019 16:48:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b607ba862f30364aef0b0d40cab8afccf339616

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

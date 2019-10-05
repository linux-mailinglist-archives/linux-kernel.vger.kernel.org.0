Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748F0CCC9B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfJEUFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 16:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730251AbfJEUFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 16:05:15 -0400
Subject: Re: [GIT PULL] s390 updates for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570305915;
        bh=x7JPyWWJhrdReGlFj1qxp9eF+z9sqZtXBoqnvKzlS4o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zbm+QHotPBV9BJuSWEokLR80h9ugHebKvBH4SGDGUGSCpoGT6WaeMwJH+OUVg8R3t
         qKJERZPm/3h3w7aePM+lU/UoYFduKmt8YDoDXI+fJmijYgrpCOI4hC6ChTHtDIXI1u
         Kdt0pirpc2ydQFGa7oFhtTdN2IDvoALiAvLDd1aU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01570289927-ext-8803@work.hours>
References: <your-ad-here.call-01570289927-ext-8803@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01570289927-ext-8803@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-3
X-PR-Tracked-Commit-Id: d0dea733f60efe94257d08ae6eba81d0b511d0a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fe137cbe3e85e832a169006e8ccc04cec69c653
Message-Id: <157030591509.15791.7129034655610056115.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Oct 2019 20:05:15 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Oct 2019 17:38:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fe137cbe3e85e832a169006e8ccc04cec69c653

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

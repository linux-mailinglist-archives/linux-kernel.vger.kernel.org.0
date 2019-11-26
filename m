Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A571097B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 03:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfKZCPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 21:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfKZCPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:07 -0500
Subject: Re: [GIT PULL] s390 patches for the 5.5 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734507;
        bh=h1+F+15iNGGX4G0VVVe6jgc4JrvqxHwofHDMEVz1ARo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VJTfdUknhHh3o22Ylc5DFXVyUoitR62aza9xOqKXOgX8gh7YSCPJcXhAzwiJOFBA6
         hAcEXaGgdaoPyxIQHeVNhgNk4YkjX9X7pcntyhM5UX+5Py+W35OkFSjlZtfnf9MUiQ
         HfJNskCrqi43CVWMxMvz8ZDbCB/ky4H8MNhrlnno=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01574603069-ext-2920@work.hours>
References: <your-ad-here.call-01574603069-ext-2920@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01574603069-ext-2920@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-1
X-PR-Tracked-Commit-Id: 6a82e23f45fe0aa821e7a935e39d0acb20c275c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea1f56fa16ae5f6e67f6ea03836b36c6053d33d1
Message-Id: <157473450729.11733.10102064051560382334.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:07 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Nov 2019 14:44:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea1f56fa16ae5f6e67f6ea03836b36c6053d33d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E303A1DE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfFHUKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 16:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfFHUKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 16:10:11 -0400
Subject: Re: [GIT PULL] SPDX update for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560024610;
        bh=tH9RjHXXGpXJlmuMkC0qU3pLzRWA7EPKyEHxF0fqZos=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zOk4OLmRiPijemklcmRzgeXnwZFSSBgRFB5MvybOwS1Np7LstlIKxJa7W9T4IvkBR
         rlwIvNQx6lkMfefGTNrNQRCjiqXOlnBcWZ5Bal6VlsbCjakBCeO50Q2Tg+bMa2KMlN
         3bsxcxbRsKUkGnrNjkP6FygX/1uTeOOC0DUGTQo4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190608095800.GA27582@kroah.com>
References: <20190608095800.GA27582@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190608095800.GA27582@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/spdx-5.2-rc4
X-PR-Tracked-Commit-Id: d925da5c7b09a27b7b775647925207a383f6524e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9331b6740f86163908de69f4008e434fe0c27691
Message-Id: <156002461051.1563.12597975837397129029.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jun 2019 20:10:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 8 Jun 2019 11:58:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9331b6740f86163908de69f4008e434fe0c27691

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

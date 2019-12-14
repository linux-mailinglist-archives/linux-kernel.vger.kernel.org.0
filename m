Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E267C11F49A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfLNWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfLNWFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:15 -0500
Subject: Re: [GIT PULL] Staging / IIO driver fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361115;
        bh=Ak2F40sfzLCZkyR9X63W4auf9PESgifkXcU8GQc0M5M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t1oNWebRjgWC+WdJzEdwGQKTtIhT023Yjv2CG1Aw6MG3L23if36alcanji3ErwVZX
         KhvE7V26ClzKuK28ZKMqFQgnr6Hzles1vDJEYElJS7FvgB6WQzETNrLIIMs6GMPZNl
         eDeLSxLxHODKwpeJ6/bZWBNonFp8dhC4ml+me9gk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191214152748.GA3460096@kroah.com>
References: <20191214152748.GA3460096@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191214152748.GA3460096@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.5-rc2
X-PR-Tracked-Commit-Id: 4bcd9eae731083bb724faf68cce6021213308333
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aff2a52507bfeb4d44d6a69f6f8d7ca3bcb9b50d
Message-Id: <157636111520.10255.6588362877957671815.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Dec 2019 16:27:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aff2a52507bfeb4d44d6a69f6f8d7ca3bcb9b50d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

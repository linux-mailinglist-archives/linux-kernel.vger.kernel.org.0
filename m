Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD111986D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgC3VzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 17:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgC3VzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:55:10 -0400
Subject: Re: [GIT PULL] Driver core patches for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585605310;
        bh=8FhII9O8nWE1pedW1h/k99DQaUsXkfm+Jn6T6dSXKo4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DEdEvhvq6c5FwZaLlqTTxUp2KcHZyXly5GciRYYua1uzwPxpr4Nr/pV2KPa90G9Gy
         Oy0S1q/8Cj17s2BzCYB4NREYlEsPravdlwO6TiOLbSRf7pTqr/qP3utXW8w5BqVis2
         yPaRShlPE8NstTU4ZDt9cilw1u9bpqLt2RRbeKgo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330104456.GA739463@kroah.com>
References: <20200330104456.GA739463@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330104456.GA739463@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.7-rc1
X-PR-Tracked-Commit-Id: 18555cb6db2373b9a5ec1f7572773fd58c77f9ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59838093be51ee9447f6ad05483d697b6fa0368d
Message-Id: <158560531025.23211.4168004976283158247.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 21:55:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 12:44:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59838093be51ee9447f6ad05483d697b6fa0368d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

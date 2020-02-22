Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF6F16919D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBVTpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 14:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgBVTpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:45:17 -0500
Subject: Re: [GIT PULL] s390 updates for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582400716;
        bh=Em+sT1SMzyjmdINk0tNXrb0+vPJpCDDA2MklK1/1JyA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JJE9JQAO/N3sC1j4SRywDKO+gqvA10xr7RtdmBcquLcpnHCfQ2dtbstZFJZ3/UWf4
         W1fhNLlUogr6nd2upNssRRpKUrUy2crCJP4Ur5YMB4VMMEVLI84d9K+fisFAnelWjk
         /K6gjBlPEENTxQCtDpV7vkIPy/MOBwOYyqt/xNjU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01582376640-ext-7410@work.hours>
References: <your-ad-here.call-01582376640-ext-7410@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01582376640-ext-7410@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-4
X-PR-Tracked-Commit-Id: 2db01da8d25f0420c411e788a9e1ba39269ae37b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 591dd4c10146e541b9f7a461cb6b638ab313718d
Message-Id: <158240071680.14316.8252252024374039390.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 19:45:16 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 Feb 2020 14:04:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/591dd4c10146e541b9f7a461cb6b638ab313718d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

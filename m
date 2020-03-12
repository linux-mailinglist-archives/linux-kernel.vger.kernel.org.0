Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE39D1836D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCLRFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 13:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCLRFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:05:06 -0400
Subject: Re: [GIT PULL] IPMI bug fixe for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584032706;
        bh=U3+S7HNaphrVFoVoaeXcvW9IXmqlilgkeBTvOWa7hsA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kZZPegpDjsmLIdLaPDm8q8SXhbcMFGmAkwyqD/8N2DVciD0draWEECs5uW/Z45dzs
         oKhXtYs0DVGhHsAcc1mRijiyje4lvuohLJtG9EahlpUEE53Cp3lZihwHgct/dXL+GJ
         dyxpusDaWkW3qMpZOy+kQvOFZ6b665K00SBwdp1E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200312022208.GH2822@minyard.net>
References: <20200312022208.GH2822@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200312022208.GH2822@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.6-2
X-PR-Tracked-Commit-Id: 443d372d6a96cd94ad119e5c14bb4d63a536a7f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cc6e2c599cdca573a8f347aea5da4c855ff5a78
Message-Id: <158403270637.17459.5688278772956631461.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Mar 2020 17:05:06 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        John Donnelly <john.p.donnelly@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Mar 2020 21:22:08 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cc6e2c599cdca573a8f347aea5da4c855ff5a78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

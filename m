Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0214D0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 20:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgA2TA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 14:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbgA2TAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:00:09 -0500
Subject: Re: [GIT PULL] Staging and IIO driver patches for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580324408;
        bh=NojsvvfSlAbqmtV9iKY4aDpuda6Ex13CjD055Dor5k8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pj1CZzNbJ4jYM+E9esgllPBAElLV3M7EXztDl8QW2w0Nd+d914LzWdrVoHmiOCamR
         Uzs1effcl//WqkYqMMUv2/tw7Zfcq++Y+iDxtMweUPrY52xnIurzrIZhc9xxKRKguj
         250u5lCeKABjEcBp7bbILpmBXhS0aDSKpPI6jGPo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129101441.GA3858429@kroah.com>
References: <20200129101441.GA3858429@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129101441.GA3858429@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.6-rc1
X-PR-Tracked-Commit-Id: fc157998b8257fb9cfe753e7f4af1411da995c9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838
Message-Id: <158032440891.15518.7902918717751453269.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 19:00:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 11:14:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0367D313C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfEaRZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 13:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfEaRZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:25:15 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559323514;
        bh=Lv2wQgxrvyQmga2236AJletIBriQxwIocy97b4RHC0s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AyD+fv3xGQSdFrkiksHs2Z4tTTQg/FoXGnDwXNymiUzLW2gKddZw5aZ84czRUY4HA
         MUtMPy38lJTGY5ARdhDXElGwMfd40XsxG27w2DvJ7PKrtHLt6qd4HaBdXIwzkI27Ee
         jesD4QzHX1ztrhLyHmNYYJl3w0iVsVcsrflXoChk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190531014732.GA30765@kroah.com>
References: <20190531014732.GA30765@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190531014732.GA30765@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.2-rc3
X-PR-Tracked-Commit-Id: e61ff0fba72d981449c90b5299cebb74534b6f7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2209a3055d6f366eeb070c217491afe855d3f389
Message-Id: <155932351464.8550.1690080308843463434.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 17:25:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 18:47:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2209a3055d6f366eeb070c217491afe855d3f389

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

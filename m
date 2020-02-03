Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5021F150991
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgBCPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 10:15:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgBCPPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:15:17 -0500
Subject: Re: [GIT PULL] MFD for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580742916;
        bh=c9hSKnKoEcv0k8tn1BP2oym63Lm3MvjpVR2mCoEVNZ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oD2K8mNmnVQDoztjPvMyQQHYBtTD2pxI2qdDwzhj/dzr5M13DyF65EZE6CQ8UvZz8
         jk8v9CqwBAKRwyIZD/0nXxAEW/RY1ygvn/ElvIDNC+qWIiBXJZKW0J38MGuiJe7NK8
         D6D6Fk0NEXHw5X/NGeCHytAEhjnfyovOuWVgQHmM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200203130516.GB15069@dell>
References: <20200203130516.GB15069@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200203130516.GB15069@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.6
X-PR-Tracked-Commit-Id: 5312f321a67cfee1fe4de245bc558fa857dce33b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af32f3a414d340b0ab92e88ffb80a19632ff345e
Message-Id: <158074291648.25778.9105181832835191217.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Feb 2020 15:15:16 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 13:05:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af32f3a414d340b0ab92e88ffb80a19632ff345e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

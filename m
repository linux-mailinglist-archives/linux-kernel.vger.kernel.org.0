Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879F211594F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 23:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLFWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 17:25:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLFWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:25:25 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575671124;
        bh=eRxapAbelD6uKe9e77ymR6p/MCG0vsyIirL7CXLY+NA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HteRva5oDvFc2otlfSu/xLl0cragRHX/sMP59CoSe2r+qe2LrL+wmrjQHIzX220na
         /Lsetmf9/XN5jzsa4MHw3udpnsHY01YoHm/zRA9pBYynf+ntoELqAnQ15L33vDn+5D
         Wfn9AC8lmXjxgsq6G3YSvVFXjo/fRnMeBNmxVc/I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206205358.aifwgtflryjf6iao@localhost>
References: <20191206205358.aifwgtflryjf6iao@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206205358.aifwgtflryjf6iao@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 30f55eae47e4ad1b64d692865e6a4277447a33df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 347f56fb389012e8ba7b391d35d109eb16773e3b
Message-Id: <157567112489.16568.3382904736188437778.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 22:25:24 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, soc@kernel.org,
        arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 12:53:58 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/347f56fb389012e8ba7b391d35d109eb16773e3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BC1140281
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 04:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgAQDuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 22:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgAQDuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:50:03 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579233003;
        bh=no0a+AT2CvpfOB5DdKXjn3tkmD8/Bmsl9wC8XUkQRqg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jcv4bjFWjIOfXoTMza14X6aLq92NnjER+eGnS3Hk42euYXxPU56VwGoB1SA9lDbH7
         255MFrIhJKu76hIQTLTMyh4uKC9O/ij0+u8RFo5K6CkyqR/f7MxmlS3wMzp4cyLjRE
         HqWuWQgSROi3qcB17JqCPmYRU6rIs+sfzaZAwSYw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200117030040.5m3qqibo5kn6x3le@localhost>
References: <20200117030040.5m3qqibo5kn6x3le@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200117030040.5m3qqibo5kn6x3le@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 70db729fe1b30af89e798d16c1045846753e5448
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 575966e080270b7574175da35f7f7dd5ecd89ff4
Message-Id: <157923300325.26828.10401510949428319820.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 03:50:03 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jan 2020 19:00:40 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/575966e080270b7574175da35f7f7dd5ecd89ff4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

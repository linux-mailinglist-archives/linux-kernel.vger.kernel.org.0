Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE64A95E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfFRSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 14:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbfFRSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:05:05 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560881105;
        bh=EQC5nNuq+cKl8nOr1monDBXdV3ba18Q/Y2lGhpgzRFM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dh9XhyUmRoaFz7gLKkzNSov4vWXfk6nfIiZ/tuivC5za0TZSe5os4+x5YHsgwqxuz
         p7NeODW6b4lKCjxJABNgGdFrkf0N9Gh2Gb2y7NV4VlNt2uaGeu5/pnEAj/92491j8M
         4+5xlRy5FE9cnspT6vEQAGzRuLuIFhSm0YDyyGwE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190618135216.u66gpj5s3kc766cp@localhost>
References: <20190618135216.u66gpj5s3kc766cp@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190618135216.u66gpj5s3kc766cp@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: cd3967bee004bcbd142403698d658166fa618c9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b306892cc57e27959b5232c1b8415cf09b7571c
Message-Id: <156088110495.27164.7890225402146751866.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jun 2019 18:05:04 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jun 2019 06:52:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b306892cc57e27959b5232c1b8415cf09b7571c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

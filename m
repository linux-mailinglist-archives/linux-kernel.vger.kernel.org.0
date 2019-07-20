Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A341B6ECFF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 02:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbfGTAa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 20:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbfGTAaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 20:30:25 -0400
Subject: Re: [GIT PULL 4/4] ARM: SoC defconfig updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563582625;
        bh=Sxa0VBHpmdtm9OoRCaS0A8HU/bL24Gv5LnqL+DI7Vso=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ym5TXIxsRr9cO69z6BPCDWduvFXaN6I+d6ROZXmlbzG6PL9/aq/l1oTAnHtyyvkE9
         pQ8OZkyTUbLjgoOw5xKv4PHXSgL+rvvAVjq8DHJ38x+FgWjCcYaYaVPifu28L3HqB3
         BHqRhw4+OmwlJhaXT0L2rrAzFmUdVILJGCs8bU68=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719235434.13214-5-olof@lixom.net>
References: <20190719235434.13214-1-olof@lixom.net>
 <20190719235434.13214-5-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719235434.13214-5-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 tags/armsoc-defconfig
X-PR-Tracked-Commit-Id: a151f27537250cf869c8d1c2549ccbb77dcbec2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abdfd52a295fb5731ab07b5c9013e2e39f4d1cbe
Message-Id: <156358262502.21220.16666747632654064413.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 00:30:25 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 16:54:34 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abdfd52a295fb5731ab07b5c9013e2e39f4d1cbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C625411484C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfLEUpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 15:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730144AbfLEUpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:30 -0500
Subject: Re: [GIT PULL 2/4] ARM: SoC-related driver updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578729;
        bh=UFuaqn2s6KEeyoyLFgyLdX0NPFkm5/VE2z7tFUcZM5Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UaQFBFE62GlcXI3+eiCDlgjKiFWvfJsqsE9kBDAsFdtRYEtKUd0tHM6scidrCsi3u
         hIjpLtlD5DDle7n3yefmkV0YO9NtBMD1FAZb40M/8ClAVz4IgaFQ00BCrzJ/cNXE9d
         rv2adtcZ17ORtVRibrv2wxZQWECNtU+86JL0kFGw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191205180453.14056-2-olof@lixom.net>
References: <20191205180453.14056-1-olof@lixom.net>
 <20191205180453.14056-2-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191205180453.14056-2-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers
X-PR-Tracked-Commit-Id: 3f6939aec712a15152c32516c1c543a91ac1e717
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec939e4c94bd3ef2fd4f34c15f8aaf79bd0c5ee1
Message-Id: <157557872948.26858.3177777574095454932.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:29 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Dec 2019 10:04:51 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec939e4c94bd3ef2fd4f34c15f8aaf79bd0c5ee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

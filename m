Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C667514A911
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 18:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgA0RfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 12:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgA0RfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:35:04 -0500
Subject: Re: [GIT PULL] arm64 updates for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580146504;
        bh=cjfur9AiQSYJG7/kuFMrRsyfZ/9CjVj9F15dx1YSkSw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ubphHoS/Ib53yM7z/q02rH95apGNimiTuD3eJy+dNdFeKeCuuceGu2eH1wtqPpcZF
         oYzA+G4dTbDXQuW7gGpWwixgUdbYE1nevq9nVhTK2Iy4Id5Dt43RhTIc3cmDVWO7/s
         bUxKkdq1R4XUBAFPTYKxNcNuJW0P5qrwMNtL9E40=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200123165828.GB20126@willie-the-truck>
References: <20200123165828.GB20126@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200123165828.GB20126@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-upstream
X-PR-Tracked-Commit-Id: e533dbe9dcb199bb637a2c465f3a6e70564994fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0238d3c75303d63839ca20e71e4993fdab3fec7b
Message-Id: <158014650400.9177.7880650520096434822.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:04 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jan 2020 16:58:28 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0238d3c75303d63839ca20e71e4993fdab3fec7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

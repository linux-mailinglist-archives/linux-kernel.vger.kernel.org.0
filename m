Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04659307BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 06:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfEaEZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 00:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfEaEZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:25:13 -0400
Subject: Re: [GIT PULL] arm64: fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559276712;
        bh=t9/y1ITY40z/T8C2kwC1Ud11fTEficOcI/zNCGUtbD0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J6itRnKC2xdXDl4JQ2LxKhXsA3J3asTIfTtKuksfi7eOeJuss7a6pYXILLTU1WMG+
         rF15D5ZkMTk/R6noZAkpVh+ayyFTUvy2Y5EObNUW8BQYWHxukeGSXSsTaLmE8JD0GV
         XFPFjL64eZ9zzQ4ozZW69KuUgOnDOcHsOnFyhP3Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190530161126.GB16230@fuggles.cambridge.arm.com>
References: <20190530161126.GB16230@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190530161126.GB16230@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 1e29ab3186e33c77dbb2d7566172a205b59fa390
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adc3f554fa1e0f1c7b76007150814e1d8a5fcd2b
Message-Id: <155927671265.23225.14504311744693326939.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 04:25:12 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        ebiederm@xmission.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 17:11:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adc3f554fa1e0f1c7b76007150814e1d8a5fcd2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

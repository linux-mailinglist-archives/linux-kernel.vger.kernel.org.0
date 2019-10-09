Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5ED18F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfJITaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 15:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfJITaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:30:10 -0400
Subject: Re: [GIT PULL] arm64: Fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570649409;
        bh=3yuozM4FLhSm+i6yEQ1YGbYeMOgWaz07K3LfwiSuah4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OCXIDH/uxYHRlXIF5Tfm07UizQk4ej6Ea89+dhYt7o8q+gFRAwKoDEw0janNMOmDw
         zhYnsVxevTQ+9WVUvJtU3Myvv6g0S4b4BmXrmTj5zoUft4aT4PvvSLVjjH4b5yX3UD
         sA4+jHB5qC/PwGOmuZeMSpGcluqHr076+z7eCS4M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191009133053.p7bxzkub32x3mclb@willie-the-truck>
References: <20191009133053.p7bxzkub32x3mclb@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191009133053.p7bxzkub32x3mclb@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3e7c93bd04edfb0cae7dad1215544c9350254b8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e60329c97b9cc07ce15e3c39fc42e57bf14add92
Message-Id: <157064940962.25372.13156786010603530011.pr-tracker-bot@kernel.org>
Date:   Wed, 09 Oct 2019 19:30:09 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Oct 2019 14:30:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e60329c97b9cc07ce15e3c39fc42e57bf14add92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

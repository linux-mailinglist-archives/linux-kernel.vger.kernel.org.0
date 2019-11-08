Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E64F530A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfKHRzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 12:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730844AbfKHRzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:55:08 -0500
Subject: Re: [GIT PULL] arm64: Fix for -rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235708;
        bh=LK9hwZt3VZD34A6IiTFJNZvFkBUGyeiapHGvJoTWu94=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pheZ+s1Blf6seTLqZeoLwcIUBGt5PfktZzLZmFmJCRqIRCIIy03mF/bbCkFVPosnp
         mqMOWI4aODD91K88QoPbLwda5L6QF76EVmR/ELjjwv5AGoQBBSBzdD1iuEjPHPcyE9
         Dffa5QTB2fel1Ue644OAO0lpYWnnajwgtnpTzn1s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108103231.GA19153@willie-the-truck>
References: <20191108103231.GA19153@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108103231.GA19153@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 6767df245f4736d0cf0c6fb7cf9cf94b27414245
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e8ed26e6062e4f585fe831fba362eb567648881
Message-Id: <157323570813.12598.9228674931391309121.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 17:55:08 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Nov 2019 10:32:31 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e8ed26e6062e4f585fe831fba362eb567648881

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

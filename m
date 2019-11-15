Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B3FE41A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 18:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfKORfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 12:35:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfKORfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:35:09 -0500
Subject: Re: [GIT PULL] arm64: Fix for -rc8 / final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573839308;
        bh=PDKDVr11QGsFBdtYJKssXSW4wAW2ppzsRivSXeLg6zI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JLWscsKEY3Xde+uvJ15KwuSj/e1+4tOR9HrjMvSSquSmuJ/0STduimX1J/Sw6sao+
         yq+ZBzY9RNjrqVuiPD88k9+SpcZDDTQXtRNt2iVOC2kPL0cG01C63JZRvFwS+2FaGJ
         AvqdWs9DRwWvkoy2WY6uCDvX19EWMWMqRxZbuXz4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191115114622.GA12198@willie-the-truck>
References: <20191115114622.GA12198@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191115114622.GA12198@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 65e1f38d9a2f07d4b81f369864c105880e47bd5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb70e26cd79da8068dc7a9d013cd78fbba483038
Message-Id: <157383930890.31249.554154588351507098.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Nov 2019 17:35:08 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Nov 2019 11:46:24 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb70e26cd79da8068dc7a9d013cd78fbba483038

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

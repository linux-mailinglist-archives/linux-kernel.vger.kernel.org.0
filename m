Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C980321
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 01:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437479AbfHBXUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 19:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437446AbfHBXUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:20:12 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564788011;
        bh=LfMe/LP1XQpulbVoTGCWR1T2AUQcB0TRmW8CX98Osd0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q597yPeAPWIzRQwPGgi9IL7tqwRicsvaiP9skNifBV+NH6qY0Fh0BtnA25RIl5/op
         KfXKN5oHqFi4cS5bLdWssJVJg4xoZ9tVwRdghVHVUAB4Jk5YVqsazmrPzljbvijJto
         ctXNfwNMKBR8vbnT3GvgUX9g6QHxOOv+28LjLqss=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190802171753.GA56033@arrakis.emea.arm.com>
References: <20190802171753.GA56033@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190802171753.GA56033@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: d8bb6718c4db9bcd075dde7ff55d46091ccfae15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a507f25d1c2048c136f6834f10966510b62af987
Message-Id: <156478801127.22769.4583603959266745119.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 23:20:11 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Aug 2019 18:17:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a507f25d1c2048c136f6834f10966510b62af987

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

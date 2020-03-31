Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA19199EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgCaTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731425AbgCaTPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:19 -0400
Subject: Re: [GIT PULL] arm64 updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585682118;
        bh=AAzPBPD0BcCQqi3lKKPQf6FDiD9SFkUUDJr4PJ0/p4M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WPZ+n40hcXTT6HcL6bN45SszxvqmHSOE141h+YrTTYACxrMn6ngwDmnspCK2kg5hv
         LwqAjYPrGIfsYoRwUmPpuEHmOJGJHfwuAHQ/y9Y1WSS7zws/ekASn0LSuKjJvw5sld
         aOJpS7Ku/PSuff70g9DfhUwXd8eO/vXWI/9Gr6tc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200331151131.GA17516@mbp>
References: <20200331151131.GA17516@mbp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200331151131.GA17516@mbp>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: b2a84de2a2deb76a6a51609845341f508c518c03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cd86a58f7734bf9cef38f6f899608ebcaa3da13
Message-Id: <158568211851.28667.8169032528868959434.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 19:15:18 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 16:11:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cd86a58f7734bf9cef38f6f899608ebcaa3da13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

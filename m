Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401EDF5307
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 18:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfKHRzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 12:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfKHRzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:55:06 -0500
Subject: Re: [GIT PULL] clk fixes for v5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235705;
        bh=Mmnodf7nLStd8Rs0/fjIXThGRNujRBCWPsLoXfr81FM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g32PE88O5AY3rbMZChMr2Js7WMpDMwKaPd8V68xBZYQANiqWXYmk8jrF9ff3vL3Y9
         6Oi8YIUoypsr0uSXRaRRusNT5Fu6VDQVXWC0fT4wScQOCASLU/xB1Iw14cTvg5MMXz
         k3ittv9jyAPLgf7FSskvc4WooUkK+zwvHtFs6NTY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108064803.9977-1-sboyd@kernel.org>
References: <20191108064803.9977-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108064803.9977-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 5a60b5aa96e8619baf02865e3002704fc2897731
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d988f8877b79ef8ea695df8c126ddcbb09f5a5ba
Message-Id: <157323570566.12598.1049587995028711420.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 17:55:05 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 Nov 2019 22:48:03 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d988f8877b79ef8ea695df8c126ddcbb09f5a5ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

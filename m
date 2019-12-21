Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12BC1289B2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 15:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLUOzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 09:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfLUOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:55:10 -0500
Subject: Re: [GIT PULL] clk fixes for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576940109;
        bh=vRI5cb79SKWBsPZ7gdqzulQFP3uucn9J4Oh57uvAuRU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=057pf5fIJn0fyXesbPN3MNA3rAAnkuLJPtQ2fgAcdTTdtna5bhR6J2Q4JDAgsQIcI
         fOqsJXpn9ABcNjjGYskTC9nHA+q4eY3D4F+TovA8+tuR59lizRukNx1miJNQwrVa1A
         mgNOdWxgHzxGWLM19M/uVp4GnZHiiCEe6xoGjKQ4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221040950.59130-1-sboyd@kernel.org>
References: <20191221040950.59130-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221040950.59130-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 781d8cea68ac41d11a80df2a5f5babd584f86447
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12ac9a08fc4cb240a28e6690dec016abd298e52f
Message-Id: <157694010990.20544.639890836279380592.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 14:55:09 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 20:09:50 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12ac9a08fc4cb240a28e6690dec016abd298e52f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

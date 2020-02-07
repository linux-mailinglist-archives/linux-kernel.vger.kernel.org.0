Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED1B1560DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 22:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBGVzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 16:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbgBGVzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:17 -0500
Subject: Re: [GIT PULL] more clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112517;
        bh=/Qo+lfgpbFQAmNq2fIslBcBaSs+oWm0srYRVl83lonw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uvlYT3OVHAvs2q6vvbSJSyqZ9aLjOVyU3O8hdo+xTphx/vkO5YLtDS2d1DjM6QoFO
         ksZMbnZ2v8u9+iossuu373dR8AvRbYz2JnJIv7rfi7xcdQuX02oAhnQXdBlHU6FCwb
         fpN4kV2mFWlnRoKl2tl1PRKnTHp6b9HBscpUWuPg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200206184405.183679-1-sboyd@kernel.org>
References: <20200206184405.183679-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200206184405.183679-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: 5df867145f8adad9e5cdf9d67db1fbc0f71351e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bf5973a4ef0c996d805dc70c2122f08155d14ef
Message-Id: <158111251708.9631.16528576943918451615.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:17 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  6 Feb 2020 10:44:05 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bf5973a4ef0c996d805dc70c2122f08155d14ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

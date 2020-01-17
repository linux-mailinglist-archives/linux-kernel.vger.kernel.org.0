Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0B140280
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 04:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgAQDuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 22:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbgAQDuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:50:03 -0500
Subject: Re: [GIT PULL] clk fixes for v5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579233002;
        bh=f2D3mNDrOmc1QwACVwi+a+WAa2facJka+Yh8zuHJSv0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Lh4KBsqZfqCPNd8rlHvYKFM0MfrF6ivHlkKDVsP70pz3wtvdn9IerHO3koyEhkwxg
         FdIXjoOGXekoBWEW12F/r1+ZzPMZPbF8Fphiz7iU6N5+eoVZ28JJ97mEg+3UTCedh4
         q14hsdLGf7ylnHmUoMZ481xF/esLch2HnZm/zuOY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200117021105.253415-1-sboyd@kernel.org>
References: <20200117021105.253415-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200117021105.253415-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: a0af2742473425322cc24c79dc4033d74aaf3d81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef64753c1922511e7d81947a8d27e72925a05e2c
Message-Id: <157923300290.26828.9298247075524446123.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 03:50:02 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jan 2020 18:11:05 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef64753c1922511e7d81947a8d27e72925a05e2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

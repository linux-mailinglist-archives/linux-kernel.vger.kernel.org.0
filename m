Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663D010F1DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 22:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLBVFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 16:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfLBVFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:05:22 -0500
Subject: Re: [GIT PULL] Devicetree updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575320722;
        bh=KvuQvOeHf7073T7iqCk7/sH8hVp31zd1O+gMG3150OM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C4NBszpdP8aNgn/hfPRoDHKK9meF0m+nbkFoYxTYUEATWOqyIfg7vGUvCqzcmkJx/
         KRqwwwjItoF/uCOgMgloO7VksveVIyWr8Df8/ycoO6RBiE2A9WqUjXTGo7VDVr3UP6
         GU1yeGyphQfrfsRxoklEz+qKPZCO23lkk7EsfnEM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191130051055.GA2987@bogus>
References: <20191130051055.GA2987@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191130051055.GA2987@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-for-5.5
X-PR-Tracked-Commit-Id: a8de1304b7df30e3a14f2a8b9709bb4ff31a0385
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c97b5ae83dca56718774e7b4bf9640f05d11867
Message-Id: <157532072192.29263.13142208368791792538.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 21:05:21 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 22:10:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c97b5ae83dca56718774e7b4bf9640f05d11867

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

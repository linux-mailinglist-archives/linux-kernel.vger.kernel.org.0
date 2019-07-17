Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB906C1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 22:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfGQUAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 16:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfGQUAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:00:20 -0400
Subject: Re: [GIT PULL] hwspinlock updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563393619;
        bh=sGAbsa4zJ1MTP4jiSF9JknkD1pQyq1NakdV9LUCf1a4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TQRTE+Asfj+M0t3rnlATWDNlWOZQQNvyKLgPxjMpbDpTN3IWSWSMoOymSZbr/dL3M
         eJDR2w9azwgf3uX3rFKPsuk1ZWbqt4SpGIQf9k/YHQ0fTLzhEk7mxB0ZGXEENLFNDh
         VB7rfQjYeIiAM6c+fM5xZeb4gwxRVZiWeMFOCHSs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190716190153.GC8572@tuxbook-pro>
References: <20190716190153.GC8572@tuxbook-pro>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190716190153.GC8572@tuxbook-pro>
X-PR-Tracked-Remote: git://github.com/andersson/remoteproc tags/hwlock-v5.3
X-PR-Tracked-Commit-Id: 360aa640a59f269b784848c0b2d6d462952750d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57ab5f740202babe93c8796013c5cfdfd6d08d7d
Message-Id: <156339361931.17916.16714713395709914592.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 20:00:19 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Suman Anna <s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 12:01:53 -0700:

> git://github.com/andersson/remoteproc tags/hwlock-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57ab5f740202babe93c8796013c5cfdfd6d08d7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

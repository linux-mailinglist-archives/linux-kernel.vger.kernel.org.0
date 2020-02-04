Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4DC151765
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgBDJKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgBDJKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:10:14 -0500
Subject: Re: [GIT PULL] hwspinlock updates for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580807413;
        bh=JJsb9eI1dQTdWc7HbQyRaae7q5zuD0cLaFBTy0E5wL8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t0ZFG58yJAeaPoRNQsX4/D6S2F13aatL0ebfnAtj46ovoiEO3hXfpxtZ5bwy4lwLo
         raY3ZKjx7FnJio95NfHEWL0daRwomAvXZ1rIBcu5HSIBtgDtMHcT79v3YWLy7Wm5mJ
         HKIic/L6CClQ64SQihh2Ps7yCBUiH3VD/vxw4aDU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200204053455.GA130281@yoga>
References: <20200204053455.GA130281@yoga>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200204053455.GA130281@yoga>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/hwlock-v5.6
X-PR-Tracked-Commit-Id: cb36017a8b1b582bcb7063e44c598c3e36aa0228
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 685097986b5ef8b8c4b19dbb6a1d6069c3626ba2
Message-Id: <158080741383.26461.13348108129703323259.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Feb 2020 09:10:13 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Feb 2020 21:34:55 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/685097986b5ef8b8c4b19dbb6a1d6069c3626ba2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

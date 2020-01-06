Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE3131A08
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 22:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgAFVFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 16:05:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgAFVFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:05:10 -0500
Subject: Re: [GIT PULL] ARC updates for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578344709;
        bh=0fNJ5qQlETQMY/5Xq2rKQw1/igcwoYeCEEp5ih/L4no=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XH9JURchKXYJt6gi5iQo0osF+bZbCmrC/62hA61gl3qVYVBIBK3sFwd3UY7K9QKOK
         LITyGF7qNHarb9B3qAppp5KsgSByaxaM9znlHn0mUNAyeIPdqfxgLHcW6/qwetO3I/
         vVAVEsqEyNc50PKBkWsLKb5NJAeloOhHBYH+NZV8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9907df0c-6996-1a6b-0cf1-0dbfcb8ea414@synopsys.com>
References: <9907df0c-6996-1a6b-0cf1-0dbfcb8ea414@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9907df0c-6996-1a6b-0cf1-0dbfcb8ea414@synopsys.com>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: 7ecc6c1d5c8dbc713c647512a5267ca0eafe3e1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f8b69aa501e84a0043428467a5a22b55e937cbd
Message-Id: <157834470973.27503.1119136242800719665.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jan 2020 21:05:09 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jan 2020 18:09:39 +0000:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f8b69aa501e84a0043428467a5a22b55e937cbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399321095A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 23:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfKYWpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 17:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfKYWpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:06 -0500
Subject: Re: [GIT PULL] AFFS updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721905;
        bh=LsEnQuMqJdxpirf2ByCXY1+G+WKOBmRdtbaMuX/V/HU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I2wVCYZJSdpzFkPNYej04FfAZJaDS5M7SuPtYUdl4JmKBy+Pj2XtWyBTkhO1WHgZi
         OmV/cOhWaZ1n/TlPe1myguhrFY8/zMm9o13gLh7DG7UrCcK9k+hWztjvw854w6FZ7R
         Y4cj2en6L/+CcYwfW79e/EDCR63qO/PTilnUfvwc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1574440243.git.dsterba@suse.com>
References: <cover.1574440243.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1574440243.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
 affs-for-5.5-tag
X-PR-Tracked-Commit-Id: 450c3d4166837c496ebce03650c08800991f2150
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae36607b669eb28791b02097a87d3d2e1589e88f
Message-Id: <157472190554.22729.1255906663716272392.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-fdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 17:35:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-5.5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae36607b669eb28791b02097a87d3d2e1589e88f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

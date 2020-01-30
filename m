Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A478414D583
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 05:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgA3EPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 23:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbgA3EPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:15:10 -0500
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.5+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580357709;
        bh=ndCkhEiCn0iS0/W/A/xMf3x2f4FLVZFCVDXGd/Ij6YA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v7Ld1c7Uc+cehM+lwiYsdHUsc/YkoiCXMH/NWISu26w6RAKLXU+Y/E+jVHU0+KVXq
         2pLCbVA1Wsxez4wbxFgUtJOsV6hdi2oZ03f7EKkkh556dc3FOf4wOHwOTPwhqTtriX
         6MB/QSCw48ZUyK02anUXCA3YuKAG/swOsGWfeyvQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1580322984.7790.36.camel@HansenPartnership.com>
References: <1580322984.7790.36.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1580322984.7790.36.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 11e673206f217ce6604b7b0269e3cfc65171c380
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33c84e89abe4a92ab699c33029bd54269d574782
Message-Id: <158035770966.9636.11321551506356671767.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 04:15:09 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 10:36:24 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33c84e89abe4a92ab699c33029bd54269d574782

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

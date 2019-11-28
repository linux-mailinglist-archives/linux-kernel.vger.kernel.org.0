Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0110CED4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfK1TUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 14:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfK1TUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:20:15 -0500
Subject: Re: [GIT PULL] generic ioremap for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574968815;
        bh=G58HprIePJ6qbY+OHsZVZgBg2KquNToguUNtXSRHJLo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=saTkmyL8AaaF6ya38BNFEko4VLzyro3RRGO5eOHLLkmMlbmJpBPZtObVUbVnoy4jG
         j/xkb/2d3jd525W3z2wKnWm/zXQOFOuLNC3QC8DmKPa/USwQufeni2sJAHq843779j
         MtdCnVGNeV1Mk5HauujwPqtbipzPKr13F2NIISsM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125192758.GA13913@infradead.org>
References: <20191125192758.GA13913@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125192758.GA13913@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/ioremap.git
 tags/ioremap-5.5
X-PR-Tracked-Commit-Id: eafee59440623e06b0ce4a0e49f814a8cf31d8ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a308a7102215a582fc474375648965bc5692894b
Message-Id: <157496881508.25622.2949823818676822496.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Nov 2019 19:20:15 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 20:27:58 +0100:

> git://git.infradead.org/users/hch/ioremap.git tags/ioremap-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a308a7102215a582fc474375648965bc5692894b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5EC14AB83
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 22:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgA0VUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 16:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgA0VUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:20:04 -0500
Subject: Re: [GIT PULL] ioremap changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580160004;
        bh=/W9JqbAAL4xbjXYRS2MdhH/akzoaltvXmz0YCCDr63U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xvKwQwbVXAl3xFQLPC/W6bASENQuwMYybUGD4Amcy2iPtuxpyuCRQlfgZyUdoBgmw
         YcgeCjBhtLhTZHjjCApF8N1w/xb0HVvTzhUVn98wOU63vlzIVAA3y5o+LoDhddeQLW
         xdn6jKLVXhIR49GpssHpN8SErSbnWlDf171QXi58=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127181827.GA929837@infradead.org>
References: <20200127181827.GA929837@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127181827.GA929837@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/ioremap.git
 tags/ioremap-5.6
X-PR-Tracked-Commit-Id: 4bdc0d676a643140bdf17dbf7eafedee3d496a3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a1000bd27035bba17ede9dc915166276a811edb
Message-Id: <158016000404.13304.15294418167247268316.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 21:20:04 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 19:18:27 +0100:

> git://git.infradead.org/users/hch/ioremap.git tags/ioremap-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a1000bd27035bba17ede9dc915166276a811edb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

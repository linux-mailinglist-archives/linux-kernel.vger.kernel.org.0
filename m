Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE26114850
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 21:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfLEUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 15:45:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbfLEUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:45:34 -0500
Subject: Re: [git pull] m68knommu changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575578734;
        bh=0d1nPJ+cKdSm3/7vHy9vhIOX/dHiQ+A9pNOLhUV3ZY8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GpFba8ffmPFuf8Pknj7+qs8sqe3ygSPPGDQNBrV7V589JjldRPU2WcsChoN2W1xby
         B9f6Pa5EVHUQV7cBVA9WHr8jXNXNyAWjq8CRKPsOa9eDLJpqT4o3HSLZkyZRsbfF36
         TYXOUr508sIpZkgDaBBNag3ufLM8iOyHSDOnJedA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b0a3cf1a-940e-f4e0-7102-acee10248048@linux-m68k.org>
References: <b0a3cf1a-940e-f4e0-7102-acee10248048@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b0a3cf1a-940e-f4e0-7102-acee10248048@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
X-PR-Tracked-Commit-Id: 3ad3cbe305b5a23d829d3723b60be59c36713992
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25cfb0c7de3f14e283a43dcd6de903657f9f98c7
Message-Id: <157557873430.26858.3527075994340860808.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Dec 2019 20:45:34 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 05:34:06 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25cfb0c7de3f14e283a43dcd6de903657f9f98c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001A6DB1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405627AbfJQQKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 12:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388044AbfJQQKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:10:05 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.4-3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571328604;
        bh=nupIFPDynV/Jin88GfNdJccsqLE77e1DTPTMzW8kotM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q358MdOsFnF/3WEQGPyFjl4+Dc3Gs99HwsEGDP3l1JDsPog/KF2Lo3CzSR3DcX/CW
         iNKu1WAyU+Otb/Y1NRYZKZA9CtgA+psAe2MYLjuAKshabA6236S4zKdSDEob/kEqpr
         SEB++KRD0IjRh9k4HC9+E+ZphbsIgJJpYb1YdESQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191017095520.GA8671@smile.fi.intel.com>
References: <20191017095520.GA8671@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191017095520.GA8671@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.4-3
X-PR-Tracked-Commit-Id: 832392db9747b9c95724d37fc6a5dadd3d4ec514
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe7d2c23d748e4206f4bef9330d0dff9abed7411
Message-Id: <157132860467.23315.5969037714428434456.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Oct 2019 16:10:04 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Oct 2019 12:55:20 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe7d2c23d748e4206f4bef9330d0dff9abed7411

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

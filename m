Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3555588ED8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 01:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHJXkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 19:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfHJXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 19:40:08 -0400
Subject: Re: [GIT pull] perf/urgent for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565480407;
        bh=bNGuKg0K7Y/VxpxMaDSPvXYz4jDPMtxD8hog/ggATeU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U11twMQfwQTEDIzUkD52FS4+RS1+eFI4DlxIZEInLmomVXLd2h+NxxZ18JiLjsZ8J
         n6a8It6h8PFcPQuG/jaAGvTHWe2GZEFqofibYIOFJ2t0Ys2l7ORqQoqKNscwVSKwlG
         h+TBSAsLMw3yLiSPnrUcW0ss0rGfghmpiA2b40sw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156546731194.17538.13243528151904723193.tglx@nanos.tec.linutronix.de>
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
 <156546731194.17538.13243528151904723193.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156546731194.17538.13243528151904723193.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: d7731b8133ad64cd98bf34a33dcf810df4410308
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2359a5153ebb16412daedd8f104b886643cbd1a
Message-Id: <156548040702.7293.12134797786206503117.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 23:40:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 20:01:51 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2359a5153ebb16412daedd8f104b886643cbd1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

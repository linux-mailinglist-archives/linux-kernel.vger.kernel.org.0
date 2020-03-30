Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79631984E3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 21:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgC3TuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 15:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgC3TuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:50:09 -0400
Subject: Re: [GIT PULL] i3c: Changes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585597808;
        bh=fF5DwcqY4G4U6cpmzqWHasL6Ak99ZVQ75vcvbgBa2MA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wuEcZVSHH7yNfLJRxQDgTsaD9/lM22hp1sOBsUrR4+qK4MPGjVNAV41BV5fD2subS
         eJtBaxFhl/M8JHEGcD48xZNERJimNB+pIE62Ryyfrx1dZitcYmK2rFUDBV+m9v8kgD
         XOsSSzc6xiShvaraCKJugwJy+TZPiOWC+ak/TU0c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200329104816.5cbdb74f@collabora.com>
References: <20200329104816.5cbdb74f@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200329104816.5cbdb74f@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.7
X-PR-Tracked-Commit-Id: c4b9de11d0101792c4d5458b18581f4f527862d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c03cb66464742cf4b196b4863e4101b8cf9eb9be
Message-Id: <158559780876.12131.2222508196297047884.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 19:50:08 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 10:50:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c03cb66464742cf4b196b4863e4101b8cf9eb9be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

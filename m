Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A114D3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 00:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgA2XfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 18:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgA2XfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:35:08 -0500
Subject: Re: [GIT PULL] y2038: core, driver and file system changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580340907;
        bh=WDvYbcIQcir1f/YxcuFeM4fuWZTz+grO/MeSUnTl5Nw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CX2CqqvCqj68EU4uUvMtzzRIdwWJ1XJrjifrIPrnwibq+FoAWgHHcYGmICxk8Z/n1
         5v5noGtCghJsV6bwuqhMYc591PGm6Fs0bdf7y0VxAh0ilPPPmg9vORS6u97+cvhfJ/
         rZWJqCuEynjShOL/tOrdPVTpft5M+6C5yBxM1pno=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2iZyA1VSFqvcEc9o59F76GgzLBiOAmEuHKD81FErPLDQ@mail.gmail.com>
References: <CAK8P3a2iZyA1VSFqvcEc9o59F76GgzLBiOAmEuHKD81FErPLDQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a2iZyA1VSFqvcEc9o59F76GgzLBiOAmEuHKD81FErPLDQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
 tags/y2038-drivers-for-v5.6-signed
X-PR-Tracked-Commit-Id: c4e71212a245017d2ab05f322f7722f0b87a55da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22b17db4ea05561c7c8e4d770f10751e22e339f9
Message-Id: <158034090783.30341.17305815047883638640.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jan 2020 23:35:07 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 14:55:53 +0100:

> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git tags/y2038-drivers-for-v5.6-signed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22b17db4ea05561c7c8e4d770f10751e22e339f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

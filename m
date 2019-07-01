Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3D30783
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 06:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEaEAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 00:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfEaEAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:00:13 -0400
Subject: Re: [GIT PULL] sound fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559275212;
        bh=g41sRFMk37akNzOa4BhXTtatZWssJ9XMvVoj4wNRwXw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=waI6qmsp3VMqIBItPJJyxKGesCNohHOVX/G8lvWKVvtpeiFKU+i8RViuhNNOLfCzw
         lzl7seDLCSRZleSKbUey4yWCXbj1ePKk8kshnKCw1RZghRUxiAelD1RznQL1SeUacW
         m3Qj9LUchUMSCSY4ayp6qvbT+pIcWPpAMXbCYOWA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h8suouxyy.wl-tiwai@suse.de>
References: <s5h8suouxyy.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h8suouxyy.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.2-rc3
X-PR-Tracked-Commit-Id: 6954158a16404e7091cea494cd0a435ca2f90388
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5ba1712661233ce0f4666b8c3dee5bb78d380f2
Message-Id: <155927521272.31954.8657790435341414408.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 04:00:12 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 10:51:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5ba1712661233ce0f4666b8c3dee5bb78d380f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

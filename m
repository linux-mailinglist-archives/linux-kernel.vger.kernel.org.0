Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68CB9F26A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 20:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfH0SfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 14:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbfH0SfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:35:11 -0400
Subject: Re: [GIT PULL] ARC fixes for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566930910;
        bh=lnng0ErQ0Vj2WeYUmOA8NWym6fPIS/zzRsHQdehqq30=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yegMfFvAlKoHphl/OqMSQz0OGEy1r94Wm6F1wt9aVx0QGSNvUXuQ0HdfHJuP5DFfo
         ASD3ANJ8fE0cDTunqXSz6n8LZlqKg8qPBWOujI+DJ4CBqzThvrBQwu63+E54HZg6qv
         IzFF46v4a/88sQCO7FtgwN6CkrVNF/NRZEnNkUmE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <41adb7d8-dcf5-3ee9-0ae8-53fe0d614de9@gmail.com>
References: <41adb7d8-dcf5-3ee9-0ae8-53fe0d614de9@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <41adb7d8-dcf5-3ee9-0ae8-53fe0d614de9@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.3-rc7
X-PR-Tracked-Commit-Id: 2f029413cbfbfe519d294c6ac83a0c00e2a48a97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6525771f58cbc6ab97b5cff9069865cde8283346
Message-Id: <156693091045.10894.5285009931367772272.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Aug 2019 18:35:10 +0000
To:     Vineet Gupta <vineetg76@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.COM>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Aug 2019 10:07:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6525771f58cbc6ab97b5cff9069865cde8283346

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

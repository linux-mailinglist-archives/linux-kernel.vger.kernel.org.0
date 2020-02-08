Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A59F156803
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 23:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBHWfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 17:35:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbgBHWfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 17:35:24 -0500
Subject: Re: [GIT PULL 1/5] ARM: SoC platform updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581201324;
        bh=95bgp/FJSy1suZkLPYmOT9HNlhKF8Rbr2gd1zOes0LM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EWD1HjZqXlw8Ct9ldL/nr08vgtTEv9mO04oppG8ulDU4wt7nFTl3O2EXD4kMDBun1
         zIl/Ur7y7Epzb6HsOucbMap5g1DttfcY9RjAIGhZ99nzVnEs8VnOtzKTyRYkzlvMlj
         EUowyGyUTWFC/0DktV7U3Yvzf8VPdgROltd6sZ8c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200208112018.29819-2-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208112018.29819-2-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200208112018.29819-2-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc
X-PR-Tracked-Commit-Id: d8430df172118336d050aa61999fb82e55102641
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 469030d454bd1620c7b2651d9ec8cdcbaa74deb9
Message-Id: <158120132416.28764.6873422176640008189.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Feb 2020 22:35:24 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  8 Feb 2020 03:20:14 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/469030d454bd1620c7b2651d9ec8cdcbaa74deb9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

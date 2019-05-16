Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2875D20D30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 18:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfEPQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 12:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbfEPQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:40:20 -0400
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558024820;
        bh=7PiQ0dmmX5rCUqggQe1b4/koxfDeRdPlUE1VlC+p1Bk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GJWHwOdFaEbpTjrXJvT5ZTcGdO///KDVgrmLBRAyQH4+1nl+NCJ4u36MliMl7S97s
         Wd9tnJHMrvGrEtnxZPWR5V8PpxmtaizvAR0/Atk4RLYIWPAwOqRMpSIxHPyFmSx97q
         xTup/WCGHRGNHPqTchaA3uyh2qBRDtn16NV449rs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516064304.24057-2-olof@lixom.net>
References: <20190516064304.24057-1-olof@lixom.net>
 <20190516064304.24057-2-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516064304.24057-2-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc
X-PR-Tracked-Commit-Id: 7a0c4c17089a8aff52f516f0f52002be52950aae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22c58fd70ca48a29505922b1563826593b08cc00
Message-Id: <155802482014.32664.15521612256088275626.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 16:40:20 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 23:43:01 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22c58fd70ca48a29505922b1563826593b08cc00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

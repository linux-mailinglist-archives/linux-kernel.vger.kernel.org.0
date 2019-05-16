Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB1520D33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfEPQkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 12:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbfEPQkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:40:23 -0400
Subject: Re: [GIT PULL 2/4] ARM: Device-tree updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558024822;
        bh=diPG/wYZRblNeco845yvy3MdskkEV1mrEDjxhZdWF/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tTiHgOksxhTXhEyLcbkgZQ7+t3ho8NwUjxgVaPlbAxbZHgyP+Mj57nVRkfwgxJZ4c
         /KNC5aZdfi/vqmIt1EKTRr/2Khxz3/QoK0Q1pPsblVDmzcAucfXfqseBm5/6ndeVne
         GJRnlObpkrq1C7asVhj3neRc0UMHau7XwU+bMFVI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516064304.24057-3-olof@lixom.net>
References: <20190516064304.24057-1-olof@lixom.net>
 <20190516064304.24057-3-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516064304.24057-3-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt
X-PR-Tracked-Commit-Id: 6cbc4d88ad208d6f5b9567bac2fff038e1bbfa77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8a1d70117116c8d96c266f0b99e931717670eaf
Message-Id: <155802482286.32664.11718862132617630801.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 16:40:22 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 23:43:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8a1d70117116c8d96c266f0b99e931717670eaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

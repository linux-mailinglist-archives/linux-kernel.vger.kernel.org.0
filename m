Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475D6148D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 19:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391037AbgAXSAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 13:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390986AbgAXSAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:00:05 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579888804;
        bh=2b4GYibQY/giByCe+xBlKXf22xXWn/Kj4DMTXSEoz0U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C2Ak3IoLK1W7BmXzCxmcgjx666/EUoACtNda7R5u4o1OwthkwlfCBuEpD/lbTDCWt
         VUZvvRn7W9R2r+NJyPNaW07uHHsspKJOUmSAi+pe7D+mUjw9/4rTFY9lor1yffcmra
         DDWxeNi94byonTOmwIVRNOl/wrpGFqetRH8fpNl0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200124172938.GA30565@8bytes.org>
References: <20200124172938.GA30565@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200124172938.GA30565@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.5-rc7
X-PR-Tracked-Commit-Id: 8c17bbf6c8f70058a66305f2e1982552e6ea7f47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6381b442836ea3c52eae630b10be8c27c7a17af2
Message-Id: <157988880477.9531.3662551803752426240.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jan 2020 18:00:04 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jan 2020 18:29:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6381b442836ea3c52eae630b10be8c27c7a17af2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

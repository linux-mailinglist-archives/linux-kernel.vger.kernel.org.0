Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D8010CEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 20:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfK1TzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 14:55:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfK1TzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:55:15 -0500
Subject: Re: [GIT PULL] dma-mapping updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574970915;
        bh=0YZdEDTRQcaiem7wsteKe6vcE3rtm3kUJ9ehSINoDl8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kvpjWkXNYyUDkXLS42imM1H9+9EBJcccD3gEVPy0JMXbKphDEcKe5OijzdU/VvIEs
         QjXPd3h8xgaX0QrwkVVBOGYIm7PAJQLicNZa+UANzLUeuGXTmhxXt3Xlv81MfGJ5sT
         YlApeDjar01JhqQsFF+HD2tUhPugQbZehgkWj9rg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191128164904.GA20771@infradead.org>
References: <20191128164904.GA20771@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191128164904.GA20771@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.5
X-PR-Tracked-Commit-Id: a7ba70f1787f977f970cd116076c6fce4b9e01cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81b6b96475ac7a4ebfceae9f16fb3758327adbfe
Message-Id: <157497091536.22792.17174255235714068782.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Nov 2019 19:55:15 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Nov 2019 17:49:04 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81b6b96475ac7a4ebfceae9f16fb3758327adbfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

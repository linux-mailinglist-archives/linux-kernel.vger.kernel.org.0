Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA954717B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 19:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfFORzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 13:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfFORzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 13:55:07 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.2-3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560621307;
        bh=6VlPrQJtp/TPb2ow3gsdo6zhB37QRhf9TvVTLyYWJdc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LSf5+ZNWQYVdjQ21PfC81xXrei9ttClCIYirjrbjNT91QRPV/HoDqSWJ5SXcZFfa/
         AjuODQMzm20Gka5+lLN+SUbPUO5IzQA8QjWMZrOtHIJBW+jFudlDxtzQb3biHmhZ98
         hD54gBTbewYQ3d8s0m8M3q2lJDO2OTuS4tcCKClc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190615171515.GA17041@smile.fi.intel.com>
References: <20190615171515.GA17041@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190615171515.GA17041@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.2-3
X-PR-Tracked-Commit-Id: 8c2eb7b6468ad4aa5600aed01aa0715f921a3f8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e01e060fe00dca46959bbf055b75d9f57ba6e7be
Message-Id: <156062130698.5191.11029021184984688356.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jun 2019 17:55:06 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jun 2019 20:15:15 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e01e060fe00dca46959bbf055b75d9f57ba6e7be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

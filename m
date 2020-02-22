Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1D2169197
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgBVTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Feb 2020 14:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgBVTpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:45:13 -0500
Subject: Re: [GIT PULL] Devicetree fixes for v5.6, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582400713;
        bh=e/wizAP3md2y/e0mJQfbbdsgCpx0aiSivl+PEsy+vb4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TXUFT5yn5Ya8VCXEEwecYn2bpRrhPOkLQZLxq+OX5XeAs4dNpFS2CXXSiOVDmfyYU
         psEe3heig237tD9ykAfxZiczGB3r+49Y0E3s0YHEzihdwBxspzGYJPj1yi56ExnYAO
         nLfCaS7iCeApIAo0k/WIn9NDhGFi2VfOG5gPDr28=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200221215503.GA26346@bogus>
References: <20200221215503.GA26346@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200221215503.GA26346@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.6-2
X-PR-Tracked-Commit-Id: 854bdbae9058bcf09b0add70b6047bc9ca776de2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fea630215a9e767fd3917b2cb09ec3ded58f88a2
Message-Id: <158240071306.14316.13731618209914121479.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 19:45:13 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Feb 2020 15:55:03 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fea630215a9e767fd3917b2cb09ec3ded58f88a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3537341A21
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 03:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437096AbfFLBzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 21:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408335AbfFLBzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:55:13 -0400
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560304512;
        bh=hXLW+VIVIsE/EIbivNDXGXPRzyzytVyRTJ+z1BfUhkI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FBwHoMNBA2GMCf/xczMaWElxJuqjL+hJKVWOI2TleYUfsCZtu3GwTvMsE3MYm6m9F
         KPXqpZ6Gk4rmv3gyCpgiQoRb5Wgi9i7K7RFZMsPpo3klTaNSgL4Dwd+HsmqdGasCtI
         pdMrX/iGvNpCyqRUuHQuSHUxun87bVkMuL1ypnJ4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190611183609.GA12859@char.us.oracle.com>
References: <20190611183609.GA12859@char.us.oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190611183609.GA12859@char.us.oracle.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
 stable/for-linus-5.2
X-PR-Tracked-Commit-Id: 4e7372e0dc5d7d2078fbdb13505635cd5b11f93d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d8f5f91b8a608980b173ef3382913c7405f82c3
Message-Id: <156030451268.13515.8599054208627107134.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jun 2019 01:55:12 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jun 2019 14:36:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d8f5f91b8a608980b173ef3382913c7405f82c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

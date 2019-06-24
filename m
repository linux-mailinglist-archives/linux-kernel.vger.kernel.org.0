Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C957750C16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 15:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfFXNfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 09:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbfFXNfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:35:04 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561383303;
        bh=BQGVU6wnUXnrUAs+anIzQsv2wkb2UrWnODiCFrUiWH8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yEduAXM40bL5jKD+y9igwx5DixAOtxOC43pi03wnknVN9xVc+3HipMe+UPBDAQFq0
         91vm4nYGBtMvNnrCwv5M+ndYwISOdGx8IM1mdgaG0rP3baeT0OGvy5zXTo12yMMLHd
         4bjbcTV0oqvqU6qHrhrcHfGIjoUm4h9kDhM4dJyw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190623135038.GA29791@gmail.com>
References: <20190623135038.GA29791@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190623135038.GA29791@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/auxdisplay-for-linus-v5.2-rc7
X-PR-Tracked-Commit-Id: f4bb1f895aa07dfcb96169192ff7c9154620df87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9216514602ac436c116664ac9eaf18127ccf34df
Message-Id: <156138330350.1016.15579604788445805815.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Jun 2019 13:35:03 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jun 2019 15:50:38 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9216514602ac436c116664ac9eaf18127ccf34df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1013147253
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 21:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgAWUFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 15:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgAWUFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:05:05 -0500
Subject: Re: [GIT PULL] XArray for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579809904;
        bh=Tts0Nk4kJ6iQl44hN7vvq2O2VtgiBAGDFjYWEuic434=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PsW6m3M2KzsrHlf/75KcNkNEaaPHgO1kKEdXmKezXCbzSQS2TAIiOlCyI9+Iq7IfH
         WUXY7Qq3clTgs40nPjlQstnBl5dLbINKegbh3I93ybDq3jz8fGnoZWQz4ScGM7k+iV
         mqhG4Pp+8sqD3maSaIUn6rCIFr+BfZzKaGkFqWPE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200123064140.GG4675@bombadil.infradead.org>
References: <20200123064140.GG4675@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200123064140.GG4675@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/linux-dax.git
 tags/xarray-5.5
X-PR-Tracked-Commit-Id: 00ed452c210a0bc1ff3ee79e1ce6b199f00a0638
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4703d9119972bf586d2cca76ec6438f819ffa30e
Message-Id: <157980990449.21521.4296591337082890380.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jan 2020 20:05:04 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Jan 2020 22:41:40 -0800:

> git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4703d9119972bf586d2cca76ec6438f819ffa30e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

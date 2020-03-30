Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B541986D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgC3VzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 17:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729846AbgC3VzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:55:10 -0400
Subject: Re: [GIT PULL] USB/PHY patches for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585605310;
        bh=qGR54qQVwa2oMLWpgtXM35tls0aGmAvivOApKqL29NQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sgc4+AT8PP5C+GY1rmtfnHkFLId5B0QEBK4fKcaOBwO4uErZxLYQevca1EgHdGOGz
         ok+N38dE0GnRePieN44cc6TUfO+NvWDQ+KAFZq+oqT5IkEbvo9GSRTvchvRhUwrEes
         BEv6tf4c7MHZpp4QqS1AR2yoCC3idECll7e8kNmk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330104431.GA739262@kroah.com>
References: <20200330104431.GA739262@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330104431.GA739262@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc1
X-PR-Tracked-Commit-Id: 62d65bdd9d05158aa2547f8ef72375535f3bc6e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db34c5ffee649e2c4c870d1031a996398a187cf5
Message-Id: <158560530996.23211.11286987312733046119.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 21:55:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 12:44:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db34c5ffee649e2c4c870d1031a996398a187cf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

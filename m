Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4873A181FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 18:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgCKRsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 13:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbgCKRsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:48:38 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C5B20734;
        Wed, 11 Mar 2020 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583948919;
        bh=o6cfFMd76vbeZd9f32n4LmEvpTaX32KdbDibeKUu9jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lNcHirCXMuXTRjxAhcBTXM+uJDRIFTyQ7xcnNZSGcV3HXtYu50FYhlFQKyeqt5Qi+
         ybY2UKmTNNL9si7JuFc72Uusfw+T/EyxehtOUL6ajiw4gusPq9ta9DeeW7dm3u+qzM
         /B07T/grBRqlow0OJHle22MB4VhyWV3rB0tgMFRw=
Date:   Wed, 11 Mar 2020 10:48:37 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs for 5.6-rc6
Message-ID: <20200311174837.GA82207@google.com>
References: <20200311162735.GA152176@google.com>
 <CAHk-=wjES_Si7rUtu_EuYu4PDz4OGdA4BWhYGJ=zOoJiELiykw@mail.gmail.com>
 <20200311173513.GA261045@google.com>
 <CAHk-=wiVpnOo9MyOpHxAyuv0ZBGCsW2tMmOtwb+6CX-taKRtKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVpnOo9MyOpHxAyuv0ZBGCsW2tMmOtwb+6CX-taKRtKQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11, Linus Torvalds wrote:
> On Wed, Mar 11, 2020 at 10:35 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > I actually merged the last three patches which were introduced yesterday.
> >
> > Others were merged over a week ago.
> 
> No, three were done just before you sent the pull request, and then
> seven others were done yesterday.

Due to my rebase work. :(

> 
> Yes, the rest were a week ago.
> 
> But basically, by rc6, I want to get the warm and fuzzies that the
> code has been tested, seen review, and isn't some last-minute
> addition.

Ok, I see. Let me prepare them for next merge window.

Thanks,

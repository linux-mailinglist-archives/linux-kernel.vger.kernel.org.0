Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33BB3D6747
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 18:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbfJNQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 12:27:45 -0400
Received: from foss.arm.com ([217.140.110.172]:48428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbfJNQ1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:27:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90EFE28;
        Mon, 14 Oct 2019 09:27:42 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04623F718;
        Mon, 14 Oct 2019 09:27:41 -0700 (PDT)
Date:   Mon, 14 Oct 2019 17:27:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REGRESSION] kmemleak: commit c566586818 causes failure to boot
Message-ID: <20191014162739.GG19200@arrakis.emea.arm.com>
References: <20191014022633.GA6430@mit.edu>
 <20191014070312.GA3327@iMac-3.local>
 <CAHk-=wi5J+ga=CUQ-vho3savkhDNes1Hwxij2Y19gen_-9tU7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5J+ga=CUQ-vho3savkhDNes1Hwxij2Y19gen_-9tU7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:57:41AM -0700, Linus Torvalds wrote:
> On Mon, Oct 14, 2019 at 12:03 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > Linus, could you please merge the patch above? I can send it again if
> > it's easier.
> 
> I took it.

Thanks.

> Generally I prefer having patches (re-)sent to me explicitly rather
> than getting a link to it, so for next time...

Noted.

-- 
Catalin

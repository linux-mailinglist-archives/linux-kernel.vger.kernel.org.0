Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7180CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 00:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfHDWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 18:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfHDWPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 18:15:20 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE15520880;
        Sun,  4 Aug 2019 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564956919;
        bh=nZTSrb/LTY2MAB6nAXO0fol/JfFShvONnnQGkzjOUa4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dqaJuMpQupF/rvtPwFx9HqozchB7AHHAWObO+7ekInaLVD/YidquVA8O3XFxP+cIZ
         Z0j7jhUeL8CTuBfQn1Op04anAzluRoUpRJLi0Pz2ipPu9DVEn59D0ltfLIRFIkO7DZ
         dTHsnBb5T4uQmi96cmd9trbNT2XGVc9Ug6hFVfjU=
Date:   Mon, 5 Aug 2019 00:15:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Denis Efremov <efremov@linux.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Will Deacon <will@kernel.org>,
        Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
In-Reply-To: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
Message-ID: <nycvar.YFH.7.76.1908050013270.5899@cbobk.fhfr.pm>
References: <20190712185523.7208-1-efremov@ispras.ru> <20190713080726.GA19611@1wt.eu> <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru> <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com> <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019, Denis Efremov wrote:

> Well, without jokes about Thunderdome, I've got time, hardware and
> would like to maintain the floppy. Except the for recent fixes,
> I described floppy ioctls in syzkaller. I've already spent quite
> a lot of time with this code. Thus, if nobody minds
> 
> -- >8 --
> From: Denis Efremov <efremov@linux.com>
> Subject: [PATCH] MAINTAINERS: floppy: take over maintainership
> 
> I would like to maintain the floppy driver. After the recent fixes,
> I think I know the code pretty well. Nowadays I've got 2 physical 3.5"
> readers to test all the changes.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Awesome, thanks a lot Denis for offering to carry the torch I dropped. 
Obviously:

	Acked-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs


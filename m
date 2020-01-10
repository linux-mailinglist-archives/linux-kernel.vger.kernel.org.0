Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F62137843
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 22:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAJVFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 16:05:16 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:52242 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgAJVFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:05:15 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1iq1Sy-0002du-00; Fri, 10 Jan 2020 21:05:12 +0000
Date:   Fri, 10 Jan 2020 16:05:12 -0500
From:   Rich Felker <dalias@libc.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Guy Harris <guy@alum.mit.edu>
Subject: Re: [PATCH] hcidump: add support for time64 based libc
Message-ID: <20200110210512.GB30412@brightrain.aerifal.cx>
References: <20200110204903.3495832-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110204903.3495832-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 09:49:03PM +0100, Arnd Bergmann wrote:
> musl is moving to a default of 64-bit time_t on all architectures,
> glibc will follow later. This breaks reading timestamps through cmsg
> data with the HCI_TIME_STAMP socket option.
> 
> Change both copies of hcidump to work on all architectures.  This also
> fixes x32, which has never worked, and carefully avoids breaking sparc64,
> which is another special case.

Won't it be broken on rv32 though? Based on my (albeit perhaps
incomplete) reading of the thread, I think use of HCI_TIME_STAMP
should just be dropped entirely in favor of using SO_TIMESTAMPNS -- my
understanding was that it works with bluetooth sockets too.

Rich

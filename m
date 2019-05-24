Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F929783
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391215AbfEXLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 07:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390743AbfEXLpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:45:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4169C2168B;
        Fri, 24 May 2019 11:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558698350;
        bh=DtwbMLQuxLL8JPucnEoCkrw7f7w9/RQzp/gzFsIZI6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKRLd1qN3FDzsK+9OH+CIoXIAeFWfGHgQhTyiTVlNjv4vsc6f6B20VPvbD1En3TlN
         bwHSKqyeDNUFj23catdQieWwCwbge9w7qptMwQVNGaceQR6oQPtMi12YjPThp4litt
         EhT06EbicenLUhUV1F1CvCn3QEbstAbQoZShehxI=
Date:   Fri, 24 May 2019 13:45:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Elmar Gerdes <elmar.gerdes@cloud.ionos.com>
Subject: Re: Is 2nd Generation Intel(R) Xeon(R) Processors (Formerly Cascade
 Lake) affected by MDS
Message-ID: <20190524114547.GA686@kroah.com>
References: <CAMGffE=xsHWMNoGn75wzv9CLrQ81OizgLiwDEwqKw14i_eVj8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=xsHWMNoGn75wzv9CLrQ81OizgLiwDEwqKw14i_eVj8Q@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:23:40AM +0200, Jinpu Wang wrote:
> This e-mail may contain confidential and/or privileged information. If
> you are not the intended recipient of this e-mail, you are hereby
> notified that saving, distribution or use of the content of this
> e-mail in any way is prohibited. If you have received this e-mail in
> error, please notify the sender and delete the e-mail.

I am not allowed to respond to such emails as they do not mix well with
Linux kernel development requirements, sorry.

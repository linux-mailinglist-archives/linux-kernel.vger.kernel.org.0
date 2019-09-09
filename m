Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3275BAD9B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfIINJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 09:09:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfIINJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:09:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C724FB63D;
        Mon,  9 Sep 2019 13:09:50 +0000 (UTC)
Date:   Mon, 9 Sep 2019 15:09:57 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Thomas <trenn@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: /dev/mem and secure boot
Message-ID: <20190909150957.12abe684@endymion>
In-Reply-To: <20190906121510.GA17328@kroah.com>
References: <20190906130221.0b47a565@endymion>
        <20190906121510.GA17328@kroah.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, 6 Sep 2019 14:15:10 +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 06, 2019 at 01:02:21PM +0200, Jean Delvare wrote:
> > I've been bitten recently by mcelog not working on machines started in
> > secure boot mode. mcelog tries to read DMI information from /dev/mem
> > and fails to open it.  
> 
> What do you mean by "secure boot"?  Is this matthew's patchset that
> restricts /dev/mem/ or something else?

I mean that early in the kernel log is:

Secure boot enabled and kernel locked down

Digging it up, I found that this comes from a patch in our SLES kernel,
that's not upstream (yet). It is from a patch set by David Howells
(Cc'd) posted in April 2017:

https://patchwork.kernel.org/patch/9665591/
https://patchwork.kernel.org/patch/9665015/

I wrongly assumed it had been merged upstream meanwhile but I was
wrong. David, any reason why this didn't happen? Out of curiosity, are
these patches in RHEL kernels?

> > This made me wonder: if not even root can read /dev/mem (nor, I
> > suppose, /dev/kmem and /dev/port) in secure boot mode, why are we
> > creating these device nodes at all in the first place? Can't we detect
> > that we are in secure boot mode and skip that step, and reap the rewards
> > (faster boot, lower memory footprint and less confusion)?  
> 
> Sure, feel free to not register it at all if the mode is enabled.

Now I feel sorry that I asked my question upstream when there's nothing
to be done there. I'll go bother SUSE kernel folks instead, sorry for
the noise. And thanks for the advice.

-- 
Jean Delvare
SUSE L3 Support

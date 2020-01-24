Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F91478FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 08:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgAXHaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 02:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgAXHaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:30:20 -0500
Received: from localhost (unknown [145.15.244.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17F720709;
        Fri, 24 Jan 2020 07:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579851019;
        bh=iKMnz5OrMK8n5ERd5b5EaFMDSygKaHPRw/dXXW8Ce3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vUSS8IiIxtSgtNIFU/LKkzakvw+AAESAjOw97iML0vXo9GL0pQZk6+tv1mpzAsmt+
         X9jsqop37UcuFlf7bCiVWPKtHbEA6J4zQyFZfgILF49pWlws5ctwXYtIeOuGvDAkO7
         2DF7bGaMKu17ieySgggcr28q1Y8IQ4MO2Rx6RbB0=
Date:   Fri, 24 Jan 2020 08:29:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200124072940.GA2909311@kroah.com>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
 <20200122193118.GA88722@kroah.com>
 <20200123155340.GD147870@mit.edu>
 <20200123175536.GA1796501@kroah.com>
 <20200124060200.GG147870@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124060200.GG147870@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 01:02:00AM -0500, Theodore Y. Ts'o wrote:
> On Thu, Jan 23, 2020 at 06:55:36PM +0100, Greg Kroah-Hartman wrote:
> > > Instead of moving the control file IFF debugfs is enabled, what about
> > > always making it available in /proc, and marking the control file for
> > > dynamic_debug in debugfs as deprecated?  It would seem to me that this
> > > would cause less confusion in the future....
> > 
> > Why deprecate it?  It's fine where it is, and most developer's have
> > debugfs enabled so all is good.  I'd rather only use /proc as a
> > last-resort.
> 
> This makes life difficult for scripts that manipulate the control
> file, since they now need to check two different locations -- either
> /sys/kernel/debug or /proc.

That is literally 2 extra lines in a script file.  If you point me at
any that actually used the existing control file, I will be glad to fix
them up :)

> It's likely that people who normally use
> distribution kernels where debugfs is disabled will have scripts which
> are hard-coded to look in /proc, and then when they build a kernel
> with debugfs enabled, the /proc entry will go **poof**, and their
> script will break.

**poof** they didn't test it :)

Seriously, I am doing this change to make it _easier_ for those people
who want debugfs disabled, yet want this type of debugging.  This is
much better than having no debugging at all.

Don't put extra complexity in the kernel for when it can be trivially
handled in userspace, you know this :)

thanks,

greg k-h

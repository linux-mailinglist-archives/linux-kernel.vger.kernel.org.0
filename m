Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD81C0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 05:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfENDWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 23:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfENDWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 23:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E13A1C057F8F;
        Tue, 14 May 2019 03:22:15 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDAE71001DD5;
        Tue, 14 May 2019 03:22:11 +0000 (UTC)
Date:   Tue, 14 May 2019 11:22:08 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, j-nomura@ce.jp.nec.com,
        kasong@redhat.com, fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513080653.GD16774@MiWiFi-R3L-srv>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 14 May 2019 03:22:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/19 at 04:06pm, Baoquan He wrote:
> Hi Dave,
> 
> On 05/13/19 at 09:50am, Borislav Petkov wrote:
> > On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> > > This is a critical bug which breaks memory hotplug,
> > 
> > Please concentrate and stop the blabla:
> > 
> > 36f0c423552d ("x86/boot: Disable RSDP parsing temporarily")
> > 
> > already explains what the deal is. This code was *purposefully* disabled
> > because we ran out of time and it broke a couple of machines. Don't make
> 
> I remember your machine is the one on whihc the issue is reported. Could
> you also test it and confirm if these all things found ealier are
> cleared out?
> 

I did some tests on the laptop,  thing is:
1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
   on latest Linus master branch, everything works fine.

2. build and test the tip/next-merge-window branch, kernel hangs early
without output, (both 1st boot and kexec boot)

So I think these 3 patches are good,  but there could be other issues
which is not related to the problem we saw.

Another thing is we can move the get rsdp after console_init, but that
can be done later as separate patch.

Thanks
Dave

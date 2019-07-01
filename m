Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB101B1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 10:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfEMIHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 04:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfEMIHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:07:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62F6730842A0;
        Mon, 13 May 2019 08:07:00 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5A4D1001DC0;
        Mon, 13 May 2019 08:06:55 +0000 (UTC)
Date:   Mon, 13 May 2019 16:06:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     dyoung@redhat.com, Borislav Petkov <bp@alien8.de>
Cc:     j-nomura@ce.jp.nec.com, kasong@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190513080653.GD16774@MiWiFi-R3L-srv>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513075006.GB20105@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 13 May 2019 08:07:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 05/13/19 at 09:50am, Borislav Petkov wrote:
> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> > This is a critical bug which breaks memory hotplug,
> 
> Please concentrate and stop the blabla:
> 
> 36f0c423552d ("x86/boot: Disable RSDP parsing temporarily")
> 
> already explains what the deal is. This code was *purposefully* disabled
> because we ran out of time and it broke a couple of machines. Don't make

I remember your machine is the one on whihc the issue is reported. Could
you also test it and confirm if these all things found ealier are
cleared out?

Thanks
Baoquan

> me repeat all that - you were on CC on *all* threads and messages!
> 
> So we're going to try it again this cycle and if there's no fallout, it
> will go upstream. If not, it will have to be fixed. The usual thing.
> 
> And I don't care if Kairui's patch fixes this one problem - judging by
> the fragility of this whole thing, it should be hammered on one more
> cycle on as many boxes as possible to make sure there's no other SNAFUs.
> 
> So go test it on more machines instead. I've pushed it here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=next-merge-window
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

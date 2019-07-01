Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E395739C54
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfFHKGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 06:06:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54396 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfFHKGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:06:33 -0400
Received: from zn.tnic (p200300EC2F288A00DCF654BEDE068B01.dip0.t-ipconnect.de [IPv6:2003:ec:2f28:8a00:dcf6:54be:de06:8b01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00F2B1EC05D6;
        Sat,  8 Jun 2019 12:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559988391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J0c5GkEsaYQbLtP9J5ilmVR1Vgpny5H8ngwcgeeaXHo=;
        b=p3lTDm5PwVJmT23wP4Nn/Yh+ezegk/JtyB6Lt+BPCGOESHrTOw95HGP8u1oLD7dkSj2d4O
        k2jEVE89E4zOBfzhwfhuNk2PUQfDEGALbs3VbrMTOMXtqqOxBaZtxa71j6jZZZ0IrchLgI
        +3crZOEVryy24gZF7HODIINblOUotQw=
Date:   Sat, 8 Jun 2019 12:06:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190608100623.GA9138@zn.tnic>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190608100139.GC26148@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 06:01:39PM +0800, Baoquan He wrote:
> OK, it may be different with the case we met, if panic happened when
> load a kdump kernel.
> 
> We can load with 'kexec -l' or 'kexec -p', but can't boot after triggering
> crash or execute 'kexec -e' to do kexec jumping.

No, I load a kdump kernel properly with this command:

 kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+ --command-line="maxcpus=1 root=/dev/sda5 ro debug ignore_loglevel
log_buf_len=16M no_console_suspend net.ifnames=0 systemd.log_target=null mem_encrypt=on kvm_amd.sev=1 nr_cpus=1 irqpoll reset_devices vga=normal
LANG=en_US.UTF-8 earlyprintk=serial cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug
transparent_hugepage=never disable_cpu_apicid=0"

And that succeeds judging from

$ grep . /sys/kernel/kexec_*

Then I trigger a panic with

echo c > /proc/sysrq-trigger

and this is where it hangs and doesn't load the kdump kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

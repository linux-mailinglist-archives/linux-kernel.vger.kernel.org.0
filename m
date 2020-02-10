Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB01D15818E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 18:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgBJRlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 12:41:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36240 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBJRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:41:01 -0500
Received: from zn.tnic (p200300EC2F05D4004D75FE480EA5AF4B.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d400:4d75:fe48:ea5:af4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6C5E1EC02FE;
        Mon, 10 Feb 2020 18:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581356460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pOF6o6YMYQqQFnkYPCh4w2Eb/6cr2RfYCC/0CNSCMew=;
        b=MEtnI9WyJTmq+v47oLBT85KDdEp/9rCwHuOD4wR7xIJm4rrad97njqcxqFSGo4QOi9ESNa
        ZSrd/MR445/k3F/syEmElPaB5/7tZL5H4RgPKhalvcSmcm7GOPF7BO0oreZjf5/ekE6dCw
        HAdtKDCxbFSrycx1Kdfw3NRJaSuCGVM=
Date:   Mon, 10 Feb 2020 18:40:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config support
Message-ID: <20200210174053.GD29627@zn.tnic>
References: <20200114210316.450821675@goodmis.org>
 <20200114210336.259202220@goodmis.org>
 <20200206115405.GA22608@zn.tnic>
 <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
 <20200206175858.GG9741@zn.tnic>
 <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
 <20200207114122.GB24074@zn.tnic>
 <20200208000648.3383f991fee68af5ee229d65@kernel.org>
 <20200210112512.GA29627@zn.tnic>
 <20200211001007.62290c743e049b231bdd7052@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211001007.62290c743e049b231bdd7052@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:10:07AM +0900, Masami Hiramatsu wrote:
> Sure, there are some examples under Documentation/trace/boottime-trace.rst.
> Since the tracefs (ftrace's filesystem user interface) is extensible
> by dynamic events and instanses, I need flexibility of option "keys"
> not only values, also I need structured settings because some keys
> will configure same events or trace instance.

 [ ... ]

Yap, gotcha. It makes a lot of sense for you guys because you don't want
to be typing all those long ftrace command lines on every boot. And the
command line in grub can become too long and hard to handle too.

> 1) write a following bootconfig file
> ----
> kernel {
> 	# root device and resume devices
> 	root = /dev/disk/by-id/nvme-eui.0025385481b2fe2a-part2
> 	resume = /dev/disk/by-id/nvme-eui.0025385481b2fe2a-part1
> 	ro			# Mount root device readonly.
> 	debug			# boot with debug log
> 	ignore_loglevel	# this will print all messages
> 	log_buf_len = 16M	# So expand log buffer to 16MB
> 	no_console_suspend	# Debugging suspend process
> 	mem_encrypt = off	# Set AMD SME to off
> }
> 
> init {
> 	net.ifnames = 0	# Use tradisional ifname
> 	systemd.log_target = null	# Ignore systemd log?
> }

Ok.

However, this has a downside. When you request dmesg from a user because
you're debugging an issue - and we do that all the time - if the command
line were in a config file, we would have to see that config file too.

VS now, it is simply in dmesg.

> Boot time tracing is just a example. I think we can expand this for some
> other subsystems too. And this might be also helpful for adding a bit more
> complex syntax to those parameters without parser.

Yes, I think I see it now. And I still don't think you want this enabled
by default on every box. It is expressed perfectly fine here:

config BOOTTIME_TRACING
        bool "Boot-time Tracing support"
        depends on BOOT_CONFIG && TRACING

so if distros want to enable that, they will enable BOOT_CONFIG too,
transitively. And other subsystems would simply depend on it the same if
they wanna use bootconfig.

But the way we supply command line args now ain't broke. And they normal
user doesn't care - grub simply pastes them everywhere.

Don't get me wrong - I don't mind using a bootconfig. I simply don't see
a compelling argument to have it enabled everywhere and by default and
think that other stuff selecting it is perfectly fine. IMO, of course.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

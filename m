Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB41F522E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfKHRFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 12:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfKHRFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:05:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A243A206BA;
        Fri,  8 Nov 2019 17:05:50 +0000 (UTC)
Date:   Fri, 8 Nov 2019 12:05:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: Re: libtraceevent installing in wrong folder
Message-ID: <20191108120548.4118879a@gandalf.local.home>
In-Reply-To: <20191108161157.g5aadocnfvragqb2@debian>
References: <20191108161157.g5aadocnfvragqb2@debian>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ I also added linux-trace-devel, but it was good to Cc LKML too ]

On Fri, 8 Nov 2019 16:11:57 +0000
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> Hi Steve,
> 
> I tried to install libtraceevent. and I used the command:
> "make DESTDIR=/home/sudip/test prefix=/usr install" from tool/lib/traceevent
> 
> And this is what I get:
> sudip@debian:~/test$ pwd
> /home/sudip/test
> 
> sudip@debian:~/test$ find .
> .
> ./usr
> ./usr/local
> ./usr/local/lib
> ./usr/local/lib/x86_64-linux-gnu
> ./usr/local/lib/x86_64-linux-gnu/pkgconfig
> ./usr/local/lib/x86_64-linux-gnu/pkgconfig/libtraceevent.pc
> ./usr/lib64
> ./usr/lib64/traceevent
> ./usr/lib64/traceevent/plugins
> ./usr/lib64/traceevent/plugins/plugin_hrtimer.so
> ./usr/lib64/traceevent/plugins/plugin_sched_switch.so
> ./usr/lib64/traceevent/plugins/plugin_jbd2.so
> ./usr/lib64/traceevent/plugins/plugin_kvm.so
> ./usr/lib64/traceevent/plugins/plugin_cfg80211.so
> ./usr/lib64/traceevent/plugins/plugin_kmem.so
> ./usr/lib64/traceevent/plugins/plugin_scsi.so
> ./usr/lib64/traceevent/plugins/plugin_mac80211.so
> ./usr/lib64/traceevent/plugins/plugin_function.so
> ./usr/lib64/traceevent/plugins/plugin_xen.so
> ./usr/lib64/libtraceevent.so
> ./usr/lib64/libtraceevent.so.1.1.0
> ./usr/lib64/libtraceevent.a
> ./usr/lib64/libtraceevent.so.1
> ./home
> ./home/sudip
> ./home/sudip/test
> ./home/sudip/test/usr
> ./home/sudip/test/usr/include
> ./home/sudip/test/usr/include/traceevent
> ./home/sudip/test/usr/include/traceevent/event-parse.h
> ./home/sudip/test/usr/include/traceevent/trace-seq.h
> ./home/sudip/test/usr/include/traceevent/kbuffer.h
> ./home/sudip/test/usr/include/traceevent/event-utils.h
> 
> I am seeing two problems:
> 1) It created another home/sudip/test folder inside /home/sudip/test and
> the header files are installed in /home/sudip/test/home/sudip/test/usr/include folder.
> They should have been in /home/sudip/test/usr/include.
> 
> 2) I used prefix=/usr but the 'pkgconfig' still went to /usr/local
> 
> Did I do something wrong?

No, but you showed that the installation part is poorly tested. I
mostly tested just the code from trace-cmd, and even the installation
paths from that repo. I should have tested the kernel repo as well, but
failed to do this.

Thanks for reporting, I need to take a look, or if you want to have a go
at it, that would be great too :-)

-- Steve



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FE726A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 21:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfEVTCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 15:02:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56520 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728615AbfEVTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:02:30 -0400
Received: (qmail 10222 invoked by uid 2102); 22 May 2019 15:02:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 May 2019 15:02:29 -0400
Date:   Wed, 22 May 2019 15:02:29 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal/usb: Replace kill_pid_info_as_cred with
 kill_pid_usb_asyncio
In-Reply-To: <877eakou9o.fsf@xmission.com>
Message-ID: <Pine.LNX.4.44L0.1905221459170.1410-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Eric W. Biederman wrote:

> The usb support for asyncio encoded one of it's values in the wrong
> field.  It should have used si_value but instead used si_addr which is
> not present in the _rt union member of struct siginfo.
> 
> The practical result of this is that on a 64bit big endian kernel
> when delivering a signal to a 32bit process the si_addr field
> is set to NULL, instead of the expected pointer value.
> 
> This issue can not be fixed in copy_siginfo_to_user32 as the usb
> usage of the the _sigfault (aka si_addr) member of the siginfo
> union when SI_ASYNCIO is set is incompatible with the POSIX and
> glibc usage of the _rt member of the siginfo union.
> 
> Therefore replace kill_pid_info_as_cred with kill_pid_usb_asyncio a
> dedicated function for this one specific case.  There are no other
> users of kill_pid_info_as_cred so this specialization should have no
> impact on the amount of code in the kernel.  Have kill_pid_usb_asyncio
> take instead of a siginfo_t which is difficult and error prone, 3
> arguments, a signal number, an errno value, and an address enconded as
> a sigval_t.  The encoding of the address as a sigval_t allows the
> code that reads the userspace request for a signal to handle this
> compat issue along with all of the other compat issues.
> 
> Add BUILD_BUG_ONs in kernel/signal.c to ensure that we can now place
> the pointer value at the in si_pid (instead of si_addr).  That is the
> code now verifies that si_pid and si_addr always occur at the same
> location.  Further the code veries that for native structures a value
> placed in si_pid and spilling into si_uid will appear in userspace in
> si_addr (on a byte by byte copy of siginfo or a field by field copy of
> siginfo).  The code also verifies that for a 64bit kernel and a 32bit
> userspace the 32bit pointer will fit in si_pid.

Okay, I have gone through this.  Although I still don't really
understand the detailed issues concerning the layout of the data fields
(probably hopeless without seeing a diagram), the USB portions of the
patch look good and do what the patch description says.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern


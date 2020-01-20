Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA8142EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgATPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 10:23:13 -0500
Received: from netrider.rowland.org ([192.131.102.5]:46005 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726819AbgATPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:23:12 -0500
Received: (qmail 18294 invoked by uid 500); 20 Jan 2020 10:23:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jan 2020 10:23:11 -0500
Date:   Mon, 20 Jan 2020 10:23:11 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Paul Zimmerman <pauldzim@gmail.com>
cc:     David Heinzelmann <heinzelmann.david@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [REGRESSION][BISECTED] 5.5-rc suspend/resume failure caused by
 patch a4f55d8b8c14 ("usb: hub: Check device descriptor before resusciation")
In-Reply-To: <20200119211145.7dcc86ec@EliteBook>
Message-ID: <Pine.LNX.4.44L0.2001201016300.16814-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020, Paul Zimmerman wrote:

> I reported this regression last week (see
> https://lore.kernel.org/linux-usb/20200115153714.03d5b3aa@EliteBook/T/#u)
> but I got no response to my email. Today I have retested with 5.5-rc7
> and verified that the problem still exists. So I am resending with a
> different subject line to see if anyone responds.
> 
> The $subject patch causes a regression on my HP EliteBook laptop with a
> built-in USB bluetooth adapter. About 50% of the time, a suspend/resume
> cycle will cause the bluetooth adapter to stop working.
> 
> The dmesg log below shows two suspend/resume cycles. At time 63.928 you can
> see the bluetooth adapter being successfully resumed, and at time 140.969
> you can see it fail. After reverting the patch, the bluetooth adapter
> resumes 100% of the time.
> 
> I also included below a lsusb -v of the bluetooth adapter. Is there any
> other debugging info you'd like me to send?

It looks like your dmesg log was made without enabling debugging 
messages in usbcore.  Can you collect another log with debugging 
messages turned on?

	echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control

Also, it might not hurt to collect and post a usbmon trace for a bad
suspend-resume cycle.

Alan Stern


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05F5253E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfEUPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 11:30:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33556 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728045AbfEUPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:30:17 -0400
Received: (qmail 5537 invoked by uid 2102); 21 May 2019 11:30:16 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 May 2019 11:30:16 -0400
Date:   Tue, 21 May 2019 11:30:16 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] signal/usb: Replace kill_pid_info_as_cred with
 kill_pid_usb_asyncio
In-Reply-To: <87zhnfooe6.fsf@xmission.com>
Message-ID: <Pine.LNX.4.44L0.1905211129020.1634-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Eric W. Biederman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:

> >> 	req = (struct usb_ctrlrequest *) buf;
> >> 	req->bRequestType = USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE;
> >> 	req->bRequest = USB_REQ_GET_DESCRIPTOR;
> >> 	req->wValue = htole16(USB_DT_DEVICE << 8);
> >> 	req->wIndex = htole16(0);
> >> 	req->wLength = htole16(sizeof(buf) - sizeof(*req));
> >
> > In fact, these values are supposed to be in host-endian order, not 
> > necessarily little-endian.  The USB core converts them if necessary.
> 
> Please look again.  In include/uapi/linux/ch9.h those fields are
> explicitly defined as little endian and the code in devio.c for
> USBDEVFS_URB_TYPE_CONTROL treats them as little endian.   Perhaps there
> is a mismatch here but I haven't seen it and I needed this change to get
> the code to work on big endian.

Oops -- you're right.  I was thinking of the USBDEVFS_CONTROL ioctl.  
Sorry for the mistake.

Alan Stern


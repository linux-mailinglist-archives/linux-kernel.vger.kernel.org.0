Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC649195B32
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 17:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgC0QgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 12:36:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50777 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727740AbgC0QgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:36:00 -0400
Received: (qmail 16971 invoked by uid 500); 27 Mar 2020 12:35:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Mar 2020 12:35:59 -0400
Date:   Fri, 27 Mar 2020 12:35:59 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     vladimir.stankovic@displaylink.com
cc:     gregkh@linuxfoundation.org, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mausb-host-devel@displaylink.com>
Subject: Re: [PATCH v4 5/8] usb: mausb_host: Introduce PAL processing
In-Reply-To: <20200327152614.26833-6-vladimir.stankovic@displaylink.com>
Message-ID: <Pine.LNX.4.44L0.2003271233160.14887-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 vladimir.stankovic@displaylink.com wrote:

> Protocol adaptation layer (PAL) implementation has been added to
> introduce MA-USB structures and logic.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> ---
> +	/*
> +	 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where it
> +	 * should not, so it is breaking the USB drive on the linux
> +	 */
> +	urb->transfer_flags &= ~URB_SHORT_NOT_OK;

Please explain more fully.  What SCSI driver are you talking about?  
Where is the flag getting added incorrectly?  What USB drive is getting
broken, and how?

If there's a bug in a SCSI driver, why don't you report it and get it
fixed instead of trying to create a workaround in just one host 
controller driver?

Alan Stern


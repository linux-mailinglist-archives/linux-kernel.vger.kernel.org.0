Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD7E2666C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfEVO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 10:58:10 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55598 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727975AbfEVO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:58:10 -0400
Received: (qmail 2723 invoked by uid 2102); 22 May 2019 10:58:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 May 2019 10:58:09 -0400
Date:   Wed, 22 May 2019 10:58:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
cc:     "hch@lst.de" <hch@lst.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v5 2/5] USB: use genalloc for USB HCs with local memory
In-Reply-To: <cb0612c3-4429-7ac9-e885-64407f8a406b@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1905221056140.1410-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Laurentiu Tudor wrote:

> >> +EXPORT_SYMBOL_GPL(usb_hcd_setup_local_mem);
> > 
> > If you have a usb_hcd_setup_local_mem() function then you should also
> > have a usb_hcd_remove_local_mem() function.
> 
> Even if all resources that are allocated are device managed?

Ah, I missed that fact.  Okay, that's all right.

Alan Stern


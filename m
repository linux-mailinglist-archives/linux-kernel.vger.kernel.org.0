Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5791153D5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfLFPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 10:04:19 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:45596 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726268AbfLFPET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:04:19 -0500
Received: (qmail 1779 invoked by uid 2102); 6 Dec 2019 10:04:18 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Dec 2019 10:04:18 -0500
Date:   Fri, 6 Dec 2019 10:04:18 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jayshri Pawar <jpawar@cadence.com>
cc:     linux-usb@vger.kernel.org, <gregkh@linuxfoundation.org>,
        <felipe.balbi@linux.intel.com>, <heikki.krogerus@linux.intel.com>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>, <pawell@cadence.com>,
        <sparmar@cadence.com>
Subject: Re: [RFC PATCH v2] usb:gadget: Fixed issue with config_ep_by_speed
 function.
In-Reply-To: <1575632539-13528-1-git-send-email-jpawar@cadence.com>
Message-ID: <Pine.LNX.4.44L0.1912061001050.1618-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019, Jayshri Pawar wrote:

> This patch adds additional parameter alt to config_ep_by_speed function.
> This additional parameter allows to improve this function and
> find proper usb_ss_ep_comp_descriptor.
> 
> Problem has appeared during testing f_tcm (BOT/UAS) driver function.
> 
> f_tcm function for SS use array of headers for both  BOT/UAS alternate
> setting:
> 
> static struct usb_descriptor_header *uasp_ss_function_desc[] = {
>         (struct usb_descriptor_header *) &bot_intf_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bi_desc,
>         (struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bo_desc,
>         (struct usb_descriptor_header *) &bot_bo_ep_comp_desc,
> 
>         (struct usb_descriptor_header *) &uasp_intf_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bi_desc,
>         (struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_bi_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_bo_desc,
>         (struct usb_descriptor_header *) &uasp_bo_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_bo_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_status_desc,
>         (struct usb_descriptor_header *) &uasp_status_in_ep_comp_desc,
>         (struct usb_descriptor_header *) &uasp_status_pipe_desc,
>         (struct usb_descriptor_header *) &uasp_ss_cmd_desc,
>         (struct usb_descriptor_header *) &uasp_cmd_comp_desc,
>         (struct usb_descriptor_header *) &uasp_cmd_pipe_desc,
>         NULL,
> };
> 
> The first 5 descriptors are associated with BOT alternate setting,
> and others are associated  with UAS.

If the first 5 descriptors are really associated with the BOT alternate
setting, why is the second descriptor named uasp_ss_bi_desc?  And why
is the fourth descriptor named uasp_ss_bo_desc?  These names suggest
they are associated with UAS.

If the same descriptors are used for both settings, the names should 
reflect this.  For example, they could be called bot_uasp_ss_bi_desc 
and bot_uasp_ss_bo_desc.

Alan Stern


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91786183526
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 16:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCLPmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 11:42:32 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54132 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727237AbgCLPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:42:31 -0400
Received: (qmail 4269 invoked by uid 2102); 12 Mar 2020 11:42:30 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Mar 2020 11:42:30 -0400
Date:   Thu, 12 Mar 2020 11:42:30 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/1] usb: gadget: add raw-gadget interface
In-Reply-To: <CAAeHK+wTbBC2Dm6GVXVqKTsn9gKg1_EZ5MggmLBMaA6wA-wq4w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2003121141540.1528-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020, Andrey Konovalov wrote:

> Hi Greg, Felipe, and Alan,
> 
> I was wondering if there's a way to move forward with this patch?
> 
> Alan, since you have a very good knowledge of the USB subsystem, could
> I ask you to take a look at the patch, while Felipe is busy?

I'll look through the driver when I get a chance.  That might not be 
for a while, though...

Alan Stern


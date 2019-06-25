Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E856E5233A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 08:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfFYGAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 02:00:36 -0400
Received: from verein.lst.de ([213.95.11.211]:59667 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfFYGAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:00:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1546568B02; Tue, 25 Jun 2019 08:00:00 +0200 (CEST)
Date:   Tue, 25 Jun 2019 08:00:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        laurentiu.tudor@nxp.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190625060000.GA28986@lst.de>
References: <20190611133223.GA30054@roeck-us.net> <20190611172654.GA2602@sx9> <20190611190343.GA18459@roeck-us.net> <20190613134033.GA2489@sx9> <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net> <20190613153414.GA909@sx9> <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net> <20190614142816.GA2574@sx9> <20190624063515.GA3296@lst.de> <20190624125916.GA2516@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624125916.GA2516@sx9>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 02:59:16PM +0200, Fredrik Noring wrote:
> Hi Christoph,
> 
> > Can you send me the patch formally so that I can queue it up for the
> > dma-mapping tree?
> 
> That patch would be detrimental to local memory devices, as previously
> discussed, so I would like to suggest a much better approach, as shown below,
> where allocations are aligned as required but not necessarily much more than
> that.

This looks sensible to me.  Can you submit it with a proper patch
description and split into a separate patch for genalloc vs the user of
the new interface?

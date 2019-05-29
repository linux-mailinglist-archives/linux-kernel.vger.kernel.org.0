Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1509B2DBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfE2LZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 07:25:43 -0400
Received: from verein.lst.de ([213.95.11.211]:54149 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2LZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:25:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6C7BB68B05; Wed, 29 May 2019 13:25:16 +0200 (CEST)
Date:   Wed, 29 May 2019 13:25:15 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v7 2/5] USB: use genalloc for USB HCs with local memory
Message-ID: <20190529112515.GA8982@lst.de>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com> <20190529102843.13174-3-laurentiu.tudor@nxp.com> <20190529103838.GC7383@kroah.com> <34a83e74-4c85-cf9f-54c3-b69b0dcb628e@nxp.com> <20190529112334.GA11368@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529112334.GA11368@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 04:23:34AM -0700, Greg KH wrote:
> As long as GENERIC_ALLOCATOR works on all arches, yes, that's fine, but
> please verify that this is the case.

It works everywhere.  The issue here is just that it get pulled in
by default on most architetures, but not on all.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE213459E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgAHPEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:04:31 -0500
Received: from verein.lst.de ([213.95.11.211]:49685 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgAHPEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:04:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4526468BFE; Wed,  8 Jan 2020 16:04:28 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:04:28 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Singh, Balbir" <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Message-ID: <20200108150428.GB10975@lst.de>
References: <20200102075315.22652-1-sblbir@amazon.com> <20200102075315.22652-2-sblbir@amazon.com> <yq1ftgs2b6g.fsf@oracle.com> <d1635bae908b59fb4fd7de7c90ffbd5b73de7542.camel@amazon.com> <yq17e221vvt.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17e221vvt.fsf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:15:34PM -0500, Martin K. Petersen wrote:
> 
> Balbir,
> 
> > I did this to avoid having to enforce that set_capacity() implied a
> > notification. Largely to control the impact of the change by default.
> 
> What I thought. I'm OK with set_capacity_and_notify(), btw.

To some extent it might make sense to always notify from set_capacity
and have a set_capacity_nonotify if we don't want to notify, as in
general we probably should notify unless we have a good reason not to.

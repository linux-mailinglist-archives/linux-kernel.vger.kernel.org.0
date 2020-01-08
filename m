Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05CD13458C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgAHPCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:02:48 -0500
Received: from verein.lst.de ([213.95.11.211]:49671 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgAHPCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:02:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5230B68BFE; Wed,  8 Jan 2020 16:02:45 +0100 (CET)
Date:   Wed, 8 Jan 2020 16:02:45 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Balbir Singh <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ssomesh@amazon.com" <ssomesh@amazon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Message-ID: <20200108150245.GA10975@lst.de>
References: <20200102075315.22652-1-sblbir@amazon.com> <20200102075315.22652-2-sblbir@amazon.com> <BYAPR04MB5749EE1549B30FCECEC1154B86230@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749EE1549B30FCECEC1154B86230@BYAPR04MB5749.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 06:16:39AM +0000, Chaitanya Kulkarni wrote:
> Since disk_set_capacity(() is on the same line as set_capacity()
> we should follow the same convention, which is :-
> 
> 1. Avoid exporting symbol.
> 2. Mark new function in-line.
> 
> Unless there is a very specific reason for breaking the pattern.

Why would we mark it as inline?  It isn't by any means in the fast
path, and there are no easy opportunities for constant propagation,
so the only thing that would do is increase the code size.

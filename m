Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD4D7058
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfJOHoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 03:44:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KGkVZgjDVrp5L3t6DBJT+MXjO2uFy5oiRc2Hxyh04do=; b=Y7WSZXefm0gZn15zSHsb+0ax8
        sIf1ybVNZVEBpgVRbvpClloxR9i4MrIve0efTatqPWovqscvxYHhAcXUWgXx5PmN3YbIPJ5hVGVKZ
        meHQzxLqSDejH3PBHp4JRATXgtLOA0sWt5q/71hDY7Wx11OJJKIl/8wey221L2dc+6GfigrNQ9KU4
        0ax2mdeT+GSQWAgYr9v4ODdbxMkEbxy1bX0WQ2Re7mnMexruuuoPn23DdQ1l3+RjUPofQSVi6FLUh
        tSbbDdwR6aLjSosZINxfNJnYs0tvq2sgvbpuvPH9mrHO29HMIgG04EJWnFnDj86F0F6GtwjS8qkkO
        Dqhy6HtHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHVK-0002T4-Ll; Tue, 15 Oct 2019 07:44:26 +0000
Date:   Tue, 15 Oct 2019 00:44:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Colin King <colin.king@canonical.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Tomohiro Kusumi <kusumi.tomohiro@jp.fujitsu.com>,
        Kei Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
        Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fix unintended sign extension on left shifts
Message-ID: <20191015074426.GA8715@infradead.org>
References: <20191014121613.21999-1-colin.king@canonical.com>
 <0e2a6d4c-b346-cb1b-7941-e247a0d0f8b2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2a6d4c-b346-cb1b-7941-e247a0d0f8b2@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:58:03AM -0700, Bart Van Assche wrote:
> On 10/14/19 5:16 AM, Colin King wrote:
> >   	const char *ret = trace_seq_buffer_ptr(p);
> >   	sector_t lba = 0, txlen = 0;
> > -	lba |= (cdb[2] << 24);
> > +	lba |= ((u64)cdb[2] << 24);
> >   	lba |= (cdb[3] << 16);
> >   	lba |= (cdb[4] << 8);
> >   	lba |=  cdb[5];
> 
> Have you considered to use get/put_unaligned_be*() instead of making the
> above change?

Agreed, that is the only sensible thing to do here.

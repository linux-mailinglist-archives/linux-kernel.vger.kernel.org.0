Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169C91976E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgC3Irr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Mar 2020 04:47:47 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:53475 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgC3Irr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:47:47 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 682A6240008;
        Mon, 30 Mar 2020 08:47:42 +0000 (UTC)
Date:   Mon, 30 Mar 2020 10:47:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <zhangweimin12@huawei.com>,
        <yebin10@huawei.com>, <houtao1@huawei.com>
Subject: Re: [PATCH] mtd:clear cache_state to avoid writing to bad clocks
 repeatedly
Message-ID: <20200330104741.2f48378d@xps13>
In-Reply-To: <a012c55f-e7c4-fd6d-3e3f-f132474a0b06@huawei.com>
References: <1585400477-65705-1-git-send-email-nixiaoming@huawei.com>
        <20200330095341.284048c3@xps13>
        <a012c55f-e7c4-fd6d-3e3f-f132474a0b06@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaoming,

Xiaoming Ni <nixiaoming@huawei.com> wrote on Mon, 30 Mar 2020 16:44:29
+0800:

> On 2020/3/30 15:53, Miquel Raynal wrote:
> > Hi Xiaoming,
> > 
> > Xiaoming Ni <nixiaoming@huawei.com> wrote on Sat, 28 Mar 2020 21:01:17
> > +0800:
> >   
> >> The function call process is as follows:
> >> 	mtd_blktrans_work()
> >> 	  while (1)  
> ....
> 
> >> +	 *
> >> +	 * if this cache_offset points to a bad block  
> > 
> > Can you start your sentences with a capital letter please?
> > 
> > 	 * If
> >   
> >> +	 * data cannot be written to the device.
> >> +	 * clear cache_state to avoid writing to bad clocks repeatedly  
> > 
> > 	 * Clear
> > 
> > And also please break your lines à 80, not 70.
> >   
> >>   	 */
> >> -	mtdblk->cache_state = STATE_EMPTY;
> >> -	return 0;
> >> +	if (ret == 0 || ret == -EIO)
> >> +		mtdblk->cache_state = STATE_EMPTY;  
> Should I add a warning print for EIO here

I don't think so.

Thanks,
Miquèl

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D2191C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 23:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgCXWGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Mar 2020 18:06:24 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34383 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgCXWGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:06:24 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0B774FF802;
        Tue, 24 Mar 2020 22:06:21 +0000 (UTC)
Date:   Tue, 24 Mar 2020 23:06:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zhangweimin12@huawei.com>, <wangle6@huawei.com>
Subject: Re: [PATCH] mtd:Fix issue where write_cached_data() fails but
 write() still returns success
Message-ID: <20200324230620.174db1a7@xps13>
In-Reply-To: <1584674111-101462-1-git-send-email-nixiaoming@huawei.com>
References: <1584674111-101462-1-git-send-email-nixiaoming@huawei.com>
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

Xiaoming Ni <nixiaoming@huawei.com> wrote on Fri, 20 Mar 2020 11:15:11
+0800:

> mtdblock_flush()
> 	-->write_cached_data()
> 		--->erase_write()  
> 		     mtdblock: erase of region [0x40000, 0x20000] on "xxx" failed
> 
> Because mtdblock_flush() always returns 0,
> even if write_cached_data() fails and data is not written to the device,
> syscall_write() still returns success

I reworded a bit the commit log and also added a ' ' after 'mtd:' in
the title when applying.

Thanks,
Miquèl

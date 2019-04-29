Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9DDD83
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 10:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfD2IQu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Apr 2019 04:16:50 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:56799 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfD2IQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:16:50 -0400
X-Originating-IP: 90.88.147.33
Received: from xps13 (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BED4CFF81A;
        Mon, 29 Apr 2019 08:16:45 +0000 (UTC)
Date:   Mon, 29 Apr 2019 10:16:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kyungmin.park@samsung.com, bbrezillon@kernel.org, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/5] mtd: onenand/samsung: Unify resource order for
 controller variants
Message-ID: <20190429101644.7c46c05d@xps13>
In-Reply-To: <20190426164224.11327-2-pawel.mikolaj.chmiel@gmail.com>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
        <20190426164224.11327-2-pawel.mikolaj.chmiel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote on Fri, 26 Apr 2019
18:42:20 +0200:

> From: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Before this patch, the order of memory resources requested by the driver
> was controller base as first and OneNAND chip base as second for
> S3C64xx/S5PC100 variant and the opposite for S5PC110/S5PV210 variant.
> 
> To make this more consistent, this patch swaps the order of resources
> for the latter and updates platform code accordingly. As a nice side
> effect there is a slight reduction in line count of probe function.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Thanks for the patch but it looks like you also are renaming fields in
the main onenand structure. Maybe it is worth doing it in a preliminary
patch.

Thanks,
Miquèl

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFF135D37
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 16:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732653AbgAIPx7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jan 2020 10:53:59 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:52949 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbgAIPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:53:59 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 62AEE200003;
        Thu,  9 Jan 2020 15:53:57 +0000 (UTC)
Date:   Thu, 9 Jan 2020 16:53:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: denali: add missed pci_release_regions
Message-ID: <20200109165356.24a54351@xps13>
In-Reply-To: <CAK7LNAQsK5JD-qeBugp9mn8DgW+SYttp5AwZ_ht5KY2MhPe-Ew@mail.gmail.com>
References: <20191206075432.18412-1-hslester96@gmail.com>
        <CAK7LNAQsK5JD-qeBugp9mn8DgW+SYttp5AwZ_ht5KY2MhPe-Ew@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <masahiroy@kernel.org> wrote on Fri, 6 Dec 2019
19:32:03 +0900:

> Hi.
> 
> On Fri, Dec 6, 2019 at 4:54 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > The driver forgets to call pci_release_regions() in probe failure
> > and remove.
> > Add the missed calls to fix it.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---  
> 
> This patch looks equivalent to what I submitted,
> then was rejected a couple of years ago.
> https://lists.gt.net/linux/kernel/2557740

Thanks for the reminder, otherwise I would have applied it too.

Thanks,
Miquèl

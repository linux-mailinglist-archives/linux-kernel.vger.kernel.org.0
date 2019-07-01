Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCA59E52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfF1PBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 11:01:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:35046 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1PBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:01:52 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 26C8A2B4;
        Fri, 28 Jun 2019 15:01:52 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:01:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 9/9] platform: x86: get rid of a non-existent document
Message-ID: <20190628090151.486d185e@lwn.net>
In-Reply-To: <CAHp75VfkWkVvvufTje1G+w=7gjsr7D2On-NsOsOoTEBNLVLJzQ@mail.gmail.com>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
        <9472251c3ff159b832b4e82d77836c44f89b49b0.1561723736.git.mchehab+samsung@kernel.org>
        <CAHp75VfkWkVvvufTje1G+w=7gjsr7D2On-NsOsOoTEBNLVLJzQ@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 17:49:48 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 28, 2019 at 3:12 PM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > Changeset 163ede97a9a2 ("Documentation: platform: Delete x86-laptop-drivers.txt")
> > removed the x86-laptop-drivers.txt file, but forgot to update its
> > Kconfig.  
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

The patch that brought this situation into being is in docs-next, so I
applied this one too.

jon

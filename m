Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0967CF10
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 22:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfGaUsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 16:48:18 -0400
Received: from ms.lwn.net ([45.79.88.28]:56362 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbfGaUsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:48:18 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EFB3D7DA;
        Wed, 31 Jul 2019 20:48:17 +0000 (UTC)
Date:   Wed, 31 Jul 2019 14:48:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] docs: writing-schema.md: convert from markdown to
 ReST
Message-ID: <20190731144816.71238678@lwn.net>
In-Reply-To: <20190731204500.GA6131@bogus>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
        <a239cd93ad86579ce7e02bc3032abd33b476e193.1564603513.git.mchehab+samsung@kernel.org>
        <20190731204500.GA6131@bogus>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 14:45:00 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Jul 31, 2019 at 05:08:49PM -0300, Mauro Carvalho Chehab wrote:
> > The documentation standard is ReST and not markdown.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/writing-schema.md  | 130 -----------------
> >  Documentation/devicetree/writing-schema.rst | 153 ++++++++++++++++++++
> >  2 files changed, 153 insertions(+), 130 deletions(-)
> >  delete mode 100644 Documentation/devicetree/writing-schema.md
> >  create mode 100644 Documentation/devicetree/writing-schema.rst  
> 
> Applied, thanks.

I've applied that to docs-next as well - your ack suggested to me that you
weren't intending to take it...

jon

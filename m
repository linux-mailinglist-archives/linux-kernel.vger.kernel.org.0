Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2F65329
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfGKI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 04:28:29 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:34316 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKI22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:28:28 -0400
Date:   Thu, 11 Jul 2019 08:28:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1562833706;
        bh=uO/ecoIZ2xzNWLdcDpPcmeAWP8zlhJ3RlT1sV4HBWmw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=iRvRu6fn8uLULxJGDBqYbkw16kiVfajS53oG9l4Krbq11GjnhOYVHxR9/vbDD+A8K
         tAc81R2aMl37+/3IvtzLPPP6Ic+CHW3G3yYBfgRUHhZTsIBVthtfHrhKqUNS3rscM7
         pl2UfCfEt8Bm6//efUUusEn9PiOqGt9I42Uaao+Q=
To:     Daniel Vetter <daniel@ffwll.ch>
From:   Simon Ser <contact@emersion.fr>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH V3 4/5] drm/vkms: Compute CRC without change input data
Message-ID: <hG3hgN80Bt03njzCaW7h3xaog7ppTTBzmsShC0L5LdCbr5dFkHMJHHxizeYa_IYP7uCwMG-vPJOWMhueq2LirNKFhulkkni2KFf3XA24bb8=@emersion.fr>
In-Reply-To: <20190711082105.GI15868@phenom.ffwll.local>
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <ea7e3a0daa4ee502d8ec67a010120d53f88fa06b.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <20190711082105.GI15868@phenom.ffwll.local>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 11, 2019 11:21 AM, Daniel Vetter <daniel@ffwll.ch> wrote:

> On Tue, Jun 25, 2019 at 10:38:31PM -0300, Rodrigo Siqueira wrote:
>
> > The compute_crc() function is responsible for calculating the
> > framebuffer CRC value; due to the XRGB format, this function has to
> > ignore the alpha channel during the CRC computation. Therefore,
> > compute_crc() set zero to the alpha channel directly in the input
> > framebuffer, which is not a problem since this function receives a copy
> > of the original buffer. However, if we want to use this function in a
> > context without a buffer copy, it will change the initial value. This
> > patch makes compute_crc() calculate the CRC value without modifying the
> > input framebuffer.
>
> Uh why? For writeback we're writing the output too, so we can write
> whatever we want to into the alpha channel. For writeback we should never
> accept a pixel format where alpha actually matters, that doesn't make
> sense. You can't see through a real screen either, they are all opaque :-=
)

I'm not sure about that. See e.g.
https://en.wikipedia.org/wiki/See-through_display

Many drivers already accept FBs with alpha channels for the primary
plane.
https://drmdb.emersion.fr/formats?plane=3D1

Just making sure we aren't painting ourselves into a corner. :P

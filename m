Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767632DEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfE2Nud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 09:50:33 -0400
Received: from ms.lwn.net ([45.79.88.28]:41756 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfE2Nuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:50:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A5222B4;
        Wed, 29 May 2019 13:50:32 +0000 (UTC)
Date:   Wed, 29 May 2019 07:50:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH 6/8] docs/gpu: fix a documentation build break in
 i915.rst
Message-ID: <20190529075031.5275d065@lwn.net>
In-Reply-To: <CAKMK7uFVP6o5jU_cEPshYXwWN39ohybid52yBj567dGBiejzTg@mail.gmail.com>
References: <20190522205034.25724-1-corbet@lwn.net>
        <20190522205034.25724-7-corbet@lwn.net>
        <CAKMK7uFVP6o5jU_cEPshYXwWN39ohybid52yBj567dGBiejzTg@mail.gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 08:54:16 +0200
Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> > Documentation/gpu/i915.rst is not included in the TOC tree, but newer
> > versions of sphinx parse it anyway.  That leads to this hard build failure:  
> 
> It is included I think: Documentation/gpu/index.rst -> drivers.rst ->
> i915.rst. With that corrected A-b: me.
> 
> btw this patch didn't go to intel-gfx and all i915 maintainers, I
> think per get_maintainers.pl it should have. Just asking since I had a
> few patches of my own where get_maintainers.pl didn't seem to do the
> right thing somehow.

It is included, just a level down and I wasn't paying attention.

In any case, this patch needs to be dropped; the kerneldoc comment
changes I sent (and Jani acked) are the better fix for this problem.

Thanks,

jon

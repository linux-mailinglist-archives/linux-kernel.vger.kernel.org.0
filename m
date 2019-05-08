Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA34418161
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfEHU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:58:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:55020 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfEHU6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:58:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7ADE6316;
        Wed,  8 May 2019 20:58:19 +0000 (UTC)
Date:   Wed, 8 May 2019 14:58:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: GFS2: Pull Request
Message-ID: <20190508145818.6a53dff5@lwn.net>
In-Reply-To: <CAHc6FU40HucCUzx5k2obs8m6dXS08NmXBM-tFOq7fSbLduHiGw@mail.gmail.com>
References: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
        <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
        <CAHk-=whbrADQrEezs=-t0QsKw-qaVU_2s2DqxLAkcczxc62SLQ@mail.gmail.com>
        <CAHc6FU40HucCUzx5k2obs8m6dXS08NmXBM-tFOq7fSbLduHiGw@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 22:17:12 +0200
Andreas Gruenbacher <agruenba@redhat.com> wrote:

> Would it make sense to describe how to deal with merge conflicts in
> Documentation/maintainer/pull-requests.rst to stop people from getting
> this wrong over and over again?

I think this certainly belongs in the maintainer manual, but probably not
in pull-requests.rst.  There are a lot of things about repository
management that seem to trip up even experienced maintainers; pre-pull
merges is just one of those.  I would love to see a proper guide on when
and how to do merges in general.

CCing Dan, who has ambitions for the maintainer manual as well, just in
case he has anything in mind here.

Thanks,

jon

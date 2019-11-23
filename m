Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 269E6107F62
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 17:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfKWQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 11:39:27 -0500
Received: from ms.lwn.net ([45.79.88.28]:47560 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfKWQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:39:26 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D99A0867;
        Sat, 23 Nov 2019 16:39:25 +0000 (UTC)
Date:   Sat, 23 Nov 2019 09:39:24 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
Message-ID: <20191123092552.1438bc95@lwn.net>
In-Reply-To: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 18:44:39 -0800 (PST)
Paul Walmsley <paul.walmsley@sifive.com> wrote:

> Formalize, in kernel documentation, the patch acceptance policy for 
> arch/riscv.  In summary, it states that as maintainers, we plan to only 
> accept patches for new modules or extensions that have been frozen or 
> ratified by the RISC-V Foundation.
> 
> We've been following these guidelines for the past few months.  In the
> meantime, we've received quite a bit of feedback that it would be
> helpful to have these guidelines formally documented.

If at all possible, I would really love to have this be part of the
maintainer profile documentation:

	https://lwn.net/ml/linux-kernel/156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com/

...if we could only (hint...CC'd...) get Dan to resubmit it with the
needed tweaks so it could be merged...

Thanks,

jon

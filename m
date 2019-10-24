Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD8E29CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 07:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437479AbfJXF1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 01:27:01 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:29382 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727485AbfJXF1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:27:01 -0400
X-IronPort-AV: E=Sophos;i="5.68,223,1569276000"; 
   d="scan'208";a="407877160"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 07:26:59 +0200
Date:   Thu, 24 Oct 2019 07:26:59 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Paul Burton <paulburton@kernel.org>
cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v2 1/5] staging: octeon: remove
 typedef declaration for cvmx_wqe
In-Reply-To: <20191024050011.2ziewy6dkxkcxzvo@lantea.localdomain>
Message-ID: <alpine.DEB.2.21.1910240722070.2771@hadrien>
References: <cover.1570821661.git.wambui.karugax@gmail.com> <fa82104ea8d7ff54dc66bfbfedb6cca541701991.1570821661.git.wambui.karugax@gmail.com> <20191024050011.2ziewy6dkxkcxzvo@lantea.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you're making significant changes to this driver, please test them
> using the MIPS cavium_octeon_defconfig which is where this driver is
> actually used.
>
> This driver has broken builds a few times recently which makes me very
> tempted to ask that we stop allowing it to be built with COMPILE_TEST.
> The whole octeon-stubs.h thing is a horrible hack anyway...

Wambui,

Please figure out what went wrong here.  Are there two sets of typedefs
that should have been updated?

Others,

Would it be reasonable to put the information about how the driver should
be compied in the TODO file?  git grep cavium_octeon_defconfig in the
octeon directory turns up nothing.

thanks,
julia

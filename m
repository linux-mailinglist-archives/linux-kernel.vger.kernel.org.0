Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45038D51A6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfJLSfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 14:35:41 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:8453 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728636AbfJLSfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:35:41 -0400
X-IronPort-AV: E=Sophos;i="5.67,288,1566856800"; 
   d="scan'208";a="322499627"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2019 20:35:19 +0200
Date:   Sat, 12 Oct 2019 20:35:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wambui Karuga <wambui.karugax@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 0/5] Remove typedef declarations
 in staging: octeon
In-Reply-To: <cover.1570821661.git.wambui.karugax@gmail.com>
Message-ID: <alpine.DEB.2.21.1910122034390.3049@hadrien>
References: <cover.1570821661.git.wambui.karugax@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Oct 2019, Wambui Karuga wrote:

> This patchset removes the addition of new typedefs data types in octeon,
> along with replacing the previous uses with the new declaration format.
>
> v2 of the series removes the obsolete "_t" notation in the named types.
>
> Wambui Karuga (5):
>   staging: octeon: remove typedef declaration for cvmx_wqe
>   staging: octeon: remove typedef declaration for cvmx_helper_link_info
>   staging: octeon: remove typedef declaration for cvmx_fau_reg_32
>   staging: octeon: remove typedef declartion for cvmx_pko_command_word0
>   staging: octeon: remove typedef declaration for cvmx_fau_op_size
>
>  drivers/staging/octeon/ethernet-mdio.c   |  6 +--
>  drivers/staging/octeon/ethernet-rgmii.c  |  4 +-
>  drivers/staging/octeon/ethernet-rx.c     |  6 +--
>  drivers/staging/octeon/ethernet-tx.c     |  4 +-
>  drivers/staging/octeon/ethernet.c        |  6 +--
>  drivers/staging/octeon/octeon-ethernet.h |  2 +-
>  drivers/staging/octeon/octeon-stubs.h    | 56 ++++++++++++------------
>  7 files changed, 43 insertions(+), 41 deletions(-)

For the series:

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

>
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/cover.1570821661.git.wambui.karugax%40gmail.com.
>

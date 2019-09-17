Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2DB51A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfIQPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 11:36:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33671 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728367AbfIQPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:36:59 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8HFaKmh023483
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 11:36:24 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 44B56420811; Tue, 17 Sep 2019 11:36:20 -0400 (EDT)
Date:   Tue, 17 Sep 2019 11:36:20 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] hw_random: don't wait on add_early_randomness()
Message-ID: <20190917153620.GG6762@mit.edu>
References: <20190917095450.11625-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917095450.11625-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 11:54:50AM +0200, Laurent Vivier wrote:
> add_early_randomness() is called by hwrng_register() when the
> hardware is added. If this hardware and its module are present
> at boot, and if there is no data available the boot hangs until
> data are available and can't be interrupted.
> 
> To avoid that, call rng_get_data() in non-blocking mode (wait=0)
> from add_early_randomness().
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Looks good, you can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


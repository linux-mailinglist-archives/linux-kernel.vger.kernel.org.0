Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8655516
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfFYQsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 12:48:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:54208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbfFYQsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:48:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D38AAD4E;
        Tue, 25 Jun 2019 16:48:50 +0000 (UTC)
Date:   Tue, 25 Jun 2019 18:48:48 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, chetjain@in.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: algapi - guard against uninitialized spawn list
 in crypto_remove_spawns
Message-ID: <20190625184848.1b2e5dfe@kitsune.suse.cz>
In-Reply-To: <20190625164052.GA81914@gmail.com>
References: <20190625071624.27039-1-msuchanek@suse.de>
        <20190625164052.GA81914@gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 09:40:54 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

Hello,

> Hi Michal,
> 

> The stack trace shows that crypto_remove_spawns() is being called from
> crypto_unregister_instance().  Therefore, the instance should already be
> registered and have initialized cra_users.  Now, I don't claim to understand the
> spawn lists stuff that well, so I could have missed something; but if there *is*
> a bug, I'd like to see a proper explanation.

Unfortunately, I don't have an explanation either.
> 
> Did you check whether this is actually reproducible on mainline, and not just
> the SUSE v4.12 based kernel?

Mainline crashes on boot:/

Need to find a recent working kernel.

Thanks

Michal

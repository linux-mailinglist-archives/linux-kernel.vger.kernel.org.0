Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A209717337F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 10:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgB1JIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 04:08:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33563 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbgB1JH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582880879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncZBWSzM/kFbj3x0UGhhSEnICwSq6R9DhzO5S1kkIIA=;
        b=UaiisegsfVtEleu+3GQoBL5zAILO7S9tEFfv9DxAvG583XOREimSEyy377GUaWmXvjCinb
        90Pns6OeS8RatH87KJKuY6fRBkwyoTefc8godzXDWzgou9nBbaN/Xgbdlp0YoNLy1uQX87
        UaFSWBEk0/w4WelB9h9JNoNxIULiSf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-i6weTFKaNMi8MuaY3GQJ0w-1; Fri, 28 Feb 2020 04:07:28 -0500
X-MC-Unique: i6weTFKaNMi8MuaY3GQJ0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F29C2190D340;
        Fri, 28 Feb 2020 09:07:26 +0000 (UTC)
Received: from ovpn-118-48.ams2.redhat.com (unknown [10.36.118.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29F6B87B08;
        Fri, 28 Feb 2020 09:07:24 +0000 (UTC)
Message-ID: <938e596f257f782f36c51b849ae7e37f3718c42b.camel@redhat.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Date:   Fri, 28 Feb 2020 10:07:26 +0100
In-Reply-To: <20200228102451.0a3d2057@canb.auug.org.au>
References: <20200228102451.0a3d2057@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 10:24 +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   net/mptcp/protocol.c
> 
> between commit:
> 
>   dc24f8b4ecd3 ("mptcp: add dummy icsk_sync_mss()")
> 
> from the net tree and commit:
> 
>   80992017150b ("mptcp: add work queue skeleton")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thank you, the conflict resolution looks good to me.

I did not notice the conflict beforehands, sorry.

Cheers,

Paolo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CC4144E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 10:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAVJNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 04:13:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbgAVJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579684403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCjUlObpobjgu0XJb3W7s5ESBT52LecxoFq9/8IzvlQ=;
        b=NTRUFIX6cJ9fqLWmbB1lqbyTzkZnUOPOtUst6bFe4KchN7kwfRyRlXrFZhGYZ72azTUQJo
        Cdukkhu44lHedeTs1a8JMjVyEfUFRlEmNOgSPTzcoEPVAVIfJviVjJGQTXZE9VAM8/ayZP
        b6SdpXNda8HAmX4wMIxI1mIMDJFg0eA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-R6n1Yy5NN4SBTwzdELiS9Q-1; Wed, 22 Jan 2020 04:13:21 -0500
X-MC-Unique: R6n1Yy5NN4SBTwzdELiS9Q-1
Received: by mail-wm1-f72.google.com with SMTP id b9so1792325wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 01:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VCjUlObpobjgu0XJb3W7s5ESBT52LecxoFq9/8IzvlQ=;
        b=PestRburDxKIx3IKJ5bzYSDwFlZVhLK1bAxd3ab/fgZ2wg+zdG+DHpqzQkg/pdXUN5
         nIThxROq4T+Bl5oD5DNMwElnpDeuUEHC7vENe3wQyOJNh+7KNqoAuwxiXu583TxjyZ98
         g5U7/rINzsrkHp+AMQJFcsmgpkruiFm9KaLFYzbhH0FRzEgnMuc6+aFBUHuMwdZYPses
         /ApKAyt8gCQgb4ZbHm4CbYV1uEH+QlsJBsRw+aRW3PH5naD8up62yrXmO9MhPAQ98jwZ
         zpSGUGfkPejdwBkpKohUTojQBfx26z8zwoLCb00nHZscmGVe2cO8hDXpntgj9ZfGdquL
         +pfw==
X-Gm-Message-State: APjAAAU/gpGnyyOc3eAlONHwPrH0WlxLJ6kHg1B29XdiIFWz2FxPT1AM
        ZPw6nXuHZhBhtQL+5kSaz7rkTFbObdzt728poKtgCmSN5NhoLMZlh/+5AaNy7KZnGbNvXvWgio+
        eIeomhltyj0PtE6F5fNUNArWc
X-Received: by 2002:a1c:f008:: with SMTP id a8mr1830063wmb.81.1579684400349;
        Wed, 22 Jan 2020 01:13:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOAUFw7NHJnIEiOuVrzpIIsJ1Hl4WYbzk9zmGk9s6D1DD6KOiSk9oXHOw1MLOs5RZStZA8sQ==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr1830038wmb.81.1579684400178;
        Wed, 22 Jan 2020 01:13:20 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id r15sm3049648wmh.21.2020.01.22.01.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 01:13:19 -0800 (PST)
Date:   Wed, 22 Jan 2020 10:13:16 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <20200122091316.zduzvy2txtyqty2p@steredhat>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200121155053.GD641751@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121155053.GD641751@stefanha-x1.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 03:50:53PM +0000, Stefan Hajnoczi wrote:
> What should vsock_dev_do_ioctl() IOCTL_VM_SOCKETS_GET_LOCAL_CID return?
> The answer is probably dependent on the caller's network namespace.

Right, and I'm not handling this case. I'll fix!

> 
> Ultimately we may need per-namespace transports.  Imagine assigning a
> G2H transport to a specific network namespace.

Agree.

> 
> vsock_stream_connect() needs to be namespace-aware so that other
> namespaces cannot use the G2H transport to send a connection
> establishment packet.

Right, maybe I can change the vsock_assign_transport() to check if a
transport can be assigned to a socket, checking the namespace.

I'll send a v2 handling these cases and implementing the Michael's idea
about /dev/vhost-vsock-netns

Thanks,
Stefano


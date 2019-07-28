Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE37815E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 22:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfG1UBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 16:01:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40422 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 16:01:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so57470376eds.7;
        Sun, 28 Jul 2019 13:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ejm20Y4Kz3qQAGjgn7grvGG6B+WvKV1+ZQma7+eIPL8=;
        b=nTGxTS/Jv3FkFSiVUwVt3eU3upA0PZep95o1yMzzmRbpzGHi72LM1Dn91gFiuJVklE
         QK3ewaEcpiveSbu8BDMIplVr3G1Py4DjJSCfYXLzcCXlXFghetCAW8m3JK5PE4x7vpvr
         BzMW23/7hYHfWzSqZ2uczEc8WLZsGPdJe+4oRKJyVZpxev5ObiocjYA3FYyM3XnBKmHU
         MHx+cRFpuye5JMZ8IQGhk7YAf58xXQZ8zU5zGGFAMiXb5r53/mNzfTEhWepzadFjKIS1
         OOspT6d9JMnoMmSmzIAY5tqXiDP/gVK2GaS86dHqlBbPmoe2VEsxj0/NWSjG3YHBwAAL
         3cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ejm20Y4Kz3qQAGjgn7grvGG6B+WvKV1+ZQma7+eIPL8=;
        b=YMEdCJY+QMMl7zhOz7gQqHgHHewBFjFZE78dbc1rrUDI7W3MBUIUG8HrO+JSVA+Ot0
         3S4rm7U0wGMappVdpRRZ1nkonnwa9uQaIDkUrwSbtboBouC+4ZoJpxxY6V4+T/Iw416a
         e2NO/EqMeqXD0fI6wwf/8FPMkxTq7YGdxitD4p+eeUCY6G2bhJvpda2AX5kcWy7XPeWp
         3qd9YzmzreI6w4xWJ+cG4yWqumYbwLvu2B2BMIyw7xuN7aKzx8PN9kZsACaF8wPmaYdp
         A+jsydyUNvn68zMmqkrY2JjfSUoWqoQ0zgbx3mSqLoPCH8dfK9kXQkacZJlxvPPgTbYf
         UmgQ==
X-Gm-Message-State: APjAAAWB9UhIVSdhWCjz5BG3ZH//3s1m0pS/ie3uhvEfweCqzIGU+r7/
        JKlg4HQeLbU6yapNU24pDyM/3i8ym6XUCBxbdFg=
X-Google-Smtp-Source: APXvYqx6e1jH1Ur0aG9EOYYD+HMwXocx7yP4Jc9Kg4wAHeNy/76HfFW+d9490J38ti3/OHDZj+IqVh4q5sOAPqy98MI=
X-Received: by 2002:a17:907:2177:: with SMTP id rl23mr82663915ejb.14.1564344068148;
 Sun, 28 Jul 2019 13:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com>
 <20190724.131324.1545677795217357026.davem@davemloft.net> <CADxRZqw0oCpw=wKUrFTOJF1dUKrCU6k5MQXj3tVGachu4zPcgw@mail.gmail.com>
 <20190727.190929.2229738632787796180.davem@davemloft.net>
In-Reply-To: <20190727.190929.2229738632787796180.davem@davemloft.net>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sun, 28 Jul 2019 23:00:56 +0300
Message-ID: <CADxRZqwv_TUkGsbS5vHsdGXMadjf3MjYbW7WUPEenpa=iSo6PQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
To:     David Miller <davem@davemloft.net>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Christoph Hellwig <hch@lst.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 5:09 AM David Miller <davem@davemloft.net> wrote:
> From: Anatoly Pugachev <matorola@gmail.com>
> Date: Thu, 25 Jul 2019 21:33:24 +0300
> > there's vmlinuz-5.3.0-rc1 kernel and archive 5.3.0-rc1-modules.tar.gz
> > of /lib/modules/5.3.0-rc1/
> > this is from oracle sparclinux LDOM , compiled with 7.4.0 gcc
>
> Please, I really really need the unstripped kernel image with all the
> symbols.  This vmlinuz file is stripped already.  The System.map does
> not serve as a replacement.

David,

http://u164.east.ru/kernel2/

I'm sorry missed debug kernel first. Enabled CONFIG_DEBUG_INFO=y

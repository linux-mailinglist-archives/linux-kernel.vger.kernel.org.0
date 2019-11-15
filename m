Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E06FE034
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKOOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 09:36:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfKOOgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:36:02 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFF4D20733;
        Fri, 15 Nov 2019 14:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573828561;
        bh=zcYNaxA6BKLXVIrEibaKGpyyFgLeOOLcofq3PI+ecco=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PDTXSN7Q9BNaGWYT00xceI6zye3VrA+/YAPDFdajMlZi3HFfpMSjCShVVI6ACm1LF
         CnqbEPAeehgHGiIY2k55fkCm49x2fbA6wLV6Nc4PC+UnE1OyQkQbkgM4Q6YT9F5OvD
         IAxsiV8AQN9KM3gn6gtoyf2oWlnTWcbGpB6r6kkQ=
Subject: Re: [PATCH v4 32/47] serial: ucc_uart: use of_property_read_u32() in
 ucc_uart_probe()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-33-linux@rasmusvillemoes.dk>
 <CAOZdJXU1ELqQh7TitAJW7bsmnj89wq3opJGVizC2B19nL_3_rQ@mail.gmail.com>
 <9f1a846b-c303-92fa-9620-f492ef940de7@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <02dd5acd-b81e-fde3-028c-16e754e846b5@kernel.org>
Date:   Fri, 15 Nov 2019 08:35:58 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9f1a846b-c303-92fa-9620-f492ef940de7@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 2:01 AM, Rasmus Villemoes wrote:
> That would be a separate patch, this patch is only concerned with
> eliminating the implicit assumption of the host being big-endian. And
> there's already been some pushback to adding arch-specific ifdefs (which
> I agree with, but as I responded there see as the lesser evil), so
> unless there's a very good reason to add that complexity, I'd rather not.

We don't want to encourage people to introduce device trees that don't 
have the brg-frequency property in them.

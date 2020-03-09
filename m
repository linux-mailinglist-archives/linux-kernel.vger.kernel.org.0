Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5C17DBDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 09:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCIIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 04:54:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39174 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgCIIyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:54:15 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jBEAK-0007Ty-1N; Mon, 09 Mar 2020 19:53:37 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Mar 2020 19:53:35 +1100
Date:   Mon, 9 Mar 2020 19:53:35 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, miguel.ojeda.sandonis@gmail.com,
        willy@haproxy.com, ksenija.stanojevic@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpm@selenic.com,
        jonathan@buzzard.org.uk, benh@kernel.crashing.org,
        davem@davemloft.net, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com
Subject: Re: [PATCH RFC 1/3] misc: cleanup minor number definitions in c file
 into miscdevice.h
Message-ID: <20200309085335.GA14776@gondor.apana.org.au>
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
 <20200309021747.626-2-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309021747.626-2-zhenzhong.duan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:17:45AM +0800, Zhenzhong Duan wrote:
> HWRNG_MINOR and RNG_MISCDEV_MINOR are duplicate definitions, use
> unified RNG_MINOR instead and moved into miscdevice.h

Please keep the HWRNG_MINOR name, RNG_MINOR could cause confusion.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

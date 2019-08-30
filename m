Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6DA2B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 02:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfH3Amp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 20:42:45 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37239 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbfH3Amp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:42:45 -0400
X-IronPort-AV: E=Sophos;i="5.64,445,1559512800"; 
   d="scan'208";a="399413605"
Received: from unknown (HELO hadrien) ([101.5.32.126])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 02:42:39 +0200
Date:   Fri, 30 Aug 2019 08:42:34 +0800 (CST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] scripts: coccinelle: check for !(un)?likely usage
In-Reply-To: <d2f8cd31-f317-1b28-fb0a-bfb2cf689181@linux.com>
Message-ID: <alpine.DEB.2.21.1908300842060.2184@hadrien>
References: <20190825130536.14683-1-efremov@linux.com> <20190829171013.22956-1-efremov@linux.com> <d2f8cd31-f317-1b28-fb0a-bfb2cf689181@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Aug 2019, Denis Efremov wrote:

> On 8/29/19 8:10 PM, Denis Efremov wrote:
> > This patch adds coccinelle script for detecting !likely and
> > !unlikely usage. These notations are confusing. It's better
> > to replace !likely(x) with unlikely(!x) and !unlikely(x) with
> > likely(!x) for readability.
>
> I'm not sure that this rule deserves the acceptance.
> Just to want to be sure that "!unlikely(x)" and "!likely(x)"
> are hard-readable is not only my perception and that they
> become more clear in form "likely(!x)" and "unlikely(!x)" too.

Is likely/unlikely even useful for anything once it is a subexpression?

julia

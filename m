Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F36137C5D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 09:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAKIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 03:30:23 -0500
Received: from mx.sdf.org ([205.166.94.20]:54569 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgAKIaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 03:30:23 -0500
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 00B8U35n019457
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 11 Jan 2020 08:30:03 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 00B8USV0024843;
        Sat, 11 Jan 2020 08:30:28 GMT
Date:   Sat, 11 Jan 2020 08:30:28 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <202001110830.00B8USV0024843@sdf.org>
To:     samitolvanen@google.com
Subject: Re: [PATCH] lib/list_sort: fix function type mismatches
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, lkml@sdf.org, mchehab+samsung@kernel.org,
        st5pub@yandex.ru
In-Reply-To: <20200110225602.91663-1-samitolvanen@google.com>
References: <20200110225602.91663-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  typedef int __attribute__((nonnull(2,3))) (*cmp_func)(void *,
> -		struct list_head const *, struct list_head const *);
> +		struct list_head *, struct list_head *);

I'd prefer to leave the const there for documentation.
Does anyone object to fixing it in the other direction by *adding*
const to all the call sites?

Andy Shevchenko posted a patch last 7 October that did that.
<20191007135656.37734-1-andriy.shevchenko@linux.intel.com>

(You could also try taking a second look at why __pure doesn't work,
per AKPM's message of 16 April
<20190416154522.65aaa348161fc581181b56d9@linux-foundation.org>)

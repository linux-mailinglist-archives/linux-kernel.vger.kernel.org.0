Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0AD65E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbfJNPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 11:07:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbfJNPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+kPyuVZ7GikTrqAAnx8uWQZ3WSRuJyPoCPBltjrCcIU=; b=cJB7BudpxV9Vm6wrq4Qk6hIVv
        DyQh+zrg8imFWwRvDh9MMDi2m3/9rt/G/uA37uRT3x2WM3cpopzo75xnE8E7X1ZSfbrNbf4TvwJ1+
        0tG+M2W/nl0vg5GBwKNgymmOzQ1/eyMSvFK7wbr36tMh2k4pdyTVwJsuz4D31kp5cjrxc8TCITP+Y
        UlshVemVVvhOecv5XKlOseJbjLRsEeGsfHIQsWb5nwByuG0WWZQOpzh5YTZv50Zj3c5lsA4u2GH6m
        vMakhz9E8vEv0duQezUftGWkwJsmmsUk7DwzQldagIOxxU4+dT7e9OCsTR5f4bA5R1+LHmEKrxwbR
        P6jvq0fOg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK1wE-0000ND-79; Mon, 14 Oct 2019 15:07:10 +0000
Date:   Mon, 14 Oct 2019 08:07:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH 2/2] kasan: add test for invalid size in memmove
Message-ID: <20191014150710.GY32665@bombadil.infradead.org>
References: <20191014103654.17982-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014103654.17982-1-walter-zh.wu@mediatek.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 06:36:54PM +0800, Walter Wu wrote:
> Test size is negative numbers in memmove in order to verify
> whether it correctly get KASAN report.

You're not testing negative numbers, though.  memmove() takes an unsigned
type, so you're testing a very large number.

